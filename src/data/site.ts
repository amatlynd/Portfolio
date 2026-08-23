export const site = {
  name: 'Lyndon Amat',
  role: 'Software Developer',
  location: 'Toronto, Canada',
  url: 'https://lyndonamat.com',
  email: 'lyndon.amat@gmail.com',
  github: 'https://github.com/amatlynd',
  linkedin: 'https://www.linkedin.com/in/lyndon-amat/',
  status: 'Open to opportunities',
  description:
    'Lyndon Amat is a software developer in Toronto building cross-platform mobile apps with Flutter and product on the web with Next.js, React and TypeScript.',
};

export const stack: { group: string; items: string[] }[] = [
  { group: 'Mobile',   items: ['Flutter', 'Dart', 'Riverpod', 'go_router', 'Firebase'] },
  { group: 'Web',      items: ['Next.js', 'React', 'TypeScript', 'Redux Toolkit', 'Tailwind CSS', 'Astro'] },
  { group: 'Backend',  items: ['Java', 'Spring', 'REST APIs', 'Python', 'SQLite'] },
  { group: 'Tooling',  items: ['Git', 'GitHub Actions', 'Playwright', 'Docker'] },
];

export type Project = {
  slug: string;
  title: string;
  blurb: string;
  body: string[];
  year: string;
  tags: string[];
  href?: string;
  hrefLabel?: string;
  note?: string;
};

export const projects: Project[] = [
  {
    slug: 'okonomi',
    title: 'Okonomi',
    blurb: 'A pantry app for cooking from what you already have.',
    body: [
      'Scan a barcode to put groceries into the pantry, see what you actually have on hand, and let the shopping list build itself out of the gaps. The idea is boring on purpose: most food waste is just not knowing what is already in the cupboard.',
      'Flutter throughout, with Firebase Auth and Cloud Firestore behind it for sign-in and sync, Riverpod for state, go_router for navigation and mobile_scanner for barcode capture. Feature-first structure — auth, pantry, shopping each own their slice — with 28 test files over the core.',
    ],
    year: '2026',
    tags: ['Flutter', 'Dart', 'Firebase', 'Riverpod'],
    note: 'Private repo · in development',
  },
  {
    slug: 'portfolio',
    title: 'This site',
    blurb: 'Rebuilt from a Flutter Web app that search engines could not read.',
    body: [
      'The previous version of lyndonamat.com was a Flutter Web build. It looked fine to a person and was invisible to everything else — Flutter paints to a canvas, so a crawler, a link preview or a résumé parser fetching the page got a title tag and nothing underneath it. For a site whose whole job is being read by people who have never met me, that is a bad trade.',
      'So it is static now: Astro, rendered to plain HTML at build time, no client framework, around a kilobyte of JavaScript for the theme toggle and the scroll reveals. Same colours, same domain, roughly two megabytes lighter. GitHub Actions builds it and publishes to GitHub Pages on every push.',
    ],
    year: '2026',
    tags: ['Astro', 'TypeScript', 'CSS', 'GitHub Actions'],
    href: 'https://github.com/amatlynd/Portfolio',
    hrefLabel: 'Source',
  },
];
