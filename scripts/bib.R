### ENVIRONMENT
if (!require(rorcid)) {
  install.packages("rorcid", repos = "http://cran.us.r-project.org")
  require(rorcid)
}

if (!require(RefManageR)) {
  install.packages("RefManageR", repos = "http://cran.us.r-project.org")
  require(RefManageR)
}

if (!require(rbibutils)) {
  install.packages("rbibutils", repos = "http://cran.us.r-project.org")
  require(rbibutils)
}

if (!require(DescTools)) {
  install.packages("DescTools", repos = "http://cran.us.r-project.org")
  require(DescTools)
}

if (!require(stringr)) {
  install.packages("stringr", repos = "http://cran.us.r-project.org")
  require(stringr)
}

if (!require(lubridate)) {
  install.packages("lubridate", repos = "http://cran.us.r-project.org")
  require(lubridate)
}


### DATA
simon <- works(orcid_id("0000-0002-3886-3974"))

orcid_bib <- sapply(simon$`put-code`, function(pc) {
  w <- orcid_works("0000-0002-3886-3974", pc,
                   format = "application/orcid+json; qs=2")
  w$`0000-0002-3886-3974`$works$citation$`citation-value`
})

bib_file <- charToBib(orcid_bib, informat = "bibtex", "scripts/simon.bib")
journal_articles <- grepl("@article", orcid_bib)
conference_articles <- grepl("@inproceedings", orcid_bib)
book_chapters <- grepl("@incollection", orcid_bib)
books <- grepl("@book", orcid_bib)
preprints <- grepl("@misc", orcid_bib)
phd_thesis <- grepl("@phdthesis", orcid_bib)

BibOptions(sorting = "ydnt",
           style = "markdown",
           bib.style = "numeric",
           no.print.fields = c("month", "url", "file", "keywords",
                               "issn", "abstract", "language", "pmid",
                               "copyright", "pmc"))
unlockBinding(".cites", getNamespace("RefManageR"))


### PREPRINTS REFERENCES
assign(".cites", new.env(), getNamespace("RefManageR"))
preprints_bib <- ReadBib(bib_file$outfile)
void <- lapply(which(preprints), function(i) NoCite(preprints_bib[i]))
preprints_refs <- capture.output(PrintBibliography(preprints_bib))
preprints_refs <- c("", preprints_refs)
preprints_refs <- SplitAt(preprints_refs,
                          which(nchar(preprints_refs) == 0))
preprints_refs <- sapply(
  preprints_refs[2:length(preprints_refs)],
  function(ref) {
    ref <- paste0(ref, collapse = " ")
    ref <- str_remove(ref, " <a(.*)a>")
    ref <- str_remove(ref, "(?<=]])(.*?)\\)")
    ref <- str_replace(ref, "\\\\textquotesingle", "'")
    ref <- str_replace(ref, "\\\\textendash", "-")
    ref <- str_replace(ref, "\\[\\[", "")
    ref <- str_replace(ref, "\\]\\]", ".")
    ref <- str_replace(ref, "\\\\\\\"\\\\i", "ï")
    ref
  })

scholar_page <- readLines("publications/index.md")
start <- grep("#### Preprints under Review", scholar_page) - 1
end <- min(which(scholar_page == "---")[which(scholar_page == "---") > start])
scholar_page <- scholar_page[-(start + 1):-(end - 1)]
section <- paste0("#### Preprints under Review (Last updated ",
                  format(today(), "%b %d, %Y"), ")")
out <- c(scholar_page[1:start], "", section, "", preprints_refs, "",
         scholar_page[(start + 1):length(scholar_page)])
writeLines(out, "publications/index.md")


### JOURNAL ARTICLE REFERENCES
assign(".cites", new.env(), getNamespace("RefManageR"))
journal_articles_bib <- ReadBib(bib_file$outfile)
void <- lapply(which(journal_articles), function(i) NoCite(journal_articles_bib[i]))
journal_articles_refs <- capture.output(PrintBibliography(journal_articles_bib))
journal_articles_refs <- c("", journal_articles_refs)
journal_articles_refs <- SplitAt(journal_articles_refs,
                                 which(nchar(journal_articles_refs) == 0))
journal_articles_refs <- sapply(
  journal_articles_refs[2:length(journal_articles_refs)],
  function(ref) {
    ref <- paste0(ref, collapse = " ")
    ref <- str_remove(ref, " <a(.*)a>")
    ref <- str_remove(ref, "(?<=]])(.*?)\\)")
    ref <- str_replace(ref, "\\\\textquotesingle", "'")
    ref <- str_replace(ref, "\\\\textendash", "-")
    ref <- str_replace(ref, "\\[\\[", "")
    ref <- str_replace(ref, "\\]\\]", ".")
    ref <- str_replace(ref, "\\\\\\\"\\\\i", "ï")
    ref
  })

scholar_page <- readLines("publications/index.md")
start <- grep("#### Refereed Journal Articles", scholar_page) - 1
end <- min(which(scholar_page == "---")[which(scholar_page == "---") > start])
scholar_page <- scholar_page[-(start + 1):-(end - 1)]
section <- paste0("#### Refereed Journal Articles (Last updated ",
                  format(today(), "%b %d, %Y"), ")")
