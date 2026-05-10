# JOKINJAY Technical Knowledge

## Project Overview
Platform akademik/joki tugas dengan estetika "Cyber Minimalism + Bento Grid".

## Current State (Status Terakhir)
- **Theme**: Cyber Minimalism (High-contrast, Dark Mode, Terminal-style Typography).
- **Layout**: Bento Grid system pada Dashboard dan Home.
- **Animations**: Centralized GSAP hooks (`useGsap.ts`) dengan optimasi hardware.

## Features Implemented
1. **Authentication**:
   - NextAuth v4 integration.
   - Google & Apple OAuth (Google fully configured).
   - Custom Login/Register flow: Manual registration redirects to login for confirmation.
2. **Dashboard**:
   - Dynamic user data (Session-based).
   - Functional tabs: Orders, Messages (placeholder), Logs (placeholder).
   - Order Details Modal: Menampilkan detail deskripsi, harga, dan expert.
3. **Order System**:
   - Multi-step form: Brief, Quote, Payment.
   - Dynamic Price List Logic: Berdasarkan kategori tugas & urgensi deadline.
   - Navigation: Tombol "Back to Dashboard" tersedia di setiap step.

## Tech Stack
- **Framework**: Next.js (App Router).
- **Styling**: TailwindCSS 4 + Custom CSS Glassmorphism.
- **Animations**: GSAP 3.15+.
- **Auth**: Next-Auth 4.24.
