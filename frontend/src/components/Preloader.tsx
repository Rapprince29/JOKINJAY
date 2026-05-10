"use client";

import { useEffect, useRef } from "react";
import gsap from "gsap";

const BOOT_LINES = [
  "> INITIALIZING_JOKINJAY_CORE...",
  "> SYNCING_ACADEMIC_DATABASE...",
  "> ESTABLISHING_SECURE_LINK...",
  "> LOADING_EXPERT_MODULES...",
  "> BYPASSING_LIMITS...",
  "> SYSTEM_READY_TO_BOOT.",
];

export default function Preloader() {
  const containerRef = useRef<HTMLDivElement>(null);
  const terminalRef = useRef<HTMLDivElement>(null);
  const progressBarRef = useRef<HTMLDivElement>(null);
  const progressLabelRef = useRef<HTMLSpanElement>(null);
  const logoRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const container = containerRef.current;
    const terminal = terminalRef.current;
    const bar = progressBarRef.current;
    const label = progressLabelRef.current;
    const logo = logoRef.current;
    
    if (!container || !terminal || !bar || !label || !logo) return;

    document.body.style.overflow = "hidden";
    const counter = { val: 0 };

    const tl = gsap.timeline({
      onComplete: () => {
        gsap.to(container, {
          yPercent: -100,
          duration: 1,
          ease: "expo.inOut",
          onComplete: () => {
            container.style.display = "none";
            document.body.style.overflow = "";
          },
        });
      },
    });

    // 1. Initial Glitch Reveal
    tl.fromTo(logo, { opacity: 0, scale: 0.9 }, { opacity: 1, scale: 1, duration: 0.5, ease: "power4.out" });
    
    // 2. Loop through boot lines with "WOW" factor
    BOOT_LINES.forEach((text, i) => {
      tl.add(() => {
        const line = document.createElement("div");
        line.className = "font-mono text-[10px] tracking-[0.2em] mb-1 pl-line flex items-center gap-3";
        const isReady = text.includes("READY");
        
        line.innerHTML = `<span style="color: ${isReady ? "#00ff9d" : "#00e5ff"}">${text}</span>`;
        terminal.appendChild(line);
        
        // Visual shake on each log
        gsap.fromTo(container, { x: 2 }, { x: 0, duration: 0.1, repeat: 1 });
        gsap.from(line, { x: -20, opacity: 0, duration: 0.2 });

        const pct = Math.round(((i + 1) / BOOT_LINES.length) * 100);
        gsap.to(bar, { width: `${pct}%`, duration: 0.4, ease: "power2.out" });
        gsap.to(counter, {
          val: pct,
          duration: 0.4,
          onUpdate: () => { label.textContent = `${Math.round(counter.val)}%`; },
        });
      }, `+=${0.4}`);
    });

    // 3. Final Flash
    tl.to(logo, { textShadow: "0 0 30px #00e5ff", color: "#fff", duration: 0.3 });
    tl.to(logo, { opacity: 0, scale: 1.1, duration: 0.4 }, "+=0.5");

    return () => {
      tl.kill();
      document.body.style.overflow = "";
    };
  }, []);

  return (
    <div
      ref={containerRef}
      className="fixed inset-0 z-[10000] bg-[#050505] flex flex-col items-center justify-center overflow-hidden"
    >
      {/* CRT Scanline Effect */}
      <div className="absolute inset-0 pointer-events-none z-10" 
           style={{ 
             background: "linear-gradient(rgba(18, 16, 16, 0) 50%, rgba(0, 0, 0, 0.1) 50%), linear-gradient(90deg, rgba(255, 0, 0, 0.03), rgba(0, 255, 0, 0.01), rgba(0, 0, 255, 0.03))",
             backgroundSize: "100% 3px, 2px 100%" 
           }} 
      />

      <div className="w-full max-w-lg px-10 relative">
        {/* Branding */}
        <div ref={logoRef} className="text-center mb-16">
          <div className="font-mono text-[9px] text-cyan/30 tracking-[0.5em] mb-4 uppercase">System_Link_Established</div>
          <h1 className="font-mono font-black text-5xl md:text-7xl tracking-tighter text-[#222] italic">
            JOKI<span className="text-white">JAY</span>
          </h1>
        </div>

        {/* Terminal output */}
        <div ref={terminalRef} className="h-24 mb-10" />

        {/* Progress System */}
        <div className="relative pt-1">
          <div className="flex mb-2 items-center justify-between">
            <div>
              <span className="text-[10px] font-mono font-semibold inline-block py-1 px-2 uppercase rounded-full text-cyan bg-cyan/10">
                BOOTING_PROCESS
              </span>
            </div>
            <div className="text-right">
              <span ref={progressLabelRef} className="text-[10px] font-mono font-semibold inline-block text-cyan">
                0%
              </span>
            </div>
          </div>
          <div className="overflow-hidden h-[2px] mb-4 text-xs flex bg-white/5">
            <div
              ref={progressBarRef}
              style={{ width: "0%" }}
              className="shadow-none flex flex-col text-center whitespace-nowrap text-white justify-center bg-cyan"
            ></div>
          </div>
        </div>
      </div>

      {/* Decorative text */}
      <div className="absolute bottom-10 font-mono text-[8px] text-white/10 tracking-[1em] uppercase">
        Aurora_Cybernetics // 2026
      </div>
    </div>
  );
}
