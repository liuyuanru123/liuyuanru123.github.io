/* In-page lightbox for figure images.
   Intercepts clicks on figure/anchor pairs and shows the image in a full-screen
   overlay instead of navigating away. Click on the backdrop, the close button,
   or press Escape to close and restore the page. */

(function () {
  const lb = document.getElementById("lightbox");
  if (!lb) return;
  const img = lb.querySelector(".lightbox-img");
  const closeBtn = lb.querySelector(".lightbox-close");

  // Every clickable figure anchor opens in the lightbox instead of a new tab.
  const triggers = document.querySelectorAll(".figure a, .salt-figure a");

  function open(href, alt) {
    img.src = href;
    img.alt = alt || "";
    lb.hidden = false;
    // Lock background scroll while the lightbox is open.
    document.body.style.overflow = "hidden";
  }

  function close() {
    lb.hidden = true;
    // Clear src so the next open can re-trigger the load transition.
    img.src = "";
    document.body.style.overflow = "";
  }

  triggers.forEach(function (a) {
    a.addEventListener("click", function (e) {
      e.preventDefault();
      const innerImg = a.querySelector("img");
      open(a.getAttribute("href"), innerImg ? innerImg.alt : "");
    });
  });

  // Click anywhere on the backdrop (but not on the image itself) closes.
  lb.addEventListener("click", function (e) {
    if (e.target === lb || e.target === closeBtn) close();
  });

  // Stop image clicks from bubbling to the backdrop.
  img.addEventListener("click", function (e) {
    e.stopPropagation();
  });

  // Escape key closes.
  document.addEventListener("keydown", function (e) {
    if (e.key === "Escape" && !lb.hidden) close();
  });
})();
