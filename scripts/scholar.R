library(rvest)
library(knitr)

scholar_tab <- "https://scholar.google.com/citations?user=4MNHWX8AAAAJ" %>%
  read_html(.) %>%
  html_nodes(xpath='//*[@id="gsc_rsb_st"]') %>%
  html_table(fill = TRUE)
names(scholar_tab[[1]])[1] <- paste0("As of ", format(Sys.time(), "%B %d, %Y"))
scholar_tab <- strsplit(kable(scholar_tab), "\n")[[1]]

scholar_page <- readLines("publications/index.md")
start <- which(scholar_page == "#### Google Scholar Report")
end <- min(which(scholar_page == "---")[which(scholar_page == "---") > start])
scholar_page <- scholar_page[-(start + 1):-(end - 1)]

out <- c(scholar_page[1:start], "", "{:.scholar}", scholar_tab, "", scholar_page[(start + 1):length(scholar_page)])

writeLines(out, "publications/index.md")
