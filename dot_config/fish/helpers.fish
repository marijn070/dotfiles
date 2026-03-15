# Remove an image background
function remove-background
    if test (count $argv) -eq 0
        echo "Usage: remove-background <input_image>"
        return 1
    end
    set -l input "$argv[1]"
    set -l base (string replace -r '\.[^.]*$' '' "$input")
    set -l ext (string match -r '\.[^.]*$' "$input")
    magick "$input" -background none -flatten "$base"_no_bg"$ext"
end

# Compression
function compress
    set -l input (string trim -r -c '/' "$argv[1]")
    tar -czf "$input.tar.gz" "$input"
end

alias decompress="tar -xzf"

# Write iso file to sd card
function iso2sd
    if test (count $argv) -ne 2
        echo "Usage: iso2sd <input_file> <output_device>"
        echo "Example: iso2sd ~/Downloads/ubuntu-25.04-desktop-amd64.iso /dev/sda"
        echo -e "\nAvailable SD cards:"
        lsblk -d -o NAME | grep -E '^sd[a-z]' | awk '{print "/dev/"$1}'
    else
        sudo dd bs=4M status=progress oflag=sync if="$argv[1]" of="$argv[2]"
        sudo eject $argv[2]
    end
end

# Format an entire drive for a single partition using exFAT
function format-drive
    if test (count $argv) -ne 2
        echo "Usage: format-drive <device> <name>"
        echo "Example: format-drive /dev/sda 'My Stuff'"
        echo -e "\nAvailable drives:"
        lsblk -d -o NAME -n | awk '{print "/dev/"$1}'
    else
        echo "WARNING: This will completely erase all data on $argv[1] and label it '$argv[2]'."
        read -l -p "Are you sure you want to continue? (y/N): " confirm

        if string match -q -r '^[Yy]$' "$confirm"
            sudo wipefs -a "$argv[1]"
            sudo dd if=/dev/zero of="$argv[1]" bs=1M count=100 status=progress
            sudo parted -s "$argv[1]" mklabel gpt
            sudo parted -s "$argv[1]" mkpart primary 1MiB 100%

            if string match -q '*nvme*' "$argv[1]"
                set -l partition "$argv[1]p1"
            else
                set -l partition "$argv[1]1"
            end

            sudo partprobe "$argv[1]" || true
            sudo udevadm settle || true

            sudo mkfs.exfat -n "$argv[2]" "$partition"

            echo "Drive $argv[1] formatted as exFAT and labeled '$argv[2]'."
        end
    end
end

# Transcode a video to a good-balance 1080p that's great for sharing online
function transcode-video-1080p
    set -l base (string replace -r '\.[^.]*$' '' "$argv[1]")
    ffmpeg -i "$argv[1]" -vf scale=1920:1080 -c:v libx264 -preset fast -crf 23 -c:a copy "$base-1080p.mp4"
end

# Transcode a video to a good-balance 4K that's great for sharing online
function transcode-video-4K
    set -l base (string replace -r '\.[^.]*$' '' "$argv[1]")
    ffmpeg -i "$argv[1]" -c:v libx265 -preset slow -crf 24 -c:a aac -b:a 192k "$base-optimized.mp4"
end

# Transcode any image to JPG image that's great for shrinking wallpapers
function img2jpg
    set -l img "$argv[1]"
    set -l args $argv[2..]
    set -l base (string replace -r '\.[^.]*$' '' "$img")
    magick "$img" $args -quality 95 -strip "$base-optimized.jpg"
end

# Transcode any image to JPG image that's great for sharing online without being too big
function img2jpg-small
    set -l img "$argv[1]"
    set -l args $argv[2..]
    set -l base (string replace -r '\.[^.]*$' '' "$img")
    magick "$img" $args -resize 1080x\> -quality 95 -strip "$base-optimized.jpg"
end

# Transcode any image to compressed-but-lossless PNG
function img2png
    set -l img "$argv[1]"
    set -l args $argv[2..]
    set -l base (string replace -r '\.[^.]*$' '' "$img")
    magick "$img" $args -strip -define png:compression-filter=5 \
        -define png:compression-level=9 \
        -define png:compression-strategy=1 \
        -define png:exclude-chunk=all \
        "$base-optimized.png"
end
