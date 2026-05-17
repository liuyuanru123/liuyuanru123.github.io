/* Single-button language toggle.
   The button always shows the OTHER (target) language — click it to
   switch. Preference is persisted in localStorage, defaulting to
   Japanese as declared in <html lang="ja"> in the markup. */

(function () {
  const KEY = "yl-lang";
  const root = document.documentElement;
  const btn = document.getElementById("lang-btn");
  if (!btn) return;

  function labelFor(lang) {
    // Label shows the language you'll switch TO on the next click.
    return lang === "ja" ? "English" : "日本語";
  }

  function apply(lang) {
    root.setAttribute("lang", lang);
    btn.textContent = labelFor(lang);
    try { localStorage.setItem(KEY, lang); } catch (_) {}
  }

  // Restore saved preference, otherwise honor the markup default (ja).
  let saved = null;
  try { saved = localStorage.getItem(KEY); } catch (_) {}
  if (saved === "ja" || saved === "en") {
    apply(saved);
  } else {
    // Make sure the button label matches the initial <html lang>.
    btn.textContent = labelFor(root.getAttribute("lang") || "ja");
  }

  btn.addEventListener("click", function () {
    const current = root.getAttribute("lang") === "en" ? "en" : "ja";
    apply(current === "ja" ? "en" : "ja");
  });
})();
