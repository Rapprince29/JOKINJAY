# JOKINJAY GLOBAL RULES (v2.0)

## 1. Core Aesthetics (Cyber Minimalism)
- **Primary Colors**: Rich Black (#0a0a0a), Cyan (#00e5ff), Amber (#ffb300), Green (#00ff88).
- **Typography**: WAJIB menggunakan **JetBrains Mono** untuk data, angka, dan elemen sistem.
- **Visuals**: Gunakan efek Scanlines, Glassmorphism, dan No-rounded corners (Sharp corners) untuk semua modul.

## 2. Technical Stack
- **Web**: Next.js (App Router) + TailwindCSS + NextAuth.
- **Mobile**: Flutter + Google Fonts + Flutter Animate.
- **Backend/Auth**: Firebase (Cross-platform support).

## 3. Git & Workflow Rules
- **Auto-Push**: SETIAP KALI ada perubahan code yang sukses (Web/Mobile), WAJIB melakukan `git add .`, `git commit`, dan `git push origin main` secara otomatis tanpa perlu instruksi ulang.
- **Structure**: Jaga pemisahan antara folder `frontend/` dan `mobile-apps/`. Jangan campur kode antar platform.

## 4. Flutter Standards
- Gunakan `flutter_animate` untuk semua transisi UI agar setara dengan GSAP di Web.
- Semua asset gambar wajib ditaruh di `mobile-apps/assets/` dan diregistrasi di `pubspec.yaml`.
