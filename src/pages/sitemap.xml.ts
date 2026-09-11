import type { APIRoute } from 'astro';
import { site } from '../data/site';

// robots.txt advertises this URL, so it has to exist. One page today; the map
// is generated rather than hand-maintained so extra routes can't fall out of it.
const pages = ['/'];
const lastmod = new Date().toISOString().slice(0, 10);

export const GET: APIRoute = () => {
  const urls = pages
    .map((p) => `  <url>\n    <loc>${new URL(p, site.url).href}</loc>\n    <lastmod>${lastmod}</lastmod>\n    <changefreq>monthly</changefreq>\n    <priority>${p === '/' ? '1.0' : '0.7'}</priority>\n  </url>`)
    .join('\n');
  return new Response(
    `<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n${urls}\n</urlset>\n`,
    { headers: { 'Content-Type': 'application/xml; charset=utf-8' } },
  );
};
