const esbuild = require('esbuild');
const ElmPlugin = require('esbuild-plugin-elm');

async function watch() {
  const ctx = await esbuild.context({
    entryPoints: ['src/index.js'],
    bundle: true,
    outdir: '../js',
    plugins: [
      ElmPlugin({
        debug: true,
        clearOnWatch: true,
      }),
    ],
  }).catch(_e => process.exit(1))
  await ctx.watch()

  const { host, port } = await ctx.serve({
    servedir: '../',
  })
  console.log(`Access http://localhost:${port} for live reloading.`)
}
watch()