out <- c(scholar_page[1:start], "", section, "", journal_articles_refs, "",
         scholar_page[(start + 1):length(scholar_page)])
writeLines(out, "publications/index.md")


### CONFERENCE ARTICLE REFERENCES
assign(".cites", new.env(), getNamespace("RefManageR"))
conference_articles_bib <- ReadBib(bib_file$outfile)
void <- lapply(which(conference_articles), function(i) NoCite(conference_articles_bib[i]))
conference_articles_refs <- capture.output(PrintBibliography(conference_articles_bib))
conference_articles_refs <- c("", conference_articles_refs)
conference_articles_refs <- SplitAt(conference_articles_refs,
                                    which(nchar(conference_articles_refs) == 0))
conference_articles_refs <- sapply(
  conference_articles_refs[2:length(conference_articles_refs)],
  function(ref) {
    ref <- paste0(ref, collapse = " ")
    ref <- str_remove(ref, " <a(.*)a>")
    ref <- str_remove(ref, "(?<=]])(.*?)\\)")
    ref <- str_replace(ref, "\\\\textquotesingle", "'")
    ref <- str_replace(ref, "\\\\textendash", "-")
    ref <- str_replace(ref, "\\[\\[", "")
    ref <- str_replace(ref, "\\]\\]", ".")
    ref <- str_replace(ref, "\\\\\\\"\\\\i", "ï")
    ref
  })

scholar_page <- readLines("publications/index.md")
start <- grep("#### Refereed Conference Articles", scholar_page) - 1
end <- min(which(scholar_page == "---")[which(scholar_page == "---") > start])
scholar_page <- scholar_page[-(start + 1):-(end - 1)]
section <- paste0("#### Refereed Conference Articles (Last updated ",
                  format(today(), "%b %d, %Y"), ")")
out <- c(scholar_page[1:start], "", section, "", conference_articles_refs, "",
         scholar_page[(start + 1):length(scholar_page)])
writeLines(out, "publications/index.md")


### BOOK CHAPTERS
assign(".cites", new.env(), getNamespace("RefManageR"))
book_chapters_bib <- ReadBib(bib_file$outfile)
void <- lapply(which(book_chapters), function(i) NoCite(book_chapters_bib[i]))
book_chapters_refs <- capture.output(PrintBibliography(book_chapters_bib))
book_chapters_refs <- c("", book_chapters_refs)
book_chapters_refs <- SplitAt(book_chapters_refs,
                              which(nchar(book_chapters_refs) == 0))
book_chapters_refs <- sapply(
  book_chapters_refs[2:length(book_chapters_refs)],
  function(ref) {
    ref <- paste0(ref, collapse = " ")
    ref <- str_remove(ref, " <a(.*)a>")
    ref <- str_remove(ref, "(?<=]])(.*?)\\)")
    ref <- str_replace(ref, "\\\\textquotesingle", "'")
    ref <- str_replace(ref, "\\\\textendash", "-")
    ref <- str_replace(ref, "\\[\\[", "")
    ref <- str_replace(ref, "\\]\\]", ".")
    ref <- str_replace(ref, "\\\\\\\"\\\\i", "ï")
    ref
  })

scholar_page <- readLines("publications/index.md")
start <- grep("#### Refereed Book Chapters", scholar_page) - 1
end <- min(which(scholar_page == "---")[which(scholar_page == "---") > start])
scholar_page <- scholar_page[-(start + 1):-(end - 1)]
section <- paste0("#### Refereed Book Chapters (Last updated ",
                  format(today(), "%b %d, %Y"), ")")
out <- c(scholar_page[1:start], "", section, "", book_chapters_refs, "",
         scholar_page[(start + 1):length(scholar_page)])
writeLines(out, "publications/index.md")


### BOOKS
assign(".cites", new.env(), getNamespace("RefManageR"))
books_bib <- ReadBib(bib_file$outfile)
void <- lapply(which(books), function(i) NoCite(books_bib[i]))
books_refs <- capture.output(PrintBibliography(books_bib))
books_refs <- c("", books_refs)
books_refs <- SplitAt(books_refs,
                      which(nchar(books_refs) == 0))
books_refs <- sapply(
  books_refs[2:length(books_refs)],
  function(ref) {
    ref <- paste0(ref, collapse = " ")
    ref <- str_remove(ref, " <a(.*)a>")
    ref <- str_remove(ref, "(?<=]])(.*?)\\)")
    ref <- str_replace(ref, "\\\\textquotesingle", "'")
    ref <- str_replace(ref, "\\\\textendash", "-")
    ref <- str_replace(ref, "\\[\\[", "")
    ref <- str_replace(ref, "\\]\\]", ".")
    ref <- str_replace(ref, "\\\\\\\"\\\\i", "ï")
    ref
  })

scholar_page <- readLines("publications/index.md")
start <- grep("#### Books as Editor", scholar_page) - 1
end <- min(which(scholar_page == "---")[which(scholar_page == "---") > start])
scholar_page <- scholar_page[-(start + 1):-(end - 1)]
section <- paste0("#### Books as Editor (Last updated ",
                  format(today(), "%b %d, %Y"), ")")
out <- c(scholar_page[1:start], "", section, "", books_refs, "",
         scholar_page[(start + 1):length(scholar_page)])
writeLines(out, "publications/index.md")









