"use client";

import { useState, useEffect } from "react";
import Link from "next/link";
import Image from "next/image";
import { gsap } from "gsap";

interface NavbarProps {
  variant?: "main" | "dashboard" | "admin" | "joki";
  userName?: string;
  userRole?: string;
}

export default function Navbar({ variant = "main", userName, userRole }: NavbarProps) {
  const [isOpen, setIsOpen] = useState(false);

  // Animasi menu saat terbuka
  useEffect(() => {
    if (isOpen) {
      gsap.to(".mobile-menu-item", {
        opacity: 1,
        x: 0,
        stagger: 0.1,
        ease: "power2.out",
        duration: 0.4
      });
      document.body.style.overflow = "hidden";
    } else {
      document.body.style.overflow = "unset";
    }
  }, [isOpen]);

  const toggleMenu = () => setIsOpen(!isOpen);

  return (
    <>
      <nav className="cyber-nav w-full px-6 md:px-10 py-3 flex justify-between items-center relative z-[60]">
        {/* Logo */}
        <Link href="/" className="flex items-center gap-3 group">
          <Image
            src="/logo.jpeg"
            alt="JOKINJAY Logo"
            width={32}
            height={32}
            className="object-contain invert group-hover:opacity-80 transition-opacity"
          />
          <span className="font-mono font-black text-sm tracking-[0.2em] text-[#e4e4e4]">
            JOKI<span className="text-cyan">JAY</span>
          </span>
        </Link>

        {/* Center role tag (Desktop) */}
        {userRole && (
          <div className="hidden md:flex items-center gap-2">
            <span className="text-[9px] font-mono text-[#444] tracking-widest">//</span>
            <span className="text-[10px] font-mono text-[#888] uppercase tracking-widest">{userRole}</span>
          </div>
        )}

        {/* Right side (Desktop) */}
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
          <button 
            onClick={toggleMenu}
            className="md:hidden text-[#888] hover:text-cyan transition-all font-mono text-xl z-[70]"
          >
            {isOpen ? "×" : "≡"}
          </button>
        </div>
      </nav>

      {/* ── MOBILE OVERLAY MENU ── */}
      <div 
        className={`fixed inset-0 bg-[#0a0a0add] backdrop-blur-md z-[55] transition-all duration-500 md:hidden ${
          isOpen ? "opacity-100 pointer-events-auto" : "opacity-0 pointer-events-none"
        }`}
      >
        <div className="flex flex-col items-center justify-center h-full gap-8">
          <div className="font-mono text-[9px] text-[#444] tracking-[0.5em] mb-4">// NAVIGATION</div>
          
          <Link 
            href="/" 
            onClick={toggleMenu}
            className="mobile-menu-item opacity-0 -translate-x-4 font-mono text-2xl text-[#e4e4e4] hover:text-cyan transition-colors"
          >
            /HOME
          </Link>

          {variant === "main" ? (
            <>
              <Link 
                href="#work" 
                onClick={toggleMenu}
                className="mobile-menu-item opacity-0 -translate-x-4 font-mono text-2xl text-[#e4e4e4] hover:text-cyan transition-colors"
              >
                /WORK
              </Link>
              <Link 
                href="#price" 
                onClick={toggleMenu}
                className="mobile-menu-item opacity-0 -translate-x-4 font-mono text-2xl text-[#e4e4e4] hover:text-cyan transition-colors"
              >
                /PRICE
              </Link>
            </>
          ) : (
            <>
              <Link 
                href="/dashboard" 
                onClick={toggleMenu}
                className="mobile-menu-item opacity-0 -translate-x-4 font-mono text-2xl text-[#e4e4e4] hover:text-cyan transition-colors"
              >
                /DASHBOARD
              </Link>
              <Link 
                href="/order" 
                onClick={toggleMenu}
                className="mobile-menu-item opacity-0 -translate-x-4 font-mono text-2xl text-[#e4e4e4] hover:text-cyan transition-colors"
              >
                /NEW_ORDER
              </Link>
            </>
          )}

          <Link 
            href="/login" 
            onClick={toggleMenu}
            className="mobile-menu-item opacity-0 -translate-x-4 btn btn-primary mt-4"
          >
            [ {sessionStorage.getItem("user") ? "LOGOUT" : "ACCESS_PORTAL"} ]
          </Link>

          <div className="mt-20 font-mono text-[8px] text-[#222] tracking-widest uppercase">
            System v2.0.4 // Aurora Cybernetics
          </div>
        </div>
      </div>
    </>
  );
}
