/* Dark / light mode toggle.
   Persists the user's choice in localStorage. On first visit, follows
   the OS preference (prefers-color-scheme). The initial theme is also
   applied by a tiny inline script in <head> to avoid a flash of
   unthemed content; this file only handles button clicks. */

(function () {
  const KEY = "yl-theme";
  const root = document.documentElement;
  const btn = document.getElementById("theme-btn");
  if (!btn) return;

  function apply(theme) {
    if (theme === "dark") {
      root.setAttribute("data-theme", "dark");
    } else {
      root.removeAttribute("data-theme");
    }
    try { localStorage.setItem(KEY, theme); } catch (_) {}
  }

  btn.addEventListener("click", function () {
    const current = root.getAttribute("data-theme") === "dark" ? "dark" : "light";
    apply(current === "dark" ? "light" : "dark");
  });
})();
