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
Rscript scripts/bib.R
JEKYLL_ENV=production bundle exec jekyll serve
```

The two R scripts run before the local Jekyll server starts. `scripts/scholar.R` reads a manually saved Google Scholar profile snapshot at `data/scholar-profile.html`: Enter reuses it; `y` opens the profile and waits for a replacement snapshot.

Deploy with:

```sh
DRY_RUN=1 rake deploy
rake deploy
```

Both commands mirror `_site/` with `rsync --delete --delete-excluded`; they exclude and remove remote `.git/`, `.DS_Store`, and `._*` metadata.

## Generated and deployment paths

- `_site/` is generated Jekyll output and a versioned deployment-backup repository. Commit and push `_site/` first, then commit its Gitlink in the outer repository and push the outer repository.
- `data/scholar-profile.html` and `data/scholar-profile_files/` are local-only Scholar snapshot artifacts. They are Git-ignored and excluded from generated output.
- `._*` files are macOS metadata artifacts.

## Known dependency constraint

`github-pages` 232 is the current supported GitHub Pages bundle. Its `jekyll-remote-theme` 0.4.3 dependency requires `rubyzip < 3.0`, so Dependabot alert #79 cannot be fixed by a supported bundle update. Leave the alert open until GitHub Pages changes that dependency set.
