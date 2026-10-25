#!/bin/bash
Rscript scripts/scholar.R
Rscript scripts/bib.R
bundle exec jekyll serve
