# JOKINJAY Development Standards

## 1. Web (Next.js)
- Gunakan `use client` hanya jika diperlukan (interaksi/state).
- Semua navigasi internal WAJIB menggunakan komponen `<Link />` dari `next/link`.
- Pastikan semua perubahan yang mempengaruhi SEO (title/manifest) diupdate di `layout.tsx`.

## 2. Mobile (Flutter)
- **Naming**: Gunakan PascalCase untuk Class, camelCase untuk variabel.
- **Widgets**: Pisahkan widget besar menjadi komponen kecil (Extract Widget) untuk keterbacaan.
- **Firebase**: Selalu cek inisialisasi `Firebase.initializeApp()` sebelum memanggil layanan Auth atau Database.
- **Assets**: Jangan lupa menjalankan `flutter pub run flutter_launcher_icons` jika logo asset berubah.

## 3. Communication Style
- AI harus selalu memberikan ringkasan perubahan teknis di akhir setiap tugas.
- Selalu prioritaskan keamanan (jangan push `.env` atau `google-services.json` jika ada instruksi ignore).
