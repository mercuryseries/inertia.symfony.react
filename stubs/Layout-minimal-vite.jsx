const Layout = ({ children }) => {
  return (
    <>
      <main role="main">{children}</main>
    </>
  );
};

export default (page) => <Layout>{page}</Layout>;
