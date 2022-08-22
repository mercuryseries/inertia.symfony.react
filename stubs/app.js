import React from "react";
import { createRoot } from "react-dom/client";
import { createInertiaApp } from "@inertiajs/inertia-react";
import { InertiaProgress } from "@inertiajs/progress";
import Layout from "@/components/Layout";
import "../css/app.css";

InertiaProgress.init({ showSpinner: true });

const appName = document.getElementsByTagName("title")[0]?.innerText;

createInertiaApp({
  title: (title) => `${title} | ${appName}`,
  resolve: (name) => {
    const page = require(`./pages/${name}`).default;
    page.layout ||= Layout;
    return page;
  },
  setup({ el, App, props }) {
    createRoot(el).render(<App {...props} />);
  },
});
