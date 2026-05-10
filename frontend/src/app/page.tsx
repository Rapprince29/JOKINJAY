"use client";

import { useRef } from "react";
import Link from "next/link";
import Navbar from "@/components/Navbar";
import Footer from "@/components/Footer";
import { useEnter, useReveal } from "@/hooks/useGsap";

const STATS = [
  { key: "SUCCESS_RATE", val: "99.9%", color: "var(--green)" },
  { key: "EXPERTS_ONLINE", val: "50+",  color: "var(--cyan)" },
  { key: "CLIENTS_SERVED", val: "2.5K", color: "var(--cyan)" },
  { key: "AVG_GRADE",      val: "A+",   color: "var(--amber)" },
];

const SERVICES = [
  { id: "SRV-001", name: "PAPER_SYNTHESIS",  desc: "Karya tulis ilmiah, skripsi, makalah",   tag: "HIGH DEMAND", span: "md:col-span-2 md:row-span-2" },
  { id: "SRV-002", name: "PRESENTATION",     desc: "Desain PPT + isi materi",               tag: "POPULAR",    span: "" },
  { id: "SRV-003", name: "CODE_SOLUTION",    desc: "Programming & algoritma",               tag: "FAST",       span: "" },
  { id: "SRV-004", name: "DATA_ANALYSIS",    desc: "Statistik & olah data SPSS",            tag: "EXPERT",     span: "" },
  { id: "SRV-005", name: "QUIZ_BYPASS",      desc: "Kuis & latihan soal harian",             tag: "24H",        span: "" },
];

