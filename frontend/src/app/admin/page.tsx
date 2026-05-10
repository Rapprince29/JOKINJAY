"use client";

import { useState } from "react";
import Navbar from "@/components/Navbar";

const ORDERS = [
  { id: "ORD-001", user: "Budi", title: "Strategic Market Analysis", status: "IN_PROGRESS", expert: "EXP_ALPHA", deadline: "10 May 2026", price: "2.000.000" },
  { id: "ORD-002", user: "Sari", title: "Theoretical Physics Report", status: "REVIEW",       expert: "EXP_BETA",  deadline: "12 May 2026", price: "1.200.000" },
  { id: "ORD-003", user: "Andi", title: "Visual Design Presentation", status: "DELIVERED",    expert: "EXP_GAMMA", deadline: "8 May 2026",  price: "1.500.000" },
  { id: "ORD-004", user: "Dewi", title: "Chemical Synthesis Report",  status: "PENDING",      expert: "—",         deadline: "15 May 2026", price: "1.800.000" },
];

const STATUS_COLOR: Record<string, string> = {
  IN_PROGRESS: "var(--amber)",
  REVIEW:      "var(--cyan)",
  DELIVERED:   "var(--green)",
  PENDING:     "var(--text-3)",
};

type Tab = "registry" | "assign" | "finance" | "qc";

const STATS = [
  { k: "TOTAL_REVENUE", v: "Rp 14.5M", c: "var(--cyan)" },
  { k: "ACTIVE_ORDERS", v: "12", c: "var(--amber)" },
  { k: "QC_PENDING",    v: "03", c: "var(--red)" },
  { k: "DELIVERED",     v: "128", c: "var(--green)" },
];

export default function AdminPage() {
  const [tab, setTab] = useState<Tab>("registry");

  return (
    <main className="min-h-screen">
      <Navbar variant="admin" userRole="ADMIN_CONSOLE" userName="ADMIN_01" />

      <div className="container-cyber py-10">
        {/* Header */}
        <div className="bento p-5 mb-6 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
          <div>
            <div className="font-mono text-[9px] text-[#444] tracking-widest mb-1">// CENTRAL COMMAND</div>
            <h1 className="font-mono font-black text-2xl text-[#e4e4e4]">ADMIN<span className="text-[#00e5ff]">_PANEL</span></h1>
          </div>
          <div className="flex items-center gap-2">
            <div className="w-1.5 h-1.5 rounded-full bg-[#00ff88] animate-pulse" />
            <span className="font-mono text-[9px] text-[#00ff88] uppercase tracking-widest">SYSTEM ACTIVE</span>
          </div>
        </div>

        {/* Stats */}
        <div className="grid grid-cols-2 md:grid-cols-4 gap-3 mb-6">
          {STATS.map(s => (
            <div key={s.k} className="bento p-6">
              <div className="font-mono text-[8px] text-[#444] tracking-widest mb-3">{s.k}</div>
              <div className="font-mono font-black text-2xl" style={{ color: s.c }}>{s.v}</div>
            </div>
          ))}
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-5 gap-6">
          {/* Sidebar Nav */}
          <aside className="lg:col-span-1">
            <div className="bento overflow-hidden">
              {(["registry", "assign", "qc", "finance"] as Tab[]).map(t => (
                <button key={t} onClick={() => setTab(t)}
                  className="w-full text-left px-5 py-4 font-mono text-[10px] uppercase tracking-widest border-b transition-all"
                  style={{
                    borderColor: "var(--border)",
                    background: tab === t ? "var(--cyan-dim)" : "transparent",
                    color: tab === t ? "var(--cyan)" : "var(--text-2)",
                    borderLeft: tab === t ? "2px solid var(--cyan)" : "2px solid transparent",
                  }}>
                  {tab === t ? "▶ " : "  "}/{t}
                </button>
              ))}
            </div>
          </aside>

          {/* Content */}
          <div className="lg:col-span-4">
            {tab === "registry" && (
              <div className="bento overflow-x-auto">
                <table className="w-full font-mono text-xs min-w-[700px]">
                  <thead>
                    <tr className="border-b" style={{ borderColor: "var(--border)", background: "var(--bg-2)" }}>
                      {["ID", "CLIENT", "TITLE", "EXPERT", "STATUS", "PRICE", ""].map(h => (
                        <th key={h} className="px-6 py-4 text-left text-[9px] uppercase tracking-widest text-[#444] font-bold">{h}</th>
                      ))}
                    </tr>
                  </thead>
                  <tbody>
                    {ORDERS.map(o => (
                      <tr key={o.id} className="border-b transition-all hover:bg-[#111]" style={{ borderColor: "var(--border)" }}>
                        <td className="px-6 py-4 text-[#00e5ff] font-bold">{o.id}</td>
                        <td className="px-6 py-4 text-[#e4e4e4]">{o.user}</td>
                        <td className="px-6 py-4 text-[#888] max-w-[180px] truncate">{o.title}</td>
                        <td className="px-6 py-4 text-[#00e5ff]">{o.expert}</td>
                        <td className="px-6 py-4">
                          <span className="tag text-[8px]"
                            style={{ color: STATUS_COLOR[o.status], background: `${STATUS_COLOR[o.status]}10`, borderColor: `${STATUS_COLOR[o.status]}30` }}>
                            {o.status}
                          </span>
                        </td>
                        <td className="px-6 py-4 text-[#e4e4e4]">Rp {o.price}</td>
                        <td className="px-6 py-4">
                          <button className="btn text-[8px] py-1 px-3">[ VIEW ]</button>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            )}

            {tab !== "registry" && (
              <div className="bento p-16 flex flex-col items-center justify-center h-80 text-center">
                <div className="font-mono text-4xl text-[#1a1a1a] mb-6">_</div>
                <div className="font-mono text-[9px] text-[#444] uppercase tracking-widest">// MODULE: {tab.toUpperCase()}</div>
                <div className="font-mono text-xs text-[#333] mt-3">ACCESS LEVEL: ADMIN // LOADING MODULE...</div>
              </div>
            )}
          </div>
        </div>
      </div>
    </main>
  );
}
