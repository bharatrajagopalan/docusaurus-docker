#!/bin/bash
#docker run --network="host" --rm -v \
#            $(pwd)/pdf:/docs-to-pdf/output \
#            ghcr.io/jean-humann/docs-to-pdf:latest-node24-alpine \
#            docs-to-pdf \
#            --initialDocURLs="http://localhost:3001/docs/intro" \
#            --puppeteerArgs="--no-sandbox, \
#            --disable-setuid-sandbox" --outputPDFFilename="output/my-website.pdf" --contentSelector="main" --paginationSelector="a.pagination-nav__link.pagination-nav__link--next" --excludeSelectors=".margin-vert--xl a,[class^='tocCollapsible'],.breadcrumbs,.theme-edit-this-page" --coverImage="http://localhost:3001/img/docusaurus.png" --coverTitle="My Website"

docker run --network="host" \
  --rm \
  -v $(pwd)/pdf:/docs-to-pdf/output \
  ghcr.io/jean-humann/docs-to-pdf:latest-node24-alpine \
  docs-to-pdf \
  --puppeteerArgs="--no-sandbox, --disable-setuid-sandbox" \ 
  bash -c scripts/pdf.sh
  
  
  #'npx docs-to-pdf docusaurus \
  #         --initialDocURLs="http://localhost:3001/docs/intro" \
  #         --contentSelector="main" --paginationSelector="a.pagination-nav__link.pagination-nav__link--next" \
  #         --excludeSelectors=".margin-vert--xl a,[class^='tocCollapsible'],.breadcrumbs,.theme-edit-this-page" \
  #         --coverImage="http://localhost:3001/img/docusaurus.png" \
  #         --coverTitle="My Website" \
  #         --outputPDFFilename="pdf/my-website.pdf" \
  #         --version=3'
