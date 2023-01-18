import React from "react";
import { createRoot } from "react-dom/client";
import { createInertiaApp } from "@inertiajs/react";
import Layout from "@/shared/Layout";
import "../css/app.css";

createInertiaApp({
  progress: {
    showSpinner: true
  },
  resolve: (name) => {
    const page = require(`./pages/${name}`).default;
    if (page.layout === undefined) {
      page.layout = Layout;
    }
    return page;
  },
  setup({ el, App, props }) {
    createRoot(el).render(<App {...props} />);
  }
});
