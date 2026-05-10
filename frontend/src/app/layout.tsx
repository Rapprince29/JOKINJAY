import type { Metadata } from "next";
import { Inter, JetBrains_Mono } from "next/font/google";
import "./globals.css";
import Preloader from "@/components/Preloader";

const inter = Inter({
  subsets: ["latin"],
  variable: "--font-sans",
  display: "swap",
});

const jetbrains = JetBrains_Mono({
  subsets: ["latin"],
  variable: "--font-mono",
  display: "swap",
});

export const metadata: Metadata = {
  title: "JOKINJAY // Academic Solutions",
  description: "Platform joki tugas & layanan akademik profesional. Hasil A+, privasi terjaga.",
};

import { Providers } from "@/components/Providers";

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="id" className={`${inter.variable} ${jetbrains.variable}`}>
      <body className="min-h-screen font-sans bg-[#0a0a0a] text-[#e4e4e4]">
        <Providers>
          <Preloader />
          {children}
        </Providers>
      </body>
    </html>
  );
}
