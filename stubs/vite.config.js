import { defineConfig } from "vite";
import symfonyPlugin from "vite-plugin-symfony";
import react from "@vitejs/plugin-react";
import { watch } from "vite-plugin-watch";

export default defineConfig({
  plugins: [
    react(),
    symfonyPlugin(),
    watch({
      pattern: ["src/Controller/**/*.php", "config/routes.yaml"],
      command:
        "symfony console fos:js-routing:dump --format=json --target=assets/js/routes.json",
      silent: true,
    }),
  ],
  root: ".",
  base: "/build/",
  publicDir: false,
  resolve: {
    alias: {
      "@": "/assets/js",
      "@img": "/assets/img",
    },
  },
  build: {
    manifest: true,
    emptyOutDir: true,
    assetsDir: "",
    outDir: "./public/build",
    rollupOptions: {
      input: {
        app: "./assets/js/app.jsx",
      },
    },
  },
});
