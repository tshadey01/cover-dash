# Cover Dash web link: how to update

The hosted site is everything in this `web/` folder.

1. When `playtest/CoverDash.html` changes, run `bash cover-dash/web/build.sh`.
   It rebuilds `index.html` (adds home-screen install tags) and the icons.
2. Push the folder to the GitHub Pages repo (Claude can do this when GitHub is connected),
   or drag the `web/` folder onto https://app.netlify.com/drop.
3. Friends just reload the link. Home-screen copies update on next open.

Install on iPhone: open the link in Safari, tap Share, then "Add to Home Screen".
Install on Android: open in Chrome, menu, "Add to Home screen" / "Install app".
