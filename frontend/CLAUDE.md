# JOKINJAY Coding Standards

## Design Principles (Cyber Minimalism)
- **Colors**: Rich Black (#0a0a0a), Cyan (#00e5ff), Amber (#ffb300), Green (#00ff88).
- **Typography**: JetBrains Mono untuk angka/data teknis, Inter untuk teks deskriptif.
- **Visuals**: Scanline overlay, terminal-style prompts, glassmorphism borders.

## Coding Conventions
- **Animations**: WAJIB menggunakan hook `useEnter` atau `useReveal` dari `@/hooks/useGsap`. Jangan gunakan animasi CSS mentah atau inline GSAP tanpa hook tersebut.
- **State Management**: Gunakan React State untuk interaksi UI lokal (seperti tab & modal).
- **Auth**: Gunakan `useSession()` dari `next-auth/react` untuk mengambil data user. Pastikan komponen dibungkus oleh `Providers.tsx`.
- **Responsive**: Gunakan grid Tailwind (grid-cols-1 md:grid-cols-2 dst.) untuk memastikan tampilan Bento Grid aman di Mobile.

## Git Workflow
- **Auto-Push**: Lakukan commit dan push ke `origin main` setelah setiap perubahan besar atau perbaikan bug yang sukses tanpa menunggu instruksi user (sesuai `RULES.md`).
- **Commit Message**: Gunakan pesan yang deskriptif tentang fitur yang diubah.
