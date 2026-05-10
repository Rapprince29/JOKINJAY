import { useEffect } from "react";
import gsap from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";

gsap.registerPlugin(ScrollTrigger);

function isLowEndDevice(): boolean {
  if (typeof window === "undefined") return false;
  const reducedMotion = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
  const cpuCores = navigator.hardwareConcurrency ?? 4;
  return reducedMotion || cpuCores <= 2;
}

/**
 * useReveal — scroll-triggered fade-up. Fires once per element.
 * Skips entirely on low-end / reduced-motion devices.
 */
export function useReveal(
  scopeRef: React.RefObject<HTMLElement | HTMLDivElement | null>,
  options?: {
    selector?: string;
    y?: number;
    duration?: number;
    stagger?: number;
    start?: string;
  }
) {
  useEffect(() => {
    if (!scopeRef.current) return;

    const {
      selector = ".reveal",
      y = 20,
      duration = 0.55,
      stagger = 0,
      start = "top 90%",
    } = options ?? {};

    if (isLowEndDevice()) {
      scopeRef.current.querySelectorAll<HTMLElement>(selector).forEach((el) => {
        el.style.opacity = "1";
        el.style.transform = "none";
      });
      return;
    }

    const ctx = gsap.context(() => {
      const els = gsap.utils.toArray<HTMLElement>(selector, scopeRef.current!);
      if (!els.length) return;

      if (stagger > 0 && els.length > 1) {
        // Explicitly set initial state, then animate TO target
        gsap.set(els, { opacity: 0, y, force3D: true });
        ScrollTrigger.create({
          trigger: els[0],
          start,
          once: true,
          onEnter: () => {
            gsap.to(els, { opacity: 1, y: 0, duration, stagger, ease: "power2.out", force3D: true });
          },
        });
      } else {
        els.forEach((el) => {
          gsap.set(el, { opacity: 0, y, force3D: true });
          ScrollTrigger.create({
            trigger: el,
            start,
            once: true,
            onEnter: () => {
              gsap.to(el, { opacity: 1, y: 0, duration, ease: "power2.out", force3D: true });
            },
          });
        });
      }
    }, scopeRef);

    return () => ctx.revert();
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);
}

/**
 * useEnter — entrance animation on mount (no scroll trigger).
 * Uses gsap.set + gsap.to to avoid elements being stuck invisible.
 * Skips entirely on low-end / reduced-motion devices.
 */
export function useEnter(
  scopeRef: React.RefObject<HTMLElement | null>,
  options?: {
    selector?: string;
    y?: number;
    duration?: number;
    stagger?: number;
    delay?: number;
  }
) {
  useEffect(() => {
    if (!scopeRef.current) return;

    const {
      selector = ".enter",
      y = 16,
      duration = 0.6,
      stagger = 0.06,
      delay = 0.1, // small delay so layout is stable before animation
    } = options ?? {};

    if (isLowEndDevice()) return; // elements remain at natural opacity, no animation needed

    const ctx = gsap.context(() => {
      const els = gsap.utils.toArray<HTMLElement>(selector, scopeRef.current!);
      if (!els.length) return;

      // Explicitly set FROM state, then animate TO natural state
      gsap.set(els, { opacity: 0, y, force3D: true });
      gsap.to(els, {
        opacity: 1,
        y: 0,
        duration,
        stagger,
        delay,
        ease: "power2.out",
        force3D: true,
      });
    }, scopeRef);

    return () => ctx.revert();
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);
}
