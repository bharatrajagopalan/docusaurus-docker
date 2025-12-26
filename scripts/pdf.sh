#!/bin/bash
npx docs-to-pdf docusaurus \
     --initialDocURLs="http://localhost:3001/docs/intro" \
     --contentSelector="main" \
     --paginationSelector="a.pagination-nav__link.pagination-nav__link--next" \
     --excludeSelectors=".margin-vert--xl a,[class^='tocCollapsible'],.breadcrumbs,.theme-edit-this-page" \
     --coverImage="http://localhost:3001/img/docusaurus.png" \
     --coverTitle="My Website" \
     --outputPDFFilename="pdf/my-website.pdf" \
     --version=3
#docker run --network="host" --rm -i --init \
#  -v $(pwd)/pdf:/app/pdf \
#  openbayes/docusaurus-prince-pdf \
#  -u http://localhost:3001/docs/intro