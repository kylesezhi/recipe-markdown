# TODO

- [ ] LLM fallback for recipes without usable JSON-LD/microdata/heuristics
      Status: designed but cut from v1
      Context: OpenCode Go chat endpoints are not browser-callable
      (verified 2026-10-13: no CORS on POST /zen/go/v1/chat/completions;
      only GET /models allows cross-origin). Would need OpenRouter
      (verified browser-callable, allow-origin: *) or a local
      Ollama/LM Studio endpoint. Design if revived: cleaned-text
      payload (~20-30k chars, scripts/styles/nav stripped) → strict
      JSON response → same markdown renderer as the parser chain.
