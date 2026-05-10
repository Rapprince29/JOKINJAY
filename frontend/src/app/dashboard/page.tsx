"use client";

import { useState, useRef } from "react";
import Link from "next/link";
import { useSession } from "next-auth/react";
import Navbar from "@/components/Navbar";
import { useEnter, useReveal } from "@/hooks/useGsap";

const ORDERS = [
  { 
    id: "ORD-001", 
    title: "Strategic Market Analysis",   
    status: "IN_PROGRESS", 
    progress: 65,  
    deadline: "10 May 2026", 
    expert: "EXP_ALPHA",
    desc: "Analisis pasar strategis untuk ekspansi bisnis teknologi di Asia Tenggara. Fokus pada penetrasi pasar dan analisis kompetitor.",
    price: "Rp 1.200.000"
  },
  { 
    id: "ORD-002", 
    title: "Theoretical Physics Report",  
    status: "REVIEW",      
    progress: 90,  
    deadline: "12 May 2026", 
    expert: "EXP_BETA",
    desc: "Laporan penelitian mendalam mengenai kuantum mekanik dan relativitas umum. Termasuk kalkulasi matematis kompleks.",
    price: "Rp 2.500.000"
  },
  { 
    id: "ORD-003", 
    title: "Visual Design Presentation",  
    status: "DELIVERED",   
    progress: 100, 
    deadline: "8 May 2026",  
    expert: "EXP_GAMMA",
    desc: "Desain deck presentasi untuk pitching startup. 20 slide dengan animasi premium dan infografis custom.",
    price: "Rp 850.000"
  },
];

const STATUS_COLOR: Record<string, string> = {
  IN_PROGRESS: "var(--amber)",
  REVIEW:      "var(--cyan)",
  DELIVERED:   "var(--green)",
};

