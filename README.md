# Swarm Lab

Source for the Swarm Lab website. Jekyll renders the static site.

## Local preview

```sh
bundle exec jekyll serve
```

Jekyll writes generated output to `_site/`, the versioned deployment backup. Edit source files rather than generated output.

## Repository map

- `_posts/` and top-level content directories contain pages and posts.
- `_layouts/` and `_includes/` compose the site.
- `img/` contains site images and retained design sources.
- `scripts/scholar.R` and `scripts/bib.R` refresh publication content before a build.
