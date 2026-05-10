"use client";

import { useEffect, useRef } from "react";
import gsap from "gsap";

const BOOT_LINES = [
  "> INITIALIZING JOKINJAY.SYS...",
  "> LOADING ACADEMIC MODULES...",
  "> ENCRYPTING USER SESSION...",
  "> BYPASSING PROCRASTINATION.EXE...",
  "> CONNECTING TO EXPERT NETWORK...",
  "> SYSTEM READY.",
];

export default function Preloader() {
  const containerRef = useRef<HTMLDivElement>(null);
  const terminalRef = useRef<HTMLDivElement>(null);
  const progressBarRef = useRef<HTMLDivElement>(null);
  const progressLabelRef = useRef<HTMLSpanElement>(null);

  useEffect(() => {
    const container = containerRef.current;
    const terminal = terminalRef.current;
    const bar = progressBarRef.current;
    const label = progressLabelRef.current;
    if (!container || !terminal || !bar || !label) return;

    // Prevent scroll while preloader is active
    document.body.style.overflow = "hidden";

    // Counter object for GSAP
    const counter = { val: 0 };

    // ── Build timeline ──────────────────────────────────────────────────
    const tl = gsap.timeline({
      onComplete: () => {
        // Slide the preloader UP and away
        gsap.to(container, {
          yPercent: -100,
          duration: 0.75,
          ease: "power3.inOut",
          onComplete: () => {
            container.style.display = "none";
            document.body.style.overflow = "";
          },
        });
      },
    });

    // 1. Fade in logo + corner brackets
    tl.from(".pl-logo", { y: 20, opacity: 0, duration: 0.5, ease: "power2.out", force3D: true });
    tl.from(".pl-corner", { opacity: 0, duration: 0.3, stagger: 0.05, ease: "none" }, "-=0.2");

    // 2. Add each boot line sequentially
    BOOT_LINES.forEach((text, i) => {
      tl.add(() => {
        const line = document.createElement("div");
        line.className = "font-mono text-xs tracking-wider flex items-center gap-3 pl-line";
        const isReady = text.includes("READY");
        line.innerHTML = `
          <span style="color: ${isReady ? "var(--green)" : "var(--cyan)"}" class="${isReady ? "font-bold" : "opacity-70"}">
            ${text}
          </span>
        `;
        terminal.appendChild(line);
        gsap.from(line, { x: -10, opacity: 0, duration: 0.25, ease: "power1.out", force3D: true });

        // Update progress bar & label
        const pct = Math.round(((i + 1) / BOOT_LINES.length) * 100);
        gsap.to(bar, { width: `${pct}%`, duration: 0.3, ease: "power1.out" });
        gsap.to(counter, {
          val: pct,
          duration: 0.3,
          onUpdate: () => { if (label) label.textContent = `${Math.round(counter.val)}%`; },
        });
      }, `+=${0.38}`);
    });

    // 3. Short hold at 100% before exit
    tl.add(() => {}, "+=0.6");

    return () => {
      tl.kill();
      document.body.style.overflow = "";
    };
  }, []);

  return (
    <div
      ref={containerRef}
      className="fixed inset-0 z-[10000] bg-[#0a0a0a] flex flex-col items-start justify-center px-8 md:px-20 overflow-hidden"
      style={{
        backgroundImage:
          "linear-gradient(rgba(0,229,255,0.015) 1px, transparent 1px), linear-gradient(90deg, rgba(0,229,255,0.015) 1px, transparent 1px)",
        backgroundSize: "40px 40px",
      }}
    >
      {/* Corner Brackets */}
      {["top-8 left-8 border-t-2 border-l-2", "top-8 right-8 border-t-2 border-r-2", "bottom-8 left-8 border-b-2 border-l-2", "bottom-8 right-8 border-b-2 border-r-2"].map((cls, i) => (
        <div key={i} className={`pl-corner absolute w-8 h-8 ${cls}`} style={{ borderColor: "var(--cyan)" }} />
      ))}

      <div className="w-full max-w-2xl">
        {/* Logo */}
        <div className="pl-logo mb-8">
          <div className="text-[10px] font-mono text-[#444] mb-2 tracking-widest">SYS:BOOT // v2.0.1</div>
          <div className="text-5xl md:text-7xl font-mono font-black text-[#e4e4e4] tracking-tight">
            JOKI<span style={{ color: "var(--cyan)" }}>JAY</span>
          </div>
        </div>

        {/* Terminal output */}
        <div ref={terminalRef} className="space-y-1.5 mb-8 min-h-[120px]" />

        {/* Progress */}
        <div className="h-[2px] bg-[#1a1a1a] w-full overflow-hidden">
          <div
            ref={progressBarRef}
            className="h-full"
            style={{ width: "0%", background: "var(--cyan)", willChange: "width" }}
          />
        </div>
        <div className="flex justify-between items-center mt-2">
          <span className="font-mono text-[9px] text-[#444] tracking-widest">LOADING</span>
          <span ref={progressLabelRef} className="font-mono text-[9px]" style={{ color: "var(--cyan)" }}>0%</span>
        </div>
      </div>
    </div>
  );
}
