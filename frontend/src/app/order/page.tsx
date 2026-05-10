"use client";

import { useState } from "react";
import Link from "next/link";
import { useSession } from "next-auth/react";
import Navbar from "@/components/Navbar";

const MATA_KULIAH = ["Strategic Management", "Advanced Calculus", "Theoretical Physics", "Market Analysis", "Programming", "Machine Learning", "Macroeconomics", "Other"];
const JENIS_TUGAS = ["Makalah / Essay", "Skripsi / Thesis", "Laporan Praktikum", "Presentasi PPT", "Kode Program", "Analisis Data", "Kuis / Ujian", "Other"];

const STEPS = ["BRIEF", "QUOTE", "PAYMENT"];

export default function OrderPage() {
  const { data: session } = useSession();
  const [step, setStep] = useState(0);
  const [form, setForm] = useState({ jenis: "", matkul: "", kampus: "", deadline: "", catatan: "" });

  // Format name: YOGA → YOGA_ or USR_001 if not logged in
  const displayName = session?.user?.name 
    ? session.user.name.toUpperCase().replace(/\s+/g, '_') 
    : "USR_001";

  const estimatedPrice = () => {
    const base = form.jenis.includes("Skripsi") ? 5000000 : form.jenis.includes("Kode") ? 2000000 : 800000;
    const days = form.deadline ? Math.max(1, Math.ceil((new Date(form.deadline).getTime() - Date.now()) / 86400000)) : 7;
    const mult = days <= 1 ? 3 : days <= 3 ? 2 : days <= 7 ? 1.5 : 1;
    return Math.round(base * mult);
  };

  return (
    <main className="min-h-screen">
      <Navbar variant="dashboard" userRole="ORDER_PORTAL" userName={displayName} />

      <div className="container-cyber py-10 max-w-3xl">
        
        {/* Back Button & Header */}
        <div className="mb-8 flex flex-col gap-6">
          <Link href="/dashboard" className="inline-flex items-center gap-2 group w-fit">
            <div className="w-1.5 h-1.5 bg-[#00e5ff] group-hover:animate-ping" />
            <span className="font-mono text-xs text-[#888] hover:text-[#00e5ff] transition-colors tracking-widest uppercase">
              ← BACK_TO_DASHBOARD
            </span>
          </Link>

          <div>
            <div className="font-mono text-[9px] text-[#444] tracking-widest mb-2">// SUBMIT NEW ORDER</div>
            <h1 className="font-mono font-black text-4xl text-[#e4e4e4]">
              ORDER<span className="text-[#00e5ff]">_FORM</span>
            </h1>
          </div>
        </div>

        {/* Stepper */}
        <div className="flex items-center gap-0 mb-10 border" style={{ borderColor: "var(--border)" }}>
          {STEPS.map((s, i) => (
            <div key={s} className="flex-1 py-3 px-4 font-mono text-[9px] uppercase tracking-widest text-center transition-all"
              style={{
                background: step === i ? "var(--cyan)" : step > i ? "var(--cyan-dim)" : "transparent",
                color: step === i ? "#000" : step > i ? "var(--cyan)" : "var(--text-3)",
                borderRight: i < 2 ? `1px solid var(--border)` : "none",
              }}>
              {step > i ? "✓ " : `0${i + 1}. `}{s}
            </div>
          ))}
        </div>

        {/* STEP 0: BRIEF */}
        {step === 0 && (
          <div className="bento p-8 space-y-6">
            <div className="font-mono text-[9px] text-[#444] tracking-widest">// MISSION BRIEF</div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
              <div className="space-y-1.5">
                <label className="font-mono text-[9px] text-[#444] uppercase tracking-widest">TASK_TYPE *</label>
                <div className="relative">
                  <select value={form.jenis} onChange={e => setForm({ ...form, jenis: e.target.value })}
                    className="input appearance-none w-full cursor-pointer" style={{ background: "var(--bg)" }}>
                    <option value="">Select...</option>
                    {JENIS_TUGAS.map(j => <option key={j} value={j} style={{ background: "#111" }}>{j}</option>)}
                  </select>
                </div>
              </div>

              <div className="space-y-1.5">
                <label className="font-mono text-[9px] text-[#444] uppercase tracking-widest">MATA_KULIAH *</label>
                <select value={form.matkul} onChange={e => setForm({ ...form, matkul: e.target.value })}
                  className="input appearance-none cursor-pointer" style={{ background: "var(--bg)" }}>
                  <option value="">Select...</option>
                  {MATA_KULIAH.map(m => <option key={m} value={m} style={{ background: "#111" }}>{m}</option>)}
                </select>
              </div>

              <div className="space-y-1.5">
                <label className="font-mono text-[9px] text-[#444] uppercase tracking-widest">INSTITUTION</label>
                <input type="text" placeholder="Nama kampus..." value={form.kampus}
                  onChange={e => setForm({ ...form, kampus: e.target.value })} className="input" />
              </div>

              <div className="space-y-1.5">
                <label className="font-mono text-[9px] text-[#444] uppercase tracking-widest">DEADLINE *</label>
                <input type="datetime-local" value={form.deadline}
                  onChange={e => setForm({ ...form, deadline: e.target.value })} className="input" />
              </div>
            </div>

            <div className="space-y-1.5">
              <label className="font-mono text-[9px] text-[#444] uppercase tracking-widest">INSTRUCTIONS</label>
              <textarea rows={5} placeholder="// Masukkan instruksi spesifik, referensi, atau catatan penting..."
                value={form.catatan} onChange={e => setForm({ ...form, catatan: e.target.value })}
                className="input resize-none leading-relaxed" />
            </div>

            <div className="flex justify-end pt-2">
              <button onClick={() => setStep(1)} className="btn btn-primary">[ NEXT: GET QUOTE → ]</button>
            </div>
          </div>
        )}

        {/* STEP 1: QUOTE */}
        {step === 1 && (
          <div className="space-y-4">
            <div className="bento p-8 space-y-6">
              <div className="font-mono text-[9px] text-[#444] tracking-widest">// ORDER SUMMARY</div>
              <div className="grid grid-cols-2 gap-4">
                {[
                  { k: "TASK_TYPE", v: form.jenis || "—" },
                  { k: "MATA_KULIAH", v: form.matkul || "—" },
                  { k: "DEADLINE", v: form.deadline ? new Date(form.deadline).toLocaleDateString("id-ID") : "—" },
                  { k: "INSTITUTION", v: form.kampus || "Private" },
                ].map(item => (
                  <div key={item.k} className="bento p-5" style={{ background: "var(--bg-2)" }}>
                    <div className="font-mono text-[8px] text-[#444] tracking-widest mb-2">{item.k}</div>
                    <div className="font-mono text-sm text-[#e4e4e4] truncate">{item.v}</div>
                  </div>
                ))}
              </div>
            </div>

            <div className="bento-active bento p-8 flex flex-col sm:flex-row justify-between items-center gap-6">
              <div>
                <div className="font-mono text-[9px] text-[#444] tracking-widest mb-2">ESTIMATED_COST</div>
                <div className="font-mono text-[9px] text-[#444]">* harga final dikonfirmasi oleh expert</div>
              </div>
              <div className="font-mono font-black text-4xl sm:text-5xl text-[#00e5ff]">
                Rp {estimatedPrice().toLocaleString("id-ID")}
              </div>
            </div>

            <div className="flex gap-3">
              <button onClick={() => setStep(0)} className="btn flex-1 justify-center">[ ← BACK ]</button>
              <button onClick={() => setStep(2)} className="btn btn-primary flex-1 justify-center">[ PROCEED TO PAYMENT → ]</button>
            </div>
          </div>
        )}

        {/* STEP 2: PAYMENT */}
        {step === 2 && (
          <div className="space-y-4">
            <div className="bento p-8 space-y-6">
              <div className="font-mono text-[9px] text-[#444] tracking-widest">// PAYMENT METHOD</div>

              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <button className="bento bento-hover p-8 text-left transition-all group">
                  <div className="font-mono text-[9px] text-[#444] tracking-widest mb-3">DEPOSIT_50%</div>
                  <div className="font-mono font-black text-2xl text-[#e4e4e4]">Rp {(estimatedPrice() / 2).toLocaleString("id-ID")}</div>
                  <div className="font-mono text-[9px] text-[#444] mt-2">Bayar sekarang, sisanya setelah selesai</div>
                </button>
                <button className="bento bento-active p-8 text-left group">
                  <div className="font-mono text-[9px] text-[#00e5ff] tracking-widest mb-3">FULL_PAYMENT ⭐</div>
                  <div className="font-mono font-black text-2xl text-[#00e5ff]">Rp {estimatedPrice().toLocaleString("id-ID")}</div>
                  <div className="font-mono text-[9px] text-[#444] mt-2">Prioritas antrian + revisi unlimited</div>
                </button>
              </div>

              <div className="p-4 border" style={{ borderColor: "var(--border)", background: "var(--bg-2)" }}>
                <div className="flex items-center gap-2 mb-2">
                  <div className="w-1.5 h-1.5 rounded-full bg-[#00ff88]" />
                  <span className="font-mono text-[9px] text-[#00ff88] uppercase tracking-widest">SECURE PAYMENT GATEWAY</span>
                </div>
                <p className="font-mono text-[9px] text-[#444] leading-relaxed">
                  Pembayaran diproses melalui gateway terenkripsi. Expert akan di-assign dalam 15 menit setelah konfirmasi.
                </p>
              </div>
            </div>

            <div className="flex gap-3">
              <button onClick={() => setStep(1)} className="btn flex-1 justify-center">[ ← BACK ]</button>
              <Link href="/dashboard" className="btn btn-primary flex-1 justify-center">[ CONFIRM ORDER ]</Link>
            </div>
          </div>
        )}
      </div>
    </main>
  );
}
