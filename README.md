# liuyuanru123.github.io

Personal academic homepage for **Yuanru Liu** — served at <https://liuyuanru123.github.io/>.

Static site, no build step. Plain HTML/CSS/JS.

## Local preview

Open `index.html` directly in a browser, or run any static file server:

```powershell
python -m http.server 8080
# then visit http://localhost:8080
```

## Customize

- Replace the placeholder avatar by dropping a square image at `assets/img/profile.jpg`
  and replacing the `<div class="avatar-placeholder">YL</div>` block in `index.html`
  with `<img src="assets/img/profile.jpg" alt="Yuanru Liu" />`.
- Edit content directly in `index.html`. Each translatable element has two
  spans: `<span class="lang-ja">日本語</span><span class="lang-en">English</span>`.
- The language toggle lives in the top-right of `<header class="topbar">` and is
  driven by `assets/js/i18n.js` (default: Japanese, persisted in `localStorage`).

## Deploy

This repo deploys to GitHub Pages automatically. After pushing, Pages serves from
the `main` branch at the URL above. The `.nojekyll` file disables Jekyll processing.
