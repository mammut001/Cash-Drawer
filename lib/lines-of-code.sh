#!/bin/bash

current_datetime=$(date +"%Y-%m-%d %H:%M:%S")

dev_log_dir="./dev_logs/"
file_name="$dev_log_dir$(date +"%Y-%m-%d").txt"
mkdir -p $dev_log_dir

# shellcheck disable=SC2129
echo "$current_datetime" >> "$file_name"

find . -path ./cmake-build-debug -prune -o -name '*.dart' -print0 | xargs -0 wc -l >> "$file_name"

echo "-------------------" >> "$file_name"
