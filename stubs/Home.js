import React from "react";
import { Link } from "@inertiajs/inertia-react";

export default function HomePage({ name }) {
  return (
    <>
      <h1>
        Hello, {name}!
      </h1>
      <Link href="/about-us">About Us</Link>
    </>
  );
}
