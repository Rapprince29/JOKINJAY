"use client";

import { useState, useRef } from "react";
import Link from "next/link";
import { signIn } from "next-auth/react";
import { useEnter } from "@/hooks/useGsap";

export default function LoginPage() {
  const ref = useRef<HTMLElement>(null);
  const [mode, setMode] = useState<"login" | "register">("login");
  const [loading, setLoading] = useState(false);
  const [ssoLoading, setSsoLoading] = useState<"google" | "apple" | null>(null);
  const [registeredName, setRegisteredName] = useState("");
  const [successMsg, setSuccessMsg] = useState("");

  useEnter(ref, { selector: ".enter-block", y: 16, stagger: 0.1, duration: 0.55 });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);

    if (mode === "register") {
      // Ambil nama dari form (simulasi)
      const formData = new FormData(e.target as HTMLFormElement);
      const name = formData.get("fullname") as string;
      
      setTimeout(() => {
        setLoading(false);
        setSuccessMsg(`Registrasi berhasil, ${name}! Silakan login untuk konfirmasi.`);
        setMode("login"); // Pindah ke login setelah daftar
      }, 1500);
    } else {
      // Simulasi login manual
      setTimeout(() => {
        window.location.href = "/dashboard";
      }, 1500);
    }
  };

  const handleGoogle = async () => {
    setSsoLoading("google");
    await signIn("google", { callbackUrl: "/dashboard" });
  };

  return (
    <main ref={ref} className="min-h-screen flex flex-col items-center justify-center px-6 py-12">
      <div className="w-full max-w-sm">

        {/* ── HEADER ── */}
        <div className="enter-block mb-10">
          <Link href="/" className="inline-flex items-center gap-2 mb-8 group">
            <div className="w-1.5 h-1.5 bg-[#00e5ff] group-hover:animate-ping" />
            <span className="font-mono text-xs text-[#888] hover:text-[#00e5ff] transition-colors tracking-widest">← /home</span>
          </Link>
          <div className="font-mono text-[9px] text-[#444] tracking-widest mb-2">// AUTH PORTAL</div>
          <h1 className="font-mono font-black text-4xl text-[#e4e4e4]">
            {mode === "login" ? "SIGN_IN" : "REGISTER"}<span className="text-[#00e5ff]">_</span>
          </h1>
        </div>

        {/* ── MAIN CARD ── */}
        <div className="enter-block space-y-4">
          
          {/* Success Message */}
          {successMsg && (
            <div className="p-4 bg-[#00ff8810] border border-[#00ff8830] text-[#00ff88] font-mono text-[10px] mb-4">
              {successMsg}
            </div>
          )}

          {/* Mode Toggle */}
          <div className="flex border mb-6" style={{ borderColor: "var(--border)" }}>
            {(["login", "register"] as const).map((m) => (
              <button
                key={m}
                onClick={() => { setMode(m); setSuccessMsg(""); }}
                className="flex-1 py-2.5 font-mono text-[10px] uppercase tracking-widest transition-all duration-150"
                style={{
                  background: mode === m ? "var(--cyan)" : "transparent",
                  color: mode === m ? "#000" : "var(--text-2)",
                }}
              >
                {m === "login" ? "[ LOGIN ]" : "[ REGISTER ]"}
              </button>
            ))}
          </div>

          {/* Form */}
          <form onSubmit={handleSubmit} className="space-y-4">
            {mode === "register" && (
              <div className="space-y-1.5">
                <label className="font-mono text-[9px] text-[#444] uppercase tracking-widest">FULL_NAME</label>
                <input name="fullname" type="text" placeholder="Nama lengkap..." className="input" required />
              </div>
            )}
            <div className="space-y-1.5">
              <label className="font-mono text-[9px] text-[#444] uppercase tracking-widest">EMAIL</label>
              <input type="email" placeholder="email@kampus.ac.id" className="input" required />
            </div>
            <div className="space-y-1.5">
              <div className="flex justify-between items-center">
                <label className="font-mono text-[9px] text-[#444] uppercase tracking-widest">PASSWORD</label>
                {mode === "login" && (
                  <button type="button" className="font-mono text-[9px] text-[#444] hover:text-[#00e5ff] transition-colors uppercase tracking-widest">
                    FORGOT?
                  </button>
                )}
              </div>
              <input type="password" placeholder="••••••••" className="input" required />
            </div>
            <button
              type="submit"
              disabled={loading}
              className="btn btn-primary w-full justify-center mt-2"
              style={{ padding: "14px 24px", opacity: loading ? 0.6 : 1 }}
            >
              {loading ? "[ PROCESSING... ]" : mode === "login" ? "[ AUTHENTICATE ]" : "[ CREATE ACCOUNT ]"}
            </button>
          </form>

          {/* Divider */}
          <div className="flex items-center gap-4 py-2">
            <div className="flex-1 h-px" style={{ background: "var(--border)" }} />
            <span className="font-mono text-[9px] text-[#333] tracking-widest">OR</span>
            <div className="flex-1 h-px" style={{ background: "var(--border)" }} />
          </div>

          {/* SSO Buttons */}
          <div className="space-y-3">
            <button
              onClick={handleGoogle}
              disabled={ssoLoading !== null}
              className="btn w-full justify-center gap-3"
              style={{ padding: "12px 24px", opacity: ssoLoading === "apple" ? 0.5 : 1 }}
            >
              {ssoLoading === "google" ? (
                <span className="font-mono text-[10px] text-[#00e5ff] animate-pulse">REDIRECTING...</span>
              ) : (
                <>
                  <svg className="w-4 h-4 shrink-0" viewBox="0 0 24 24">
                    <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92a5.06 5.06 0 0 1-2.2 3.32v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.1z" fill="#4285F4" />
                    <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853" />
                    <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05" />
                    <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335" />
                  </svg>
                  <span>[ CONTINUE WITH GOOGLE ]</span>
                </>
              )}
            </button>
          </div>
        </div>

        {/* ── STATUS PANEL ── */}
        <div className="enter-block mt-6 p-4 border" style={{ borderColor: "var(--border)", background: "var(--bg-1)" }}>
          <div className="flex items-center gap-2">
            <div className="w-1.5 h-1.5 rounded-full bg-[#00ff88]" />
            <span className="font-mono text-[9px] text-[#00ff88] uppercase tracking-widest">SECURE CONNECTION</span>
          </div>
          <p className="font-mono text-[9px] text-[#444] mt-2">
            Data kamu terenkripsi end-to-end. Privasi dijamin 100%.
          </p>
        </div>

      </div>
    </main>
  );
}
