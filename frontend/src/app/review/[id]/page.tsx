"use client";

import { useState } from "react";
import Link from "next/link";

const RATINGS = ["TERRIBLE", "BELOW_AVG", "AVERAGE", "GREAT", "EXCEPTIONAL"];

export default function ReviewPage() {
  const [rating, setRating] = useState(0);
  const [hover, setHover] = useState(0);
  const [submitted, setSubmitted] = useState(false);
  const [review, setReview] = useState("");

  if (submitted) {
    return (
      <main className="min-h-screen flex flex-col items-center justify-center px-6">
        <div className="w-full max-w-md bento p-10 text-center space-y-6">
          <div className="font-mono font-black text-6xl text-[#00ff88]">✓</div>
          <div className="font-mono text-[9px] text-[#444] tracking-widest">// REVIEW SUBMITTED</div>
          <h2 className="font-mono font-black text-2xl text-[#e4e4e4]">REVIEW_LOGGED_</h2>
          <p className="font-mono text-xs text-[#888]">Terima kasih atas feedbacknya. Ini membantu kami meningkatkan kualitas layanan.</p>
          <Link href="/dashboard" className="btn btn-primary w-full justify-center">[ → RETURN TO DASHBOARD ]</Link>
        </div>
      </main>
    );
  }

  return (
    <main className="min-h-screen flex flex-col items-center justify-center px-6 py-12">
      <div className="w-full max-w-lg space-y-4">
        {/* Header */}
        <Link href="/dashboard" className="inline-flex items-center gap-2 mb-4 group">
          <div className="w-1.5 h-1.5 bg-[#00e5ff] group-hover:animate-ping" />
          <span className="font-mono text-[9px] text-[#888] hover:text-[#00e5ff] transition-colors tracking-widest uppercase">← /dashboard</span>
        </Link>

        <div className="bento p-8 space-y-8">
          {/* Order Info */}
          <div>
            <div className="font-mono text-[9px] text-[#444] tracking-widest mb-3">// REVIEW MODULE</div>
            <h1 className="font-mono font-black text-3xl text-[#e4e4e4]">
              RATE<span className="text-[#00e5ff]">_RESULT</span>
            </h1>
            <div className="flex items-center gap-4 mt-4 pt-4 border-t" style={{ borderColor: "var(--border)" }}>
              <span className="tag">ORD-003</span>
              <span className="font-mono text-xs text-[#888]">Visual Design Presentation</span>
            </div>
          </div>

          {/* Rating Stars */}
          <div className="space-y-4">
            <div className="font-mono text-[9px] text-[#444] tracking-widest">SATISFACTION_SCORE</div>
            <div className="flex gap-3">
              {[1, 2, 3, 4, 5].map((s) => (
                <button
                  key={s}
                  onMouseEnter={() => setHover(s)}
                  onMouseLeave={() => setHover(0)}
                  onClick={() => setRating(s)}
                  className="font-mono font-black text-3xl transition-all duration-100 hover:scale-125"
                  style={{ color: (hover || rating) >= s ? "var(--cyan)" : "var(--border-hi)" }}
                >
                  ✦
                </button>
              ))}
            </div>
            <div className="font-mono text-[10px] h-4" style={{ color: "var(--cyan)" }}>
              {(hover || rating) > 0 && `// ${RATINGS[(hover || rating) - 1]}`}
            </div>
          </div>

          {/* Review Text */}
          <div className="space-y-2">
            <div className="font-mono text-[9px] text-[#444] tracking-widest">FEEDBACK_TEXT</div>
            <textarea
              rows={4}
              placeholder="// Bagikan pendapatmu tentang hasil kerja expert..."
              value={review}
              onChange={e => setReview(e.target.value)}
              className="input resize-none leading-relaxed text-xs"
            />
          </div>

          <div className="flex gap-3">
            <Link href="/dashboard" className="btn flex-1 justify-center">[ SKIP ]</Link>
            <button
              onClick={() => rating > 0 && setSubmitted(true)}
              className="btn flex-1 justify-center"
              style={{
                background: rating > 0 ? "var(--cyan)" : "transparent",
                borderColor: rating > 0 ? "var(--cyan)" : "var(--border)",
                color: rating > 0 ? "#000" : "var(--text-3)",
              }}
            >
              [ SUBMIT_REVIEW ]
            </button>
          </div>
        </div>

        {/* Security Badge */}
        <div className="bento p-4 flex items-center gap-3" style={{ background: "var(--bg-1)" }}>
          <div className="w-1.5 h-1.5 rounded-full bg-[#00ff88]" />
          <span className="font-mono text-[9px] text-[#444] tracking-widest">REVIEW ANONIM & TERENKRIPSI</span>
        </div>
      </div>
    </main>
  );
}
