"use client";

import { useState, useEffect } from "react";

export default function InstallPrompt() {
  const [show, setShow] = useState(false);
  const [deferredPrompt, setDeferredPrompt] = useState<any>(null);
  const [isIOS, setIsIOS] = useState(false);

  useEffect(() => {
    // 1. Deteksi iOS
    const ios = /iPad|iPhone|iPod/.test(navigator.userAgent) && !(window as any).MSStream;
    setIsIOS(ios);

    // 2. Cek jika sudah dalam mode aplikasi (sudah terinstall)
    const isStandalone = window.matchMedia("(display-mode: standalone)").matches || (navigator as any).standalone;
    if (isStandalone) return;

    // 3. Tangkap event install (Khusus Chrome/Android/Edge)
    const handler = (e: any) => {
      console.log("✅ PWA Install Event Detected");
      e.preventDefault();
      setDeferredPrompt(e);
      setShow(true); // Langsung munculkan jika event terdeteksi
    };

    window.addEventListener("beforeinstallprompt", handler);

    // 4. FALLBACK: Jika dalam 10 detik event tidak muncul, tetap tampilkan sebagai saran
    const timer = setTimeout(() => {
      setShow(true);
    }, 10000);

    return () => {
      window.removeEventListener("beforeinstallprompt", handler);
      clearTimeout(timer);
    };
  }, []);

  const handleInstall = async () => {
    if (deferredPrompt) {
      // Jika browser mendukung install otomatis
      deferredPrompt.prompt();
      const { outcome } = await deferredPrompt.userChoice;
      if (outcome === "accepted") setShow(false);
      setDeferredPrompt(null);
    } else if (isIOS) {
      // Jika di iPhone, beri instruksi manual
      alert("Di iPhone: Klik tombol 'Share' (ikon kotak panah atas) lalu pilih 'Add to Home Screen' untuk menginstal JOKINJAY.");
      setShow(false);
    } else {
      // Jika di Laptop tapi ikon address bar tidak muncul
      alert("Klik ikon 'Install' di sebelah kanan address bar browser kamu untuk memasang JOKINJAY.");
      setShow(false);
    }
  };

  if (!show) return null;

  return (
    <div className="fixed bottom-6 left-6 right-6 md:left-auto md:w-[380px] z-[100] animate-in fade-in slide-in-from-bottom-6 duration-700">
      <div className="bento p-6 border-cyan bg-[#0a0a0add] backdrop-blur-2xl relative shadow-[0_0_50px_rgba(0,229,255,0.15)] border-l-4">
        {/* Close Icon */}
        <button 
          onClick={() => setShow(false)}
          className="absolute top-4 right-4 text-[#444] hover:text-cyan transition-colors font-mono text-xl"
        >
          ×
        </button>

        <div className="flex items-center gap-5">
          <div className="w-14 h-14 shrink-0 border border-cyan/30 flex items-center justify-center bg-[#00e5ff08] rounded-sm">
            <img src="/logo.jpeg" alt="Logo" className="w-10 h-10 object-contain invert" />
          </div>
          <div className="space-y-1">
            <div className="font-mono text-[9px] text-cyan tracking-[0.3em] uppercase animate-pulse">// MOBILE_SYNC_READY</div>
            <h3 className="font-mono font-black text-sm text-[#e4e4e4] tracking-tight">INSTALL APP?</h3>
            <p className="font-mono text-[10px] text-[#666] leading-tight">
              Akses cepat tanpa browser tab.
            </p>
          </div>
        </div>

        <div className="mt-6 flex gap-3">
          <button 
            onClick={() => setShow(false)}
            className="btn flex-1 justify-center text-[10px] py-2 border-[#222] text-[#444]"
          >
            DISMISS
          </button>
          <button 
            onClick={handleInstall}
            className="btn btn-primary flex-1 justify-center text-[10px] py-2 shadow-[0_0_15px_rgba(0,229,255,0.3)]"
          >
            INSTALL_NOW
          </button>
        </div>
      </div>
    </div>
  );
}
