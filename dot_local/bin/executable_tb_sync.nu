#!/usr/bin/env nu
let TB_PATH = ($nu.home-dir | path join ".thunderbird")
let TMP_DIR = "/tmp"
let CONTRACT_VERSION = 1
let CONTRACT_PATH = ($nu.home-dir | path join ".local/state/omarchy/calendar-events.json")

def find-profile [] {
    cd $TB_PATH
    open profiles.ini
    | transpose section data
    | where section starts-with "Install"
    | each { |i| $i.data.Default }
    | uniq
    | where { |p| ($p | path expand | path exists) }
    | first
    | path expand
}

def get_calendar_metadata [] {
    open (find-profile | path join "prefs.js")
    | lines
    | where {|l| $l starts-with 'user_pref("calendar.registry.' }
    | parse 'user_pref("calendar.registry.{id}.{key}", {value});'
    | update value {|r| $r.value | str trim -c '"'}
    | group-by id
    | items {|id, data|
        let name = $data | where key == "name" | get value | first
        let color = $data | where key == "color" | get value | first
        {id: $id, name: $name, color: $color}
    }
}

def tb_unix_to_datetime [] {
    try {
        let timestamp = ($in / 1000000) | into int
        if $timestamp < 0 {
            (0 | into datetime -f '%s') - ($timestamp * -1sec)
        } else {
            $timestamp | into datetime -f '%s'
        }
    } catch {
        date now
    }
}

def get-rrules [db_path] {
    open $db_path
    | get cal_recurrence
    | each {|item|
        {item_id: $item.item_id?, cal_id: $item.cal_id, rrule: $item.icalString?}
    }
}

def get-events [db_path] {
    let cal_metadata = get_calendar_metadata
    let rrules = get-rrules $db_path
    let events = open $db_path
    | get cal_events
    | join -l $rrules id item_id

    $events
    | each { |event|

        let start = $event.event_start | tb_unix_to_datetime
        let end = $event.event_end | tb_unix_to_datetime

        {
        id: $event.id,
        calendarId: $event.cal_id,
        calendarName: ($cal_metadata | where id == $event.cal_id | get name | first),
        color: ($cal_metadata | where id == $event.cal_id | get color | first),
        dateKey: ($start | format date "%Y-%m-%d"),
        start: $start,
        end: $end,
        allDay: false,
        title: $event.title,
        location: "",
        rrule: $event.rrule,
    }
    }
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
            let one_month_ago = (date now) - 30day
            $event_date >= $one_month_ago
        }

    build-document $events
    | to json
    | save -f $CONTRACT_PATH
}

def main [] {
    let profile = find-profile
    let source_db = $profile | path join "calendar-data" | path join "cache.sqlite"

    # Create a private temporary directory.
    let tmp_dir = (^mktemp -d | str trim)
    let tmp_db = $tmp_dir | path join "cache.sqlite"

    try {
        # Copy the db to the temp dir
        cp $source_db $tmp_db

        let events = get-events $tmp_db

        write-document $events
    } catch {|err|
        error make {
            msg: $"Calendar sync failed: ($err.msg)"
        }
    } finally {
        rm -rf $tmp_dir
    }
}
