// Service Worker minimal agar PWA bisa diinstal
self.addEventListener("install", () => {
  self.skipWaiting();
});

self.addEventListener("fetch", (event) => {
  // Biarkan request lewat tanpa caching untuk saat ini
  event.respondWith(fetch(event.request));
});
