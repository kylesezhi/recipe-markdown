---
plan name: recipe-markdown-page
plan description: Single-file browser converter tool
plan status: active
---

## Idea
Build a single static index.html (inline CSS/JS, zero dependencies, no build step, works via file:// double-click) in /home/kyle/Dropbox/opensource/markdown-recipe that converts a recipe URL into markdown.

Resolved decisions from interview:
- Frontend only, one file: index.html. No README, no other files.
- Fetch chain: direct fetch first; on CORS failure retry via allorigins (https://api.allorigins.win/raw?url=...), then corsproxy.io. 
- Parse chain: schema.org JSON-LD Recipe (walk @graph/arrays; handle recipeIngredient as strings or ItemList; recipeInstructions as strings, HowToStep objects, or ItemList; strip embedded HTML tags/entities) -> microdata/itemprop fallback -> CSS class-name heuristics (.ingredients/.recipe-ingredients etc.) with ingredient-group heading detection.
- LLM fallback DROPPED: OpenCode Go chat endpoints verified non-browser-callable (no CORS on POST; only /models GET allows it). No settings panel, no API key, no localStorage — fully keyless.
- Markdown template (exactly):
  # Recipe Name
  (blank line)
  > From: <source URL>
  (blank)
  ## Ingredients
  - ingredient bullets; groups rendered as **Bold sub-headers:** lines between bullets
  (blank)
  ## Instructions
  1. repeated "1." numbering for every step (markdown auto-number style, per user's template)
  (blank)
  ## Notes (only when author notes exist)
- No servings/times, no image, no other fields (user explicitly declined).
- Output: editable textarea + one-click copy button. No preview, no download.
- Failure UX: inline error message ("Couldn't find recipe data on that page") with the paste-HTML section auto-expanded as escape hatch; pasted HTML runs through the same parser chain.
- URL input normalization: prepend https:// if scheme missing.
- Verification: manual checklist with ~4 recipe URLs covering: clean JSON-LD site, site with grouped ingredients, site with no structured data (heuristics path), and a hard failure (paste-HTML path).

## Implementation
- [object Object]
- [object Object]
- [object Object]
- [object Object]
- [object Object]
- [object Object]

## Required Specs
<!-- SPECS_START -->
<!-- SPECS_END -->