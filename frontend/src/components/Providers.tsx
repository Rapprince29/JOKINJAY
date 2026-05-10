"use client";

import { useEffect } from "react";
import { SessionProvider } from "next-auth/react";

export function Providers({ children }: { children: React.ReactNode }) {
  useEffect(() => {
    if ("serviceWorker" in navigator) {
      navigator.serviceWorker
        .register("/sw.js")
        .then((reg) => console.log("SW Registered: ", reg.scope))
        .catch((err) => console.log("SW Failed: ", err));
    }
  }, []);

  return <SessionProvider>{children}</SessionProvider>;
}
