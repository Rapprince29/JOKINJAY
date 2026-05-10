"use client";

import { useState } from "react";
import Navbar from "@/components/Navbar";

const TASKS = [
  { id: "ORD-001", title: "Strategic Market Analysis", deadline: "10 May 2026 18:00", reward: "Rp 1.400.000", status: "ACTIVE", client: "CLIENT_USR001" },
  { id: "ORD-004", title: "Chemical Synthesis Report",  deadline: "15 May 2026",       reward: "Rp 1.800.000", status: "BIDDING", client: "CLIENT_USR004" },
];

export default function JokiWorkspace() {
  const [activeTask, setActiveTask] = useState(TASKS[0]);
  const [log, setLog] = useState<string[]>(["[09:00] Expert assigned to ORD-001", "[09:05] Brief reviewed"]);
  const [note, setNote] = useState("");

  const addLog = () => {
    if (!note.trim()) return;
    setLog(prev => [...prev, `[${new Date().toLocaleTimeString("id-ID", { hour: "2-digit", minute: "2-digit" })}] ${note}`]);
    setNote("");
  };

  return (
    <main className="min-h-screen">
      <Navbar variant="joki" userRole="EXPERT_STUDIO" userName="EXP_ALPHA" />

      <div className="container-cyber py-10 grid grid-cols-1 lg:grid-cols-12 gap-6">
        {/* Task List */}
        <div className="lg:col-span-4 space-y-3">
          <div className="font-mono text-[9px] text-[#444] tracking-widest mb-4">// ASSIGNED TASKS</div>
          {TASKS.map(t => (
            <button key={t.id} onClick={() => setActiveTask(t)}
              className="w-full text-left bento p-6 space-y-4 transition-all hover:border-[#2a2a2a]"
              style={{ borderColor: activeTask.id === t.id ? "var(--cyan)" : "var(--border)", background: activeTask.id === t.id ? "var(--cyan-dim)" : "var(--bg-1)" }}>
              <div className="flex justify-between items-center">
                <span className="font-mono text-[9px] text-[#444] tracking-widest">{t.id}</span>
                <span className="tag" style={{ color: t.status === "ACTIVE" ? "var(--green)" : "var(--amber)", background: "transparent", borderColor: "transparent" }}>
                  {t.status}
                </span>
              </div>
              <div className="font-mono font-bold text-sm text-[#e4e4e4] leading-snug">{t.title}</div>
              <div className="flex justify-between font-mono text-[9px] pt-3 border-t" style={{ borderColor: "var(--border)" }}>
                <span className="text-[#444]">{t.deadline}</span>
                <span className="text-[#00e5ff]">{t.reward}</span>
              </div>
            </button>
          ))}
        </div>

        {/* Workspace */}
        <div className="lg:col-span-8 space-y-4">
          {/* Task Header */}
          <div className="bento p-8 flex flex-col sm:flex-row justify-between items-start gap-6">
            <div>
              <div className="flex items-center gap-3 mb-3">
                <span className="font-mono text-[9px] text-[#444] tracking-widest">{activeTask.id}</span>
                <span className="tag" style={{ color: "var(--green)" }}>ACTIVE</span>
              </div>
              <h2 className="font-mono font-black text-2xl text-[#e4e4e4]">{activeTask.title}</h2>
              <div className="font-mono text-[9px] text-[#444] mt-2">{activeTask.client}</div>
            </div>
            <div className="bento p-5 text-center" style={{ background: "var(--bg-2)" }}>
              <div className="font-mono text-[8px] text-[#444] tracking-widest mb-2">CHRONOS</div>
              <div className="font-mono font-black text-2xl text-[#00e5ff]">42:15:08</div>
            </div>
          </div>

          {/* Brief */}
          <div className="bento p-8 space-y-4">
            <div className="font-mono text-[9px] text-[#444] tracking-widest">// CLIENT BRIEF</div>
            <div className="p-5 border font-mono text-xs text-[#888] leading-relaxed" style={{ borderColor: "var(--border)", background: "var(--bg-2)" }}>
              "Apply rigorous academic synthesis to the provided materials. Ensure scholarly quality with innovative insights. Format per institutional standards."
            </div>
          </div>

          {/* Bento Action Grid */}
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <label className="bento p-8 flex flex-col items-center justify-center text-center min-h-[140px] cursor-pointer hover:border-[#2a2a2a] group transition-all">
              <input type="file" className="hidden" />
              <div className="font-mono text-2xl text-[#2a2a2a] group-hover:text-[#444] mb-3 transition-colors">↑</div>
              <div className="font-mono text-[10px] text-[#444] uppercase tracking-widest group-hover:text-[#888] transition-colors">UPLOAD_RESULT.FILE</div>
              <div className="font-mono text-[8px] text-[#333] mt-2">PDF, DOCX, ZIP accepted</div>
            </label>

            <button className="bento bento-active p-8 flex flex-col items-center justify-center text-center min-h-[140px] group hover:bg-[rgba(0,229,255,0.1)] transition-all">
              <div className="font-mono text-2xl text-[#00e5ff] mb-3">✓</div>
              <div className="font-mono text-[10px] text-[#00e5ff] uppercase tracking-widest">SUBMIT_FINAL</div>
              <div className="font-mono text-[8px] text-[#444] mt-2">Mark as delivered</div>
            </button>
          </div>

          {/* Activity Log */}
          <div className="bento p-6 space-y-4">
            <div className="font-mono text-[9px] text-[#444] tracking-widest">// ACTIVITY LOG</div>
            <div className="space-y-2 max-h-36 overflow-y-auto">
              {log.map((line, i) => (
                <div key={i} className="font-mono text-[10px] text-[#888]">
                  <span className="text-[#444]">{line.substring(0, 7)}</span>{line.substring(7)}
                </div>
              ))}
            </div>
            <div className="flex gap-3 pt-2 border-t" style={{ borderColor: "var(--border)" }}>
              <input
                type="text"
                value={note}
                onChange={e => setNote(e.target.value)}
                onKeyDown={e => e.key === "Enter" && addLog()}
                placeholder="// Add log entry..."
                className="input flex-1 text-xs py-2"
              />
              <button onClick={addLog} className="btn btn-primary text-[9px] px-4">[ LOG ]</button>
            </div>
          </div>
        </div>
      </div>
    </main>
  );
}
