# Recipe to Markdown

A single-file web page that turns a recipe URL into clean markdown. No build
step, no dependencies, no API keys — one `index.html` that works opened
straight from disk or served from any static file server.

## What you get

Paste a recipe URL and the page produces markdown in this exact shape:

```markdown
# Recipe Name

> From: https://example.com/recipe

## Ingredients

- 1 cup flour

**For the topping:**

- 2 tbsp sugar

## Instructions

1. Mix it.
1. Bake it.

## Notes

Only added when the source has author notes.
```

The output lands in an editable textarea with a one-click **Copy** button, so
you can tweak wording before copying.

## How it works

Everything runs in your browser; there is no backend.

1. **Fetch.** The page tries a direct browser fetch first. Most recipe sites
   block cross-origin reads (CORS), so blocked requests retry through a chain
   of free public proxies: corsfix, allorigins, codetabs, then cors.lol. Each
   failure falls through to the next in well under a second.
2. **Parse.** The downloaded HTML is parsed in three stages, first match wins:
   - schema.org **JSON-LD** `Recipe` structured data (walks `@graph`,
     handles `HowToStep`, `HowToSection`, `ItemList`, and embedded HTML)
   - **microdata** (`itemprop` attributes)
   - **DOM heuristics** — finds ingredient/instruction sections by class and
     id names, preserving group headings like "For the crust"
3. **Render.** A shared renderer formats the parsed recipe into the markdown
   template above.

If every stage fails — or the site blocks all download attempts (allrecipes,
for example, blocks every public proxy) — the page shows an error and
auto-opens the **paste fallback**: save the page in your browser as
"Web Page, HTML only", open the file, copy everything, and paste it into the
page. Pasted HTML runs through the same parser chain, and if the URL field is
still filled in, the `> From:` line is kept.

Two caveats worth knowing:

- The proxies are free public services and individually unreliable (when this
  was built, allorigins was down and corsproxy.io had gone paid-key-only).
  The chain exists so one outage doesn't break the page; the paste fallback
  covers total failure.
- Recipe HTML fetched through a proxy passes through that third-party service.
  If that matters to you, use the paste path, which is fully local.

## Deploy

### Docker

Serves the page on port 8002 from a ~5 MB busybox image:

```
docker compose up -d --build
```

Then open `http://<host>:8002`.

### Without Docker

Any static file server works, for example:

```
python3 -m http.server 8002
```

or just double-click `index.html` to open it from disk. Served-over-HTTP is
the better option: the first proxy in the chain (corsfix) accepts real web
origins like `http://localhost:8002` but rejects the null origin of a
`file://` page.

## Limitations

- `## Notes` only appears via the heuristics parser; schema.org's Recipe type
  has no standard notes field, so structured-data sites don't produce one.
- An LLM fallback for sites with no usable structured data was designed but
  cut — see `TODO.md` for the details and how it could be revived.
