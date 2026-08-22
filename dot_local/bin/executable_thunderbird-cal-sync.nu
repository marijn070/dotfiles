#!/usr/bin/env nu


const EVENT_QUERY = "select
  e.id,
  e.cal_id,
  e.event_start,
  e.event_end,
  (e.flags & 8) != 0 as all_day, -- bit mask operation, 3 position is for the all_day flag
  e.title,
  r.icalString as rrule
from
  cal_events e
  left join cal_recurrence r on e.id = r.item_id
where
  r.icalString like 'RRULE:%'
  or r.icalString is null;
"

const CONTRACT_VERSION = 1
const CONTRACT_PATH = ($nu.home-dir | path join ".local/state/omarchy/calendar-events.json")
const QUERY_PATH = (path self | path dirname | path join "sql" "events.sql")

def get-tb-profile-folder [tb_path?: path] {
    let base = if $tb_path != null { $tb_path } else { $nu.home-dir | path join ".thunderbird" }
    let ini = ($base | path join "profiles.ini")

    if not ($ini | path exists) { error make {msg: $"profiles.ini not found at ($ini)"} }

    let profile = (open $ini | transpose section data | where section starts-with "Install" | get data.Default | first)

    if ($profile == null) { error make {msg: "No default profile found in profiles.ini"} }

    $base | path join $profile | path expand
}

def get-calendar-metadata [profile_folder: path] {
    open ($profile_folder | path join "prefs.js")
    | lines
    | where { |l| $l starts-with 'user_pref("calendar.registry.' }
    | parse 'user_pref("calendar.registry.{id}.{key}", {value});'
    | update value { |r| $r.value | str trim -c '"' }
    | group-by id
    | items { |id, data|
        let name = ($data | where key == "name" | get value | first)
        let color = ($data | where key == "color" | get value | first)
        {
            id: $id,
            name: (if $name != null { $name } else { "" }),
            color: (if $color != null { $color } else { "" })
        }
    }
}

def expand-rrule [start_date: datetime, rrule: string] {
    let dtstart = $start_date | format date "%Y%m%dT%H%M%SZ"
    (^rrule $"DTSTART:($dtstart)\n($rrule)" | lines | each { |it| $it | into datetime })
}

def tb-unix-to-datetime [] {
    try {
        let ts = ($in / 1000000) | into int
        if $ts < 0 { (0 | into datetime -f '%s') - ($ts * -1sec) } else { $ts | into datetime -f '%s' }
    } catch { date now }
}

def write-atomic [path: path] {
    let temp_path = mktemp --suffix ".tmp"
    $in | save -f $temp_path
    mv $temp_path $path
}

def get-events [db_path: path, metadata: any] {
    let raw_events = (open $db_path | query db $EVENT_QUERY)

    # Join events with metadata
    let events_with_meta = $raw_events | join -l $metadata cal_id id

    $events_with_meta | each { |event|
        let start = $event.event_start | tb-unix-to-datetime
        let end = $event.event_end | tb-unix-to-datetime
        let duration = $end - $start

        let occurrence_starts = if ($event.rrule != null) { expand-rrule $start $event.rrule } else { [$start] }

        $occurrence_starts | each {|occ_start|
            let occ_end = $occ_start + $duration
            {
                id: $event.id,
                calendarId: $event.cal_id,
                calendarName: ($event.name | default ""),
                color: ($event.color | default ""),
                dateKey: ($occ_start | format date "%Y-%m-%d"),
                start: $occ_start,
                end: $occ_end,
                allDay: $event.all_day,
                title: $event.title,
                location: "",
                rrule: $event.rrule,
            }
        }
    } | flatten | uniq-by title dateKey
}


def build-document [events] {
    {
        version: $CONTRACT_VERSION
        events: $events
        syncedAt: (date now)
        source: "thunderbird"
    }
}

def write-document [events] {
    let events = $events
    | where {|event|
            let event_date = $event.dateKey | into datetime
            let one_year_ago = (date now) - 365day
            $event_date >= $one_year_ago
        }

    build-document $events
    | to json
    | write-atomic $CONTRACT_PATH
}

def main [] {
    let profile_folder = get-tb-profile-folder
    let metadata = get-calendar-metadata $profile_folder
    let source_db = $profile_folder | path join "calendar-data" | path join "cache.sqlite"

    let tmp_dir = (^mktemp -d | str trim)
    let tmp_db = $tmp_dir | path join "cache.sqlite"

    try {
        cp $source_db $tmp_db

        let events = get-events $tmp_db $metadata

        write-document $events
    } catch {|err|
        error make {msg: $"Calendar sync failed: ($err.msg)"}
    } finally {
        rm -rf $tmp_dir
    }
}

main
