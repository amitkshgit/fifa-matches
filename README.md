# FIFA Matches

A small FIFA World Cup 2026 match-day viewer.

The repo includes:

- `web/`: a mobile web app / PWA you can open on your phone.
- `FifaMatches/`: a SwiftUI iOS starter app.

The initial data set includes the fixtures for Tuesday, June 16, 2026:

- France vs Senegal at 12:00 PM PT
- Iraq vs Norway at 3:00 PM PT
- Argentina vs Algeria at 6:00 PM PT
- Austria vs Jordan at 9:00 PM PT

## Run the PWA locally

From this folder:

```sh
python3 -m http.server 8080 -d web
```

Then open `http://localhost:8080` on your computer.

To use it on your iPhone, host the `web/` folder somewhere HTTPS-enabled, such as GitHub Pages, Netlify, or Vercel. Open the URL in Safari, tap Share, then Add to Home Screen.

## Deploy to GitHub Pages

This repo includes a GitHub Actions workflow at `.github/workflows/pages.yml` that publishes the `web/` folder.

1. Push the repo to GitHub.
2. In GitHub, open Settings > Pages.
3. Set Source to GitHub Actions.
4. Push to `master` or run the workflow manually from the Actions tab.

## Run the iOS app

1. Open `FifaMatches.xcodeproj` in Xcode.
2. Select an iPhone simulator.
3. Press Run.

## Update fixtures

For the PWA, edit `web/app.js`.

For the iOS app, edit `FifaMatches/Match.swift` and add more `Match` values to `Match.worldCup2026`.
