#!/usr/bin/env bash
set -eo pipefail

trap 'echo -e "\n[!] Operation cancelled by user (Ctrl+C). Aborting..." >&2; exit 130' INT

if ! command -v bluebuild &> /dev/null; then
    if command -v cargo &> /dev/null; then
        echo "bluebuild not found. Installing via cargo..."
        cargo install --locked blue-build || {
            echo "Error: Failed to install bluebuild via cargo. Aborting." >&2
            exit 1
        }
    else
        echo "Error: Neither 'bluebuild' nor 'cargo' was found on your system." >&2
        echo "Please install cargo (rustup) or bluebuild first." >&2
        exit 1
    fi
fi
BLUEBUILD_BIN="$(command -v bluebuild)"

sudo "$BLUEBUILD_BIN" generate-iso --iso-name fred-kde.iso image ghcr.io/fredolx/fred-kde:latest