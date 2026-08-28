# build a carapace command tree from a flat list of {path: [seg...], description: string}
def build-tree [entries: list, depth: int] {
    $entries
    | group-by { |e| $e.path | get $depth }
    | transpose name group
    | each { |g|
        let node_name = $g.name
        let items = $g.group

        # a "leaf" here is an entry whose path ends exactly at this depth
        # (e.g. the bare `omarchy weather` command itself, vs `weather location`)
        let leaf = ($items | where { |e| ($e.path | length) == ($depth + 1) })
        let deeper = ($items | where { |e| ($e.path | length) > ($depth + 1) })

        let description = if ($leaf | is-empty) {
            $"($node_name) commands"
        } else {
            $leaf.0.description
        }

        if ($deeper | is-empty) {
            { name: $node_name, description: $description }
        } else {
            { name: $node_name, description: $description, commands: (build-tree $deeper ($depth + 1)) }
        }
    }
}

def gen-omarchy-spec [] {
    let raw = (omarchy commands --json | from json | get commands)

    let entries = ($raw
        | where hidden == false
        | each { |c|
            let extra = if ($c.name | str trim | is-empty) { [] } else { $c.name | split row ' ' }
            { path: ([$c.group] | append $extra), description: $c.summary }
        })

    {
        name: "omarchy"
        description: "Omarchy command center"
        commands: (build-tree $entries 0)
    }
    | to yaml
    | save -f ~/.config/carapace/specs/omarchy.yaml
}
