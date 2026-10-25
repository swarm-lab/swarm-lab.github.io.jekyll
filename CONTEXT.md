# Project context

## Purpose and stack

This repository is the source for the Swarm Lab website. It is a Jekyll static site based on the Agency Bootstrap theme.

- Ruby/Jekyll renders the site.
- `github-pages` provides the Jekyll plugin set; direct dependencies are declared in `Gemfile`.
- Markdown is rendered with Kramdown and Rouge syntax highlighting.
- The configured production URL is `http://www.theswarmlab.com`.

## Rendering flow

`_layouts/default.html` constructs the main single-page homepage by including these shared components in order:

1. `nav_front.html`
2. `header_front.html`
3. `aboutus.html`
4. `research.html`
5. `teaching.html`
6. `dev.html`
7. `team.html`
8. `contact.html`
9. `footer.html`, `modals.html`, and `js.html`

Shared HTML lives in `_includes/`; layouts live in `_layouts/`. Static images, JavaScript, and other browser assets are in `img/`, `js/`, and `assets/`.

## Content sources

| Content | Source of truth |
| --- | --- |
| Site title, email, description, colors, social links, address | `_config.yml` |
| Current and former lab members | `people` and `people_old` in `_config.yml` |
| Homepage research, teaching, and software cards | `_posts/*.md`, selected by category |
| Lab news | `_posts/*.md` with `category: blog` |
| Publications, funding, media, contact, joining, and course pages | Their corresponding top-level directories |
| Shiny and R portfolios | `shiny/` and `R/` |

## Portfolio posts

Homepage portfolio sections select posts by category:

- `research-portfolio` → Current research
- `teaching-portfolio` → Teaching
- `dev-portfolio` → Open source software

Portfolio posts in `_posts/` use YAML front matter. Existing posts use `title`, `subtitle`, `layout`, `modal-id`, `date`, `img`, `thumbnail`, `alt`, `category`, and `description`. Images referenced by portfolio posts are stored under `img/portfolio/`.

## Build and deployment

`scripts/build.sh` runs:

```sh
Rscript scripts/scholar.R
Rscript scripts/bib2.R
bundle exec jekyll serve
```

The two R scripts run before the local Jekyll server starts.

`rake deploy` deploys `_site/` to the configured remote host with `rsync -rtzh --delete`. It deletes remote files absent from the local generated site.

## Generated and local-only paths

- `_site/` is generated Jekyll output; edit its source files instead.
- `._*` files are macOS metadata artifacts.
- `.idea/` contains local IDE configuration.
