# Website

This website is a demo of [Docusaurus](https://docusaurus.io/), using the classic template. The purpose of this is to provide a template of a docusaurus source site with the option to run directly or via docker. The site also comes pre-configured with some key plugins such as mermaid for diagramming, so that it is ready for use.

This is meant to be operated in Visual Studio Code; the source code explicitly checks in `.vscode/extensions.json` to specifically recommend extensions that make operating and editing this user friendly - the `commandbar` extension in particular is leveraged extensively in this project to provide pre-configured comamnds in the VS Code command bar for initialising and starting the site in dev mode.

## Installation


when running directly using node, use the `Init` command on the status bar of vscode which should run

```bash
npm install
```

When using docker,use the `Build` command this will generate a non-root container using your local user and group.

```bash
PUID="$(id -u)" PGID="$(id -g)" USER="$(whoami)" docker-compose build
```


## Local Development

Run a local dev server (this will run on port 3000)

directly using node `scripts/start.sh` is provided and triggered by `Start` command on the status bar.

```bash
npm run start -- --host 0.0.0.0 --poll 1000
```

if using docker, `Start` command with the package icon on the status bar can be used.

```bash
PUID="$(id -u)" PGID="$(id -g)" USER="$(whoami)" docker-compose up
```

This command starts a local development server and opens up a browser window. Most changes are reflected live without having to restart the server.

## Build & serve

Create and serve a production ready build in port 3001

if using node directly then use `scripts/serve.sh` (or via the `Serve` icon on the statusbar) which contains the below.

```bash
npm ci
npm run build
npm run serve -- --host 0.0.0.0 --port 3001 --no-open
```

With docker, ensure that the container is up using the `docker-compose up` command above annd then the `Serve` command with the package icon on the status bar can be used which will trigger

```bash
docker exec -u $(whoami) docusaurus /bin/bash -c 'scripts/serve.sh 2>&1'
```

This command generates static content into the `build` directory and can be served using any static contents hosting service.

## Export to PDF

PDF export uses the `docs-to-pdf` plugin.`scripts/pdf.sh` is provided with some pre-configured values that you can edit - contents are as below and are triggered using the `PDF` commands in the status bar

```bash
npx docs-to-pdf docusaurus \
     --initialDocURLs="http://localhost:3001/docs/intro" \
     --contentSelector="main" \
     --paginationSelector="a.pagination-nav__link.pagination-nav__link--next" \
     --excludeSelectors=".margin-vert--xl a,[class^='tocCollapsible'],.breadcrumbs,.theme-edit-this-page" \
     --coverImage="http://localhost:3001/img/docusaurus.png" \
     --coverTitle="My Website" \
     --outputPDFFilename="pdf/my-website.pdf" \
     --version=3
```

Using docker , the same `scripts/pdf.sh` is executed from within the container when using `PDF` with the package icon on the status bar, hence the same file can is reused.

```bash
docker run --network="host" \
  --rm \
  -v $(pwd)/pdf:/docs-to-pdf/output \
  ghcr.io/jean-humann/docs-to-pdf:latest-node24-alpine \
  docs-to-pdf \
  --puppeteerArgs="--no-sandbox, --disable-setuid-sandbox" \ 
  bash -c scripts/pdf.sh
```

## Deployment

If you are using GitHub pages for hosting, this command is a convenient way to build the website and push to the `gh-pages` branch.Keep in mind that deployment will only work if you have a `gh-pages` branch. If github actions is setup (which this repo has) then this command will fail.

Using SSH:

```bash
USE_SSH=true npm deploy
```

Not using SSH:

```bash
GIT_USER=<Your GitHub username> npm deploy
```


