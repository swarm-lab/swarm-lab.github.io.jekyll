### ENVIRONMENT
if (!require(rvest)) {
  install.packages("rvest", repos = "http://cran.us.r-project.org")
  require(rvest)
}

if (!require(dplyr)) {
  install.packages("dplyr", repos = "http://cran.us.r-project.org")
  require(dplyr)
}

if (!require(knitr)) {
  install.packages("knitr", repos = "http://cran.us.r-project.org")
  require(knitr)
}

if (!require(stringr)) {
  install.packages("stringr", repos = "http://cran.us.r-project.org")
  require(stringr)
}

if (!require(ggplot2)) {
  install.packages("ggplot2", repos = "http://cran.us.r-project.org")
  require(ggplot2)
}

if (!require(svglite)) {
  install.packages("svglite", repos = "http://cran.us.r-project.org")
  require(svglite)
}

###

scholar_html <- read_html("https://scholar.google.com/citations?user=4MNHWX8AAAAJ&hl=en")

scholar_tab <- scholar_html %>%
  html_nodes(xpath = '//*[@id="gsc_rsb_st"]') %>%
  html_table(fill = TRUE)
names(scholar_tab[[1]])[1] <- paste0("As of ", format(Sys.time(), "%B %d, %Y"))
scholar_tab <- strsplit(kable(scholar_tab), "\n")[[1]]

scholar_page <- readLines("publications/index.md")
start <- grep("scholar.svg", scholar_page)
end <- min(which(scholar_page == "---")[which(scholar_page == "---") > start])
scholar_page <- scholar_page[-(start + 1):-(end - 1)]

out <- c(scholar_page[1:start], "", "{:.scholar}", scholar_tab, "", scholar_page[(start + 1):length(scholar_page)])

writeLines(out, "publications/index.md")

###

scholar_df <- data.frame(years = scholar_html %>%
                           html_nodes(xpath = '//*[@class="gsc_g_t"]') %>%
                           html_text() %>%
                           as.numeric,
                         citations = scholar_html %>%
                           html_nodes(xpath = '//*[@class="gsc_g_al"]') %>%
                           html_text() %>%
                           as.numeric()) %>%
  mutate(., cum_citations = cumsum(citations))

svglite("img/posts/publications/scholar.svg", width = 9, height = 3)
ggplot(scholar_df, aes(years)) +
  geom_col(aes(y = cum_citations), fill = "#b4133b") +
  geom_col(aes(y = cum_citations - citations), fill = "#008ea5") +
  geom_text(aes(y = cum_citations, label = paste0("+", citations)),
            position = position_dodge(width = 0.9), vjust = -0.75,
            fontface = "bold", size = 5) +
  xlab(NULL)+ ylab(NULL) +
  scale_y_continuous(limits = c(0, 1.1 * max(scholar_df$cum_citations)),
                     sec.axis = sec_axis(~.)) +
  theme_minimal(base_size = 18) +
  theme(text = element_text(face = "bold"),
        plot.background = element_rect(fill = "#ececec", color = "#cccccc"),
        panel.grid.major = element_line(color = "#fafafa"),
        panel.grid.minor = element_line(color = "#fafafa"))
dev.off()
