/* Dark / light mode toggle.
   Persists the user's choice in localStorage. On first visit, follows
   the OS preference (prefers-color-scheme). The initial theme is also
   applied by a tiny inline script in <head> to avoid a flash of
   unthemed content. This file sets the button's textContent
   explicitly so there is always exactly one icon character,
   regardless of any cached markup. */

(function () {
  const KEY = "yl-theme";
  const root = document.documentElement;
  const btn = document.getElementById("theme-btn");
  if (!btn) return;

  // Icon shows the theme you'll switch TO on the next click.
  function iconFor(theme) {
    return theme === "dark" ? "☼" : "☾";
  }

  function apply(theme) {
    if (theme === "dark") {
      root.setAttribute("data-theme", "dark");
    } else {
      root.removeAttribute("data-theme");
    }
    btn.textContent = iconFor(theme);
    try { localStorage.setItem(KEY, theme); } catch (_) {}
  }

  // Sync button text to whatever theme the inline <head> script applied.
  const initialTheme = root.getAttribute("data-theme") === "dark" ? "dark" : "light";
  btn.textContent = iconFor(initialTheme);

  btn.addEventListener("click", function () {
    const current = root.getAttribute("data-theme") === "dark" ? "dark" : "light";
    apply(current === "dark" ? "light" : "dark");
  });
})();