export default function Home() {
  const heroRef  = useRef<HTMLElement>(null);
  const bodyRef  = useRef<HTMLDivElement>(null);

  // Hero entrance — fires once after mount
  useEnter(heroRef, { selector: ".enter", y: 20, stagger: 0.07, duration: 0.6 });

  // Body scroll reveals
  useReveal(bodyRef, { selector: ".reveal", y: 18, duration: 0.55, start: "top 90%" });

  return (
    <main>
      <Navbar />
      {/* ── HERO ── */}
      <section ref={heroRef} className="container-cyber pt-24 pb-20">
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
          {/* Left */}
          <div className="lg:col-span-8 space-y-6">
            <div className="enter flex items-center gap-3">
              <div className="w-2 h-2 bg-[#00e5ff] animate-pulse" />
              <span className="font-mono text-[10px] tracking-[0.4em] text-[#888] uppercase">
                ACADEMIC SOLUTIONS SYSTEM // ACTIVE
              </span>
            </div>
            <h1 className="enter font-mono font-black text-5xl sm:text-7xl md:text-8xl leading-[1] tracking-tighter text-[#e4e4e4]">
              SKIP<br /><span className="text-[#00e5ff]">THE</span><br />STRUGGLE_
            </h1>
            <p className="enter font-mono text-sm text-[#888] max-w-md leading-relaxed">
              // Kami handle semua tugasmu. Cepat, aman, dan hasilnya bisa kamu bangga-banggain ke dosen.
            </p>
            <div className="enter flex flex-wrap gap-4 pt-4">
              <Link href="/order" className="btn btn-primary">[ ORDER NOW ]</Link>
              <Link href="#work" className="btn">[ VIEW SAMPLES ]</Link>
            </div>
          </div>

          {/* Stats Bento */}
          <div className="lg:col-span-4 grid grid-cols-2 gap-3">
            {STATS.map((s) => (
              <div key={s.key} className="enter bento p-5">
                <div className="font-mono text-[8px] text-[#444] uppercase tracking-widest mb-3">{s.key}</div>
                <div className="font-mono font-black text-3xl" style={{ color: s.color }}>{s.val}</div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* ── REST OF PAGE ── */}
      <div ref={bodyRef}>
        {/* Divider */}
        <div className="container-cyber">
          <div className="flex items-center gap-4 py-2">
            <div className="h-px flex-1" style={{ background: "var(--border)" }} />
            <span className="font-mono text-[9px] text-[#333] tracking-widest">SERVICES.LIST</span>
            <div className="h-px flex-1" style={{ background: "var(--border)" }} />
          </div>
        </div>

        {/* ── SERVICES BENTO ── */}
        <section className="container-cyber py-16" id="work">
          <div className="mb-8 reveal">
            <div className="font-mono text-[9px] text-[#444] tracking-widest mb-2">// SERVICE CATALOG</div>
            <h2 className="font-mono font-black text-4xl md:text-5xl text-[#e4e4e4]">
              WHAT WE <span className="text-[#00e5ff]">HANDLE_</span>
            </h2>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
            {SERVICES.map((s) => (
              <div key={s.id} className={`reveal bento bento-hover p-8 flex flex-col justify-between min-h-[220px] group ${s.span}`}>
                <div>
                  <div className="flex items-center justify-between mb-6">
                    <span className="font-mono text-[9px] text-[#444] tracking-widest">{s.id}</span>
                    <span className="tag">{s.tag}</span>
                  </div>
                  <h3 className="font-mono font-bold text-xl text-[#e4e4e4] group-hover:text-[#00e5ff] transition-colors mb-3">{s.name}</h3>
                  <p className="font-mono text-xs text-[#888] leading-relaxed">{s.desc}</p>
                </div>
                <div className="mt-8 flex items-center gap-2">
                  <div className="h-px flex-1" style={{ background: "var(--border)" }} />
                  <span className="font-mono text-[9px] text-[#444] group-hover:text-[#00e5ff] transition-colors">ORDER →</span>
                </div>
              </div>
            ))}
          </div>
        </section>

        {/* ── HOW IT WORKS ── */}
        <section className="container-cyber py-16" id="how">
          <div className="mb-8 reveal">
            <div className="font-mono text-[9px] text-[#444] tracking-widest mb-2">// PROCESS</div>
            <h2 className="font-mono font-black text-4xl md:text-5xl text-[#e4e4e4]">
              HOW IT <span className="text-[#00e5ff]">WORKS_</span>
            </h2>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-4 gap-3">
            {[
              { n: "01", title: "SUBMIT_BRIEF",    desc: "Isi form dengan detail tugas, deadline, dan catatan khusus." },
              { n: "02", title: "GET_QUOTE",        desc: "Sistem kami kalkulasi harga berdasarkan kompleksitas dan urgensi." },
              { n: "03", title: "EXPERT_ASSIGNED",  desc: "Expert terbaik di bidangnya langsung handle proyek kamu." },
              { n: "04", title: "RECEIVE_RESULT",   desc: "File siap kirim ke dashboard kamu sebelum deadline." },
            ].map((step) => (
              <div key={step.n} className="reveal bento p-8">
                <div className="font-mono font-black text-5xl text-[#1a1a1a] mb-6">{step.n}</div>
                <h4 className="font-mono font-bold text-sm text-[#00e5ff] mb-3">{step.title}</h4>
                <p className="font-mono text-xs text-[#888] leading-relaxed">{step.desc}</p>
              </div>
            ))}
          </div>
        </section>

        {/* ── PRICING ── */}
        <section className="container-cyber py-16" id="price">
          <div className="mb-8 reveal">
            <div className="font-mono text-[9px] text-[#444] tracking-widest mb-2">// PRICING</div>
            <h2 className="font-mono font-black text-4xl md:text-5xl text-[#e4e4e4]">
              INVEST IN <span className="text-[#00e5ff]">RESULTS_</span>
            </h2>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
            {[
              { tier: "BASIC",   price: "IDR 50K+",  items: ["Tugas harian", "Kuis & Quiz", "Ringkasan", "Revisi 1x"],           highlight: false },
              { tier: "PREMIUM", price: "IDR 250K+", items: ["Skripsi & Thesis", "Laporan praktikum", "Presentasi full", "Revisi unlimited"], highlight: true },
            ].map((plan) => (
              <div key={plan.tier} className={`reveal bento p-10 ${plan.highlight ? "bento-active" : ""}`}>
                <div className="flex justify-between items-start mb-8">
                  <div>
                    <div className="font-mono text-[9px] text-[#444] tracking-widest mb-2">TIER</div>
                    <div className="font-mono font-black text-3xl text-[#e4e4e4]">{plan.tier}</div>
                  </div>
                  <div className="text-right">
                    <div className="font-mono text-[9px] text-[#444] tracking-widest mb-2">STARTING AT</div>
                    <div className="font-mono font-black text-2xl text-[#00e5ff]">{plan.price}</div>
                  </div>
                </div>
                <div className="space-y-3 mb-10 border-t pt-8" style={{ borderColor: "var(--border)" }}>
                  {plan.items.map(item => (
                    <div key={item} className="flex items-center gap-3 font-mono text-xs text-[#888]">
                      <span className="text-[#00e5ff]">›</span>{item}
                    </div>
                  ))}
                </div>
                <Link href="/order" className={`btn w-full justify-center ${plan.highlight ? "btn-primary" : ""}`}>
                  [ SELECT {plan.tier} ]
                </Link>
              </div>
            ))}
          </div>
        </section>

        <Footer />
      </div>
    </main>
  );
}
