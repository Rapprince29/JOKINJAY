import Link from "next/link";

export default function Footer() {
  return (
    <footer className="border-t mt-32" style={{ borderColor: "var(--border)", background: "var(--bg-1)" }}>
      <div className="container-cyber py-16">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-12">
          {/* Brand */}
          <div className="space-y-4">
            <div className="font-mono font-black text-2xl">
              JOKI<span className="text-cyan">JAY</span>
            </div>
            <p className="text-xs font-mono text-dim leading-relaxed max-w-xs">
              // Platform akademik profesional untuk mahasiswa yang butuh solusi cepat, aman, dan tepat sasaran.
            </p>
            <div className="flex items-center gap-2 pt-2">
              <div className="w-1.5 h-1.5 rounded-full bg-[#00ff88] animate-pulse" />
              <span className="text-[9px] font-mono text-[#00ff88] uppercase tracking-widest">SYSTEM ONLINE</span>
            </div>
          </div>

          {/* Nav */}
          <div className="space-y-4">
            <div className="text-[9px] font-mono text-[#444] uppercase tracking-widest mb-6">// NAVIGATION</div>
            <div className="grid grid-cols-2 gap-3">
              {[
                { label: "/home", href: "/" },
                { label: "/login", href: "/login" },
                { label: "/order", href: "/order" },
                { label: "/dashboard", href: "/dashboard" },
              ].map(item => (
                <Link key={item.href} href={item.href} className="text-[11px] font-mono text-dim hover:text-cyan transition-colors">
                  {item.label}
                </Link>
              ))}
            </div>
          </div>

          {/* Stats */}
          <div className="space-y-4">
            <div className="text-[9px] font-mono text-[#444] uppercase tracking-widest mb-6">// SYSTEM STATUS</div>
            <div className="space-y-3">
              {[
                { k: "UPTIME", v: "99.9%" },
                { k: "EXPERTS", v: "50+" },
                { k: "DELIVERED", v: "2.5K+" },
                { k: "GRADE_AVG", v: "A" },
              ].map(item => (
                <div key={item.k} className="flex justify-between font-mono text-[10px]">
                  <span className="text-[#444]">{item.k}</span>
                  <span className="text-cyan">{item.v}</span>
                </div>
              ))}
            </div>
          </div>
        </div>

        <div className="flex flex-col md:flex-row justify-between items-center mt-16 pt-8 border-t" style={{ borderColor: "var(--border)" }}>
          <span className="font-mono text-[9px] text-[#333] uppercase tracking-widest">
            © 2026 JOKINJAY. ALL RIGHTS RESERVED.
          </span>
          <span className="font-mono text-[9px] text-[#333] uppercase tracking-widest mt-2 md:mt-0">
            BUILD: v2.0.1 // CYBER EDITION
          </span>
        </div>
      </div>
    </footer>
  );
}
