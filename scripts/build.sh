#!/bin/bash
set -e
Rscript scripts/scholar.R
Rscript scripts/bib.R
JEKYLL_ENV=production bundle exec jekyll serve
