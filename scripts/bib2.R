### ENVIRONMENT
if (!require(RefManageR)) {
  install.packages("RefManageR", repos = "http://cran.us.r-project.org")
  require(RefManageR)
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

BibOptions(check.entries = "warn",
           sorting = "ydnt",
           match.date = "exact",
           style = "markdown",
           bib.style = "numeric",
           max.names = Inf,
           max.names = Inf,
           no.print.fields = c("url", "file", "keywords",
                               "issn", "abstract", "language", "pmid",
                               "copyright", "pmc"))

prepare_refs <- function(bib) {
  void <- lapply(bib, function(ref) NoCite(ref))
  refs <- capture.output(PrintBibliography(bib))
  refs <- c("", refs)
  refs <- SplitAt(refs,
                  which(nchar(refs) == 0))
  sapply(
    refs[2:length(refs)],
    function(ref) {
      ref <- paste0(ref, collapse = " ")
      ref <- str_remove(ref, " <a(.*)a>")
      ref <- str_remove(ref, "(?<=]])(.*?)\\)")
      ref <- str_replace(ref, "\\\\textquotesingle", "'")
      ref <- str_replace(ref, "\\\\textendash", "-")
      ref <- str_replace(ref, "\\[\\[", "")
      ref <- str_replace(ref, "\\]\\]", ".")
      ref <- str_replace(ref, "\\\\\\\"\\\\i", "ï")
      ref <- str_replace(ref, "S. Garnier", "**S. Garnier**")
      ref
    })
}


### DATA
preprints <- ReadBib("/Users/simon/Library/CloudStorage/GoogleDrive-garnier@njit.edu/My Drive/Preprints.bib")
journal_papers <- ReadBib("/Users/simon/Library/CloudStorage/GoogleDrive-garnier@njit.edu/My Drive/Journal-Papers.bib")
conference_papers <- ReadBib("/Users/simon/Library/CloudStorage/GoogleDrive-garnier@njit.edu/My Drive/Conference-Papers.bib")
book_chapters <- ReadBib("/Users/simon/Library/CloudStorage/GoogleDrive-garnier@njit.edu/My Drive/Book-Chapters.bib")
books <- ReadBib("/Users/simon/Library/CloudStorage/GoogleDrive-garnier@njit.edu/My Drive/Books.bib")
invited_talks <- ReadBib("/Users/simon/Library/CloudStorage/GoogleDrive-garnier@njit.edu/My Drive/Invited-talks.bib")
conference_abstracts <- ReadBib("/Users/simon/Library/CloudStorage/GoogleDrive-garnier@njit.edu/My Drive/Conference-Abstracts.bib")


### PREPRINTS REFERENCES
preprints_refs <- prepare_refs(preprints)

scholar_page <- readLines("publications/index.md")
start <- grep("#### Preprints under Review", scholar_page) - 1
end <- min(which(scholar_page == "---")[which(scholar_page == "---") > start])
scholar_page <- scholar_page[-(start + 1):-(end - 1)]
section <- paste0("#### Preprints under Review (Last updated ",
                  format(today(), "%b %d, %Y"), ")")
out <- c(scholar_page[1:start], section, "", preprints_refs, "",
         scholar_page[(start + 1):length(scholar_page)])
writeLines(out, "publications/index.md")


### JOURNAL ARTICLE REFERENCES
journal_papers_refs <- prepare_refs(journal_papers)

scholar_page <- readLines("publications/index.md")
start <- grep("#### Refereed Journal Articles", scholar_page) - 1
end <- min(which(scholar_page == "---")[which(scholar_page == "---") > start])
scholar_page <- scholar_page[-(start + 1):-(end - 1)]
section <- paste0("#### Refereed Journal Articles (Last updated ",
                  format(today(), "%b %d, %Y"), ")")
out <- c(scholar_page[1:start], section, "", journal_papers_refs, "",
         scholar_page[(start + 1):length(scholar_page)])
writeLines(out, "publications/index.md")


### CONFERENCE ARTICLE REFERENCES
conference_papers_refs <- prepare_refs(conference_papers)

scholar_page <- readLines("publications/index.md")
start <- grep("#### Refereed Conference Articles", scholar_page) - 1
end <- min(which(scholar_page == "---")[which(scholar_page == "---") > start])
scholar_page <- scholar_page[-(start + 1):-(end - 1)]
section <- paste0("#### Refereed Conference Articles (Last updated ",
                  format(today(), "%b %d, %Y"), ")")
out <- c(scholar_page[1:start], section, "", conference_papers_refs, "",
         scholar_page[(start + 1):length(scholar_page)])
writeLines(out, "publications/index.md")


### BOOK CHAPTER REFERENCES
book_chapters_refs <- prepare_refs(book_chapters)

scholar_page <- readLines("publications/index.md")
start <- grep("#### Refereed Book Chapters", scholar_page) - 1
end <- min(which(scholar_page == "---")[which(scholar_page == "---") > start])
scholar_page <- scholar_page[-(start + 1):-(end - 1)]
section <- paste0("#### Refereed Book Chapters (Last updated ",
                  format(today(), "%b %d, %Y"), ")")
out <- c(scholar_page[1:start], section, "", book_chapters_refs, "",
         scholar_page[(start + 1):length(scholar_page)])
writeLines(out, "publications/index.md")


### BOOKS REFERENCES
books_refs <- prepare_refs(books)

scholar_page <- readLines("publications/index.md")
start <- grep("#### Books as Editor", scholar_page) - 1
end <- min(which(scholar_page == "---")[which(scholar_page == "---") > start])
scholar_page <- scholar_page[-(start + 1):-(end - 1)]
section <- paste0("#### Books as Editor (Last updated ",
                  format(today(), "%b %d, %Y"), ")")
out <- c(scholar_page[1:start], section, "", books_refs, "",
         scholar_page[(start + 1):length(scholar_page)])
writeLines(out, "publications/index.md")


### INVITED TALKS REFERENCES
invited_talks_refs <- prepare_refs(invited_talks)
sorted_invited_talks <- sort(invited_talks)
keynotes <- SearchBib(sorted_invited_talks, keywords = "keynote", .opts = list(return.ind = TRUE))
invited_talks_refs[keynotes] <- paste0(invited_talks_refs[keynotes], " **Keynote speaker**")

scholar_page <- readLines("publications/index.md")
start <- grep("#### Invited Presentations", scholar_page) - 1
end <- min(which(scholar_page == "---")[which(scholar_page == "---") > start])
scholar_page <- scholar_page[-(start + 1):-(end - 1)]
section <- paste0("#### Invited Presentations (Last updated ",
                  format(today(), "%b %d, %Y"), ")")
out <- c(scholar_page[1:start], section, "", invited_talks_refs, "",
         scholar_page[(start + 1):length(scholar_page)])
writeLines(out, "publications/index.md")


### CONFERENCE ABSTRACT REFERENCES
conference_abstracts_refs <- prepare_refs(conference_abstracts)

scholar_page <- readLines("publications/index.md")
start <- grep("#### Conference Abstracts", scholar_page) - 1
end <- min(which(scholar_page == "---")[which(scholar_page == "---") > start])
scholar_page <- scholar_page[-(start + 1):-(end - 1)]
section <- paste0("#### Conference Abstracts (Last updated ",
                  format(today(), "%b %d, %Y"), ")")
out <- c(scholar_page[1:start], section, "", conference_abstracts_refs, "",
         scholar_page[(start + 1):length(scholar_page)])
writeLines(out, "publications/index.md")

warnings()
