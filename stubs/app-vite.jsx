import { createRoot } from "react-dom/client";
import { createInertiaApp } from "@inertiajs/react";
import Layout from "@/components/Layout";
import "../styles/app.css";

import Routing from "fos-router";
import routes from "@/routes.json";
Routing.setRoutingData(routes);

const appName = "[TO_REPLACE]";

createInertiaApp({
  progress: {
    showSpinner: true,
  },
  title: (title) => (title ? `${title} | ${appName}` : appName),
  resolve: (name) => {
    const pages = import.meta.glob("./pages/**/*.jsx", { eager: true });
    const page = pages[`./pages/${name}.jsx`];
    if (page.default.layout === undefined) {
      page.default.layout = Layout;
    }
    return page;
  },
  setup({ el, App, props }) {
    createRoot(el).render(<App {...props} />);
  },
});
