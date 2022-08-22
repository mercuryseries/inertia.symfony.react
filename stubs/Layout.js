import React from "react";
import { Link } from "@inertiajs/inertia-react";
import Routing from "fos-router";

const Layout = ({ children }) => {
  return (
    <>
      <header>
        <nav>
          <ul>
            <li>
              <Link href={Routing.generate("app_home")}>Home</Link>
            </li>
            <li>
              <Link href={Routing.generate("app_about")}>About Us</Link>
            </li>
          </ul>
        </nav>
      </header>

      <main role="main">{children}</main>

      <footer>
        <p>
          Built with &hearts; by the folks at{" "}
          <a href="https://parlonscode.com">Parlons Code</a>
        </p>
      </footer>
    </>
  );
};

export default (page) => <Layout>{page}</Layout>;
