#!/usr/bin/env nu

const CONTRACT_VERSION = 1
const RETENTION_WINDOW = 365day
const CONTRACT_PATH = $nu.home-dir | path join ".local/state/omarchy" "calendar-events.json"

# SQL used to read events (and their recurrence rule, if any) from the
# Thunderbird cache database.
const EVENT_QUERY = "select
  e.id,
  e.cal_id,
  e.event_start,
  e.event_end,
  (e.flags & 8) != 0 as all_day, -- bit 3 (value 8) marks an all-day event
  e.title,
  r.icalString as rrule
from
  cal_events e
  left join cal_recurrence r on e.id = r.item_id
where
  r.icalString like 'RRULE:%'
  or r.icalString is null;
"

# Resolve the path to the active Thunderbird profile folder.
def get-tb-profile-folder [tb_path?: path] {
    let base = $tb_path | default ($nu.home-dir | path join ".thunderbird")
    let ini = $base | path join "profiles.ini"

    if not ($ini | path exists) {
        error make {msg: $"profiles.ini not found at ($ini)"}
    }

    if not (plugin list | get name | any {$in == "formats" }) {
        plugin add nu_plugin_formats
    }

    # `open` parses the INI into a record keyed by section name; `transpose`
    # turns that record into rows so we can filter the "Install*" section.
    let profile = (
        open $ini
        | transpose section data
        | where {|row| $row.section starts-with "Install" }
        | get data.Default
        | first
    )

    if $profile == null {
        error make {msg: "No default profile found in profiles.ini"}
    }

    $base | path join $profile | path expand
}

# Read calendar id/name/color metadata from Thunderbird's prefs.js.
def get-calendar-metadata [profile_folder: path] {
    open ($profile_folder | path join "prefs.js")
    | lines
    | where {|line| $line starts-with 'user_pref("calendar.registry.' }
    | parse 'user_pref("calendar.registry.{id}.{key}", {value});'
    | update value {|row| $row.value | str trim --char '"' }
    | group-by id
    | items { |id, rows|
        let name = $rows | where key == "name" | get value | first
        let color = $rows | where key == "color" | get value | first
        {
            id: $id
            name: ($name | default "")
            color: ($color | default "")
        }
    }
}

# Convert a Thunderbird Unix timestamp (microseconds since the epoch) to a
# datetime. Falls back to "now" if parsing fails.
def tb-unix-to-datetime [] {
    try {
        let ts = ($in / 1000000) | into int
        if $ts < 0 {
            (0 | into datetime -f '%s') - ($ts * -1sec)
        } else {
            $ts | into datetime -f '%s'
        }
    } catch {
        date now
    }
}

# Expand an RRULE into its concrete occurrence datetimes.
def expand-rrule [start_date: datetime, rrule: string] {
    let dtstart = $start_date | format date "%Y%m%dT%H%M%SZ"
    (
        ^rrule $"DTSTART:($dtstart)\n($rrule)"
        | lines
        | each {|line| $line | into datetime }
    )
}

# Expand an occurrence's date range into the list of calendar days it spans.
# All-day events use an exclusive end (the end timestamp is midnight of the day
# after the last visible day), so they span `span_days` days rather than
# `span_days + 1`.
def span-date-keys [start: datetime, end: datetime, all_day: bool] {
    let start_day = $start | format date "%Y-%m-%d"
    let end_day = $end | format date "%Y-%m-%d"

    let span_days = (
        (($end_day | into datetime) - ($start_day | into datetime)) / 1day
        | into int
    )

    let day_count = if $all_day {
        [$span_days 1] | math max
    } else {
        $span_days + 1
    }

    seq date --begin-date $start_day --days $day_count --increment 1day
}

# Atomically write the piped-in data to `path`: write to a temp file in the
# same directory, then rename it into place.
def write-atomic [path: path] {
    let dir = $path | path dirname
    mkdir $dir

    let temp_path = (^mktemp -p $dir --suffix ".tmp")
    $in | save --force $temp_path
    mv $temp_path $path
}

# Read events from the cache database and normalize them, expanding recurring
# events into their individual occurrences.
def get-events [db_path: path, metadata: list<any>] {
    let raw_events = (
        open $db_path
        | query db $EVENT_QUERY
    )

    let events_with_meta = (
        $raw_events
        | join -l $metadata cal_id id
    )

    $events_with_meta
    | each { |event|
        let start = $event.event_start | tb-unix-to-datetime
        let end = $event.event_end | tb-unix-to-datetime
        let duration = $end - $start

        let occurrence_starts = if ($event.rrule != null) {
            expand-rrule $start $event.rrule
        } else {
            [$start]
        }

        $occurrence_starts
        | each { |occ_start|
            let occ_end = $occ_start + $duration
            let date_keys = span-date-keys $occ_start $occ_end ($event.all_day | into bool)

            $date_keys
            | each --flatten { |date_key|
                {
                    id: $event.id
                    calendarId: $event.cal_id
                    calendarName: ($event.name | default "")
                    color: ($event.color | default "")
                    dateKey: $date_key
                    start: $occ_start
                    end: $occ_end
                    allDay: $event.all_day
                    title: $event.title
                    location: "",
                    rrule: $event.rrule
                }
            }
        }
    }
    | flatten
    | flatten
    | uniq-by title dateKey
}

# Document building
# ---------------------------------------------------------------------------

# Assemble the final document record.
def build-document [events: list<any>] {
    {
        version: $CONTRACT_VERSION
        events: $events
        syncedAt: (date now)
        source: "thunderbird"
    }
}

# Drop events older than the retention window, build the document, and
# atomically write it to disk.
def write-document [events: list<any>] {
    let cutoff = (date now) - $RETENTION_WINDOW

    let recent_events = $events
    | where { |event|
            let event_date = $event.dateKey | into datetime
            $event_date >= $cutoff
        }

    build-document $recent_events
    | to json
    | write-atomic $CONTRACT_PATH
}

def main [] {
    let profile_folder = (get-tb-profile-folder)
    let metadata = (get-calendar-metadata $profile_folder)
    let source_db = $profile_folder | path join "calendar-data" "cache.sqlite"

    let tmp_dir = (^mktemp -d)
    let tmp_db = $tmp_dir | path join "cache.sqlite"

    try {
        cp $source_db $tmp_db
        let events = (get-events $tmp_db $metadata)
        write-document $events
    } catch {|err| error make {msg: $"Calendar sync failed: ($err.msg)"} } finally {
        rm -rf $tmp_dir
    }
}
