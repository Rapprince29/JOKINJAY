"use client";

import Link from "next/link";

interface NavbarProps {
  variant?: "main" | "dashboard" | "admin" | "joki";
  userName?: string;
  userRole?: string;
}

export default function Navbar({ variant = "main", userName, userRole }: NavbarProps) {
  return (
    <nav className="cyber-nav w-full px-6 md:px-10 py-3 flex justify-between items-center">
      {/* Logo */}
      <Link href="/" className="flex items-center gap-3 group">
        <div className="w-2 h-2 bg-[#00e5ff] group-hover:animate-ping" />
        <span className="font-mono font-black text-sm tracking-[0.2em] text-[#e4e4e4]">
          JOKI<span className="text-cyan">JAY</span>
        </span>
      </Link>

      {/* Center role tag */}
      {userRole && (
        <div className="hidden md:flex items-center gap-2">
          <span className="text-[9px] font-mono text-[#444] tracking-widest">//</span>
          <span className="text-[10px] font-mono text-[#888] uppercase tracking-widest">{userRole}</span>
        </div>
      )}

      {/* Right side */}
      <div className="flex items-center gap-4">
        {variant === "main" ? (
          <div className="hidden md:flex items-center gap-6">
            <Link href="#work" className="text-[10px] font-mono text-[#888] hover:text-[#00e5ff] uppercase tracking-widest transition-colors">/work</Link>
            <Link href="#price" className="text-[10px] font-mono text-[#888] hover:text-[#00e5ff] uppercase tracking-widest transition-colors">/price</Link>
            <Link href="/login" className="btn btn-primary text-[10px]">Access_</Link>
          </div>
        ) : (
          <div className="flex items-center gap-3">
            <div className="hidden sm:block text-right">
              <div className="text-[9px] font-mono text-[#444] uppercase tracking-widest">{userRole}</div>
              <div className="text-[10px] font-mono text-cyan">{userName || "USR_001"}</div>
            </div>
            <div
              className="w-8 h-8 border flex items-center justify-center font-mono text-xs text-cyan font-bold"
              style={{ borderColor: "var(--border-hi)", background: "var(--cyan-dim)" }}
            >
              {(userName || "U")[0]}
            </div>
          </div>
        )}

        {/* Mobile hamburger */}
        <button className="md:hidden text-[#888] hover:text-cyan transition-colors font-mono text-xs">≡</button>
      </div>
    </nav>
  );
}