export default function DashboardPage() {
  const { data: session } = useSession();
  const headerRef = useRef<HTMLDivElement>(null);
  const bodyRef   = useRef<HTMLDivElement>(null);
  const [tab, setTab] = useState<"orders" | "messages" | "logs">("orders");
  
  // State untuk Detail Modal
  const [selectedOrder, setSelectedOrder] = useState<typeof ORDERS[0] | null>(null);

  const displayName = session?.user?.name 
    ? session.user.name.toUpperCase().replace(/\s+/g, '_') 
    : "USR_001";

  useEnter(headerRef, { selector: ".enter", y: 14, stagger: 0.06, duration: 0.5 });
  useReveal(bodyRef,  { selector: ".reveal", y: 16, duration: 0.5, start: "top 92%" });

  return (
    <main className="min-h-screen">
      <Navbar variant="dashboard" userRole="STUDENT_PORTAL" userName={displayName} />

      <div className="container-cyber py-10">
        {/* Header */}
        <div ref={headerRef} className="bento p-5 mb-6 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
          <div>
            <div className="enter font-mono text-[9px] text-[#444] tracking-widest mb-1">// STUDENT DASHBOARD</div>
            <h1 className="enter font-mono font-black text-2xl text-[#e4e4e4]">
              WELCOME, <span className="text-[#00e5ff]">{displayName}_</span>
            </h1>
          </div>
          <Link href="/order" className="enter btn btn-primary">[ + NEW ORDER ]</Link>
        </div>

        {/* Stats */}
        <div ref={bodyRef} className="grid grid-cols-2 md:grid-cols-4 gap-3 mb-6">
          {[
            { k: "TOTAL_ORDERS", v: "03", c: "var(--cyan)" },
            { k: "IN_PROGRESS",  v: "02", c: "var(--amber)" },
            { k: "DELIVERED",    v: "01", c: "var(--green)" },
            { k: "SUCCESS_RATE", v: "100%", c: "var(--green)" },
          ].map((s) => (
            <div key={s.k} className="reveal bento p-6">
              <div className="font-mono text-[8px] text-[#444] tracking-widest mb-3">{s.k}</div>
              <div className="font-mono font-black text-3xl" style={{ color: s.c }}>{s.v}</div>
            </div>
          ))}
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-4 gap-6">
          {/* Sidebar */}
          <aside className="lg:col-span-1 space-y-3 reveal">
            <div className="bento overflow-hidden">
              {(["orders", "messages", "logs"] as const).map((t) => (
                <button
                  key={t}
                  onClick={() => setTab(t)}
                  className="w-full text-left px-5 py-4 font-mono text-[10px] uppercase tracking-widest border-b transition-all"
                  style={{
                    borderColor: "var(--border)",
                    background:  tab === t ? "var(--cyan-dim)" : "transparent",
                    color:       tab === t ? "var(--cyan)" : "var(--text-2)",
                    borderLeft:  tab === t ? "2px solid var(--cyan)" : "2px solid transparent",
                  }}
                >
                  {tab === t ? "▶ " : "  "}/{t}
                </button>
              ))}
            </div>

            <div className="bento p-6 space-y-4 reveal">
              <div className="w-12 h-12 border-2 flex items-center justify-center font-mono font-black text-lg text-[#00e5ff]"
                style={{ borderColor: "var(--cyan)", background: "var(--cyan-dim)" }}>
                {displayName.charAt(0)}
              </div>
              <div>
                <div className="font-mono font-bold text-sm text-[#e4e4e4]">{displayName}</div>
                <div className="font-mono text-[9px] text-[#444] tracking-widest mt-1">STUDENT // ACTIVE</div>
              </div>
              <div className="flex items-center gap-2">
                <div className="w-1.5 h-1.5 rounded-full bg-[#00ff88]" />
                <span className="font-mono text-[9px] text-[#00ff88]">SESSION ACTIVE</span>
              </div>
            </div>

            <Link href="/order" className="reveal btn btn-primary w-full justify-center">[ + NEW ORDER ]</Link>
          </aside>

          {/* Main Content */}
          <div className="lg:col-span-3 space-y-4">
            {tab === "orders" && (
              <>
                <div className="font-mono text-[9px] text-[#444] tracking-widest mb-4 reveal">// ORDER REGISTRY</div>
                {ORDERS.map((o) => (
                  <div key={o.id} className="reveal bento p-6 space-y-5 group hover:border-[#2a2a2a] transition-all">
                    <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
                      <div>
                        <div className="flex items-center gap-3 mb-2">
                          <span className="font-mono text-[9px] text-[#444] tracking-widest">{o.id}</span>
                          <span className="tag"
                            style={{ color: STATUS_COLOR[o.status], background: `${STATUS_COLOR[o.status]}10`, borderColor: `${STATUS_COLOR[o.status]}30` }}>
                            {o.status}
                          </span>
                        </div>
                        <h3 className="font-mono font-bold text-base text-[#e4e4e4] group-hover:text-[#00e5ff] transition-colors">{o.title}</h3>
                      </div>
                    </div>

                    <div className="space-y-2">
                      <div className="flex justify-between font-mono text-[9px]">
                        <span className="text-[#444] uppercase tracking-widest">PROGRESS</span>
                        <span style={{ color: STATUS_COLOR[o.status] }}>{o.progress}%</span>
                      </div>
                      <div className="h-[2px] bg-[#1a1a1a] overflow-hidden">
                        <div className="h-full transition-all duration-700"
                          style={{ width: `${o.progress}%`, background: STATUS_COLOR[o.status] }} />
                      </div>
                    </div>

                    <div className="flex flex-wrap gap-6 pt-2 border-t font-mono text-[9px] text-[#444]" style={{ borderColor: "var(--border)" }}>
                      <span>DEADLINE: <span className="text-[#888]">{o.deadline}</span></span>
                      <span>EXPERT: <span className="text-[#00e5ff]">{o.expert}</span></span>
                    </div>

                    <div className="flex gap-3">
                      <button 
                        onClick={() => setSelectedOrder(o)}
                        className="btn text-[9px] py-1.5"
                      >
                        [ DETAILS ]
                      </button>
                      <button 
                        onClick={() => setTab("messages")}
                        className="btn text-[9px] py-1.5"
                      >
                        [ MESSAGE ]
                      </button>
                    </div>
                  </div>
                ))}
              </>
            )}

            {tab !== "orders" && (
              <div className="bento p-16 flex flex-col items-center justify-center h-80 text-center">
                <div className="font-mono text-4xl text-[#1a1a1a] mb-6">_</div>
                <div className="font-mono text-[9px] text-[#444] uppercase tracking-widest">// MODULE: {tab.toUpperCase()}</div>
                <div className="font-mono text-xs text-[#333] mt-3">ENCRYPTED CHANNEL. LOADING...</div>
              </div>
            )}
          </div>
        </div>
      </div>

      {/* ── DETAILS MODAL ── */}
      {selectedOrder && (
        <div className="fixed inset-0 z-[100] flex items-center justify-center p-6 bg-[#000000dd] backdrop-blur-sm">
          <div className="bento w-full max-w-lg p-8 relative animate-in fade-in zoom-in duration-200">
            <button 
              onClick={() => setSelectedOrder(null)}
              className="absolute top-6 right-6 font-mono text-xl text-[#444] hover:text-[#00e5ff]"
            >
              ×
            </button>
            
            <div className="font-mono text-[9px] text-[#00e5ff] tracking-[0.3em] mb-6 uppercase">
              // ORDER_DATA_OS_{selectedOrder.id}
            </div>
            
            <h2 className="font-mono font-black text-2xl text-[#e4e4e4] mb-8">
              {selectedOrder.title}
            </h2>

            <div className="space-y-6">
              <div className="grid grid-cols-2 gap-4">
                <div className="p-4 bg-[#111] border border-[#222]">
                  <div className="font-mono text-[8px] text-[#444] mb-1">STATUS</div>
                  <div className="font-mono font-bold text-xs" style={{ color: STATUS_COLOR[selectedOrder.status] }}>
                    {selectedOrder.status}
                  </div>
                </div>
                <div className="p-4 bg-[#111] border border-[#222]">
                  <div className="font-mono text-[8px] text-[#444] mb-1">PRICE</div>
                  <div className="font-mono font-bold text-xs text-[#00e5ff]">
                    {selectedOrder.price}
                  </div>
                </div>
              </div>

              <div className="space-y-2">
                <div className="font-mono text-[8px] text-[#444] uppercase tracking-widest">DESCRIPTION</div>
                <p className="font-mono text-xs text-[#888] leading-relaxed italic">
                   "{selectedOrder.desc}"
                </p>
              </div>

              <div className="grid grid-cols-2 gap-4 pt-4 border-t border-[#222]">
                <div>
                  <div className="font-mono text-[8px] text-[#444] mb-1">ASSIGNED_EXPERT</div>
                  <div className="font-mono text-xs text-[#e4e4e4]">{selectedOrder.expert}</div>
                </div>
                <div>
                  <div className="font-mono text-[8px] text-[#444] mb-1">TARGET_DEADLINE</div>
                  <div className="font-mono text-xs text-[#e4e4e4]">{selectedOrder.deadline}</div>
                </div>
              </div>
            </div>

            <div className="mt-10 flex gap-3">
              <button onClick={() => setSelectedOrder(null)} className="btn flex-1 justify-center">[ CLOSE ]</button>
              <button 
                onClick={() => { setTab("messages"); setSelectedOrder(null); }}
                className="btn btn-primary flex-1 justify-center"
              >
                [ CONTACT EXPERT ]
              </button>
            </div>
          </div>
        </div>
      )}
    </main>
  );
}
