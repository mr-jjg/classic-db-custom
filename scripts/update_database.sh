#!/usr/bin/env bash
set -euo pipefail

# Prompt for MySQL password
read -rsp 'Enter MySQL password: ' MYSQL_PASS
echo

# Resolve repo root from this script's location
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"

PATCH_DIR="$REPO_ROOT/patches"

if [[ ! -d "$PATCH_DIR" ]]; then
  echo "ERROR: Patch directory not found: $PATCH_DIR" >&2
  exit 1
fi

shopt -s nullglob
PATCH_FILES=("$PATCH_DIR"/*.sql)

if (( ${#PATCH_FILES[@]} == 0 )); then
  echo "No .sql files found in $PATCH_DIR"
  unset MYSQL_PASS
  exit 0
fi

# Apply patches in lexical order (0001_, 0002_, ...)
IFS=$'\n' PATCH_FILES_SORTED=($(printf '%s\n' "${PATCH_FILES[@]}" | sort))
unset IFS

for sql_file in "${PATCH_FILES_SORTED[@]}"; do
  filename="$(basename -- "$sql_file")"
  echo "Running $filename..."

  # Use MYSQL_PWD to avoid showing password in process args
  MYSQL_PWD="$MYSQL_PASS" mysql -u dbm v_mangos < "$sql_file"

  echo "$filename executed successfully."
done

# Clear password variable for security
unset MYSQL_PASS
