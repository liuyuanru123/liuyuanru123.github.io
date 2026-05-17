/* Minimal i18n toggle.
   Persists the user's choice in localStorage.
   Default language is Japanese (set via <html lang="ja"> in index.html). */

(function () {
  const KEY = "yl-lang";
  const root = document.documentElement;
  const buttons = document.querySelectorAll(".lang-toggle button[data-set-lang]");

  function apply(lang) {
    root.setAttribute("lang", lang);
    buttons.forEach(function (btn) {
      btn.setAttribute("aria-pressed", btn.dataset.setLang === lang ? "true" : "false");
    });
    try { localStorage.setItem(KEY, lang); } catch (_) {}
  }

  // Restore saved preference, otherwise honor the markup default (ja).
  let saved = null;
  try { saved = localStorage.getItem(KEY); } catch (_) {}
  if (saved === "ja" || saved === "en") apply(saved);

  buttons.forEach(function (btn) {
    btn.addEventListener("click", function () {
      apply(btn.dataset.setLang);
    });
  });
})();
