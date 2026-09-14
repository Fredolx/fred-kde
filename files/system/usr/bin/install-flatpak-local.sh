#!/usr/bin/env bash
set -euo pipefail

trap 'exit 130' INT TERM

APP_ID="org.flatpak.Builder"

if ! flatpak list --user --app --columns=application | grep -qx "$APP_ID"; then
    flatpak install --user -y flathub "$APP_ID"
fi

flatpak run "$APP_ID" --force-clean --user --install-deps-from=flathub --repo=repo --install builddir "$@"
