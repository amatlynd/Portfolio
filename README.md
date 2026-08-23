# lyndonamat.com

Personal site — static, built with [Astro](https://astro.build).

Previously a Flutter Web app. Flutter renders to a `<canvas>`, so crawlers,
link-preview bots and résumé parsers fetched the page and got a `<title>` with
nothing underneath it. This version is plain HTML at build time: ~44 KB total,
no client framework, ~1 KB of inline JS for the theme toggle and scroll reveals.

## Develop

```bash
npm install
npm run dev      # http://localhost:4321
npm run build    # -> dist/
npm run preview
```

## Content

Copy, projects and the tech list live in `src/data/site.ts` — edit that, not the
markup, for routine updates.

## Deploy

Push to `main`. GitHub Actions builds and publishes `dist/` to the `gh-pages`
branch, which GitHub Pages serves at **lyndonamat.com** (`public/CNAME`).

The previous Flutter source is preserved on the `flutter-web` branch.
