import { createInertiaApp } from "@inertiajs/react";
import createServer from "@inertiajs/react/server";
import ReactDOMServer from "react-dom/server";
import Layout from "@/components/Layout";
import "../styles/app.css";

import Routing from "fos-router";
import routes from "@/routes.json";
Routing.setRoutingData(routes);

const appName = "[TO_REPLACE]";

createServer((page) =>
  createInertiaApp({
    page,
    render: ReactDOMServer.renderToString,
    title: (title) => (title ? `${title} | ${appName}` : appName),
    resolve: (name) => {
      const pages = import.meta.glob("./pages/**/*.jsx", { eager: true });
      const page = pages[`./pages/${name}.jsx`];
      if (page.default.layout === undefined) {
        page.default.layout = Layout;
      }
      return page;
    },
    setup: ({ App, props }) => <App {...props} />,
  })
);
