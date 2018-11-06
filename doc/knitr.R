# Load packages
require(knitr)
require(markdown)

# Create .md, .html, and .pdf files
knit("main.Rmd")
markdownToHTML('main.md', 'main.html', options=c("use_xhml"))
# system("pandoc -s My_Analysis.html -o My_Analysis.pdf")

