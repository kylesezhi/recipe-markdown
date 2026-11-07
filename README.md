# Recipe to Markdown

Turn a recipe URL into markdown. One HTML file. No build. No dependencies.
No keys. No backend.

## Output

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

Only if the source has notes.
```

The output is editable. One click to copy.

## How it works

All in the browser. Three stages. First match wins.

1. Fetch. Direct first. Blocked sites retry through free proxies: corsfix,
   allorigins, codetabs, cors.lol. One fails, the next runs.
2. Parse. JSON-LD `Recipe` first. Then microdata. Then DOM heuristics.
   Heuristics keep group headings like "For the crust".
3. Render. One renderer. The template above.

Some sites block every proxy. Allrecipes does. Then paste: save the page as
"Web Page, HTML only", open the file, copy, paste it below the URL field.
Same parser runs. The `> From:` line stays if the URL field is filled.

Free proxies die often. When this was built, allorigins was down and
corsproxy.io had gone paid. The chain and the paste fallback absorb that.
Proxy fetches pass through third parties. Want it local? Paste instead.

## Deploy

Hosted on GitHub Pages: https://kylesezhi.github.io/recipe-markdown/

Pushes to `main` deploy automatically through `.github/workflows/pages.yml`.
The workflow can also be run manually from the Actions tab.

One-time setup: Settings → Pages → Build and deployment → Source: GitHub
Actions. Until this is enabled, the first deploy fails. Re-run the workflow
after enabling it.

### Local preview

```
python3 -m http.server 8002
```

Then open http://localhost:8002. Or double-click `index.html`. Serving over
HTTP is better. corsfix rejects the null origin of a `file://` page.

## Limits

- Notes come from the heuristics parser only. Schema.org has no notes field.
- An LLM fallback was designed and cut. See `TODO.md`.
