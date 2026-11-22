#!/usr/bin/env bash
# Rebuilds the hosted web version from the latest standalone game.
# Usage: bash build.sh   (run from anywhere)
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
SRC="$HERE/../playtest/CoverDash.html"
ICONS="$HERE/../icon"
cp "$ICONS/icon-512.png" "$HERE/icon-512.png"
python3 - "$ICONS/icon-1024.png" "$HERE" <<'PY'
import sys
from PIL import Image
src, out = sys.argv[1], sys.argv[2]
im = Image.open(src).convert("RGBA")
for s, name in [(192, "icon-192.png"), (180, "apple-touch-icon.png")]:
    im.resize((s, s), Image.LANCZOS).convert("RGB").save(f"{out}/{name}")
PY
python3 - "$SRC" "$HERE/index.html" <<'PY'
import sys
src, dst = sys.argv[1], sys.argv[2]
html = open(src, encoding="utf-8").read()
tags = """<link rel="manifest" href="manifest.webmanifest">
<link rel="icon" type="image/png" sizes="192x192" href="icon-192.png">
<link rel="apple-touch-icon" href="apple-touch-icon.png">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="apple-mobile-web-app-title" content="Cover Dash">
"""
assert "<title>" in html
html = html.replace("<title>", tags + "<title>", 1)
open(dst, "w", encoding="utf-8").write(html)
PY
echo "Built $HERE/index.html from $SRC"
