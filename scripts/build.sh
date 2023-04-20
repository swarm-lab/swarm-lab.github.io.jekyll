#!/bin/bash
Rscript scripts/scholar.R
Rscript scripts/bib2.R
bundle exec jekyll serve
