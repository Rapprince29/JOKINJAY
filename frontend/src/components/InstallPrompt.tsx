"use client";

import { useState, useEffect } from "react";
import { gsap } from "gsap";

export default function InstallPrompt() {
  const [show, setShow] = useState(false);
  const [deferredPrompt, setDeferredPrompt] = useState<any>(null);

  useEffect(() => {
    // Cek jika sudah terinstall atau di browser standalone
    const isStandalone = window.matchMedia("(display-mode: standalone)").matches;
    if (isStandalone) return;

    // Tangkap event install dari browser
    const handler = (e: any) => {
      e.preventDefault();
      setDeferredPrompt(e);
      // Munculkan pop-up setelah 5 detik agar tidak mengganggu di awal
      setTimeout(() => setShow(true), 5000);
    };

    window.addEventListener("beforeinstallprompt", handler);
    return () => window.removeEventListener("beforeinstallprompt", handler);
  }, []);

  const handleInstall = async () => {
    if (!deferredPrompt) return;
    deferredPrompt.prompt();
    const { outcome } = await deferredPrompt.userChoice;
    if (outcome === "accepted") {
      setShow(false);
    }
    setDeferredPrompt(null);
  };

  if (!show) return null;

  return (
    <div className="fixed bottom-6 left-6 right-6 md:left-auto md:w-[350px] z-[100] animate-in fade-in slide-in-from-bottom-4 duration-500">
      <div className="bento p-6 border-cyan bg-[#0a0a0add] backdrop-blur-xl relative shadow-[0_0_30px_rgba(0,229,255,0.1)]">
        {/* Close Icon */}
        <button 
          onClick={() => setShow(false)}
          className="absolute top-4 right-4 text-[#444] hover:text-cyan transition-colors font-mono text-lg"
        >
          ×
        </button>

        <div className="flex items-start gap-4">
          <div className="w-12 h-12 shrink-0 border border-cyan flex items-center justify-center bg-[#00e5ff10]">
            <img src="/logo.jpeg" alt="Logo" className="w-8 h-8 object-contain invert" />
          </div>
          <div className="space-y-1">
            <div className="font-mono text-[9px] text-cyan tracking-widest uppercase">// SYSTEM_UPGRADE</div>
            <h3 className="font-mono font-bold text-xs text-[#e4e4e4] leading-tight">INSTALL JOKINJAY MOBILE?</h3>
            <p className="font-mono text-[9px] text-[#888] leading-relaxed mt-2">
              Akses lebih cepat, notifikasi real-time, dan performa lebih stabil.
            </p>
          </div>
        </div>

        <div className="mt-6 flex gap-3">
          <button 
            onClick={() => setShow(false)}
            className="btn flex-1 justify-center text-[9px] py-2"
          >
            [ LATER ]
          </button>
          <button 
            onClick={handleInstall}
            className="btn btn-primary flex-1 justify-center text-[9px] py-2"
          >
            [ INSTALL_NOW ]
          </button>
        </div>
      </div>
    </div>
  );
}
