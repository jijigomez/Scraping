install.packages('rvest')

library(rvest)
library(rvest)
url <- "https://en.wikipedia.org/wiki/World_population"

(paragraphs <- read_html(url) %>% html_nodes("p"))

#Then we might want to actually parse out those paragraphs into text:
url <- "https://en.wikipedia.org/wiki/World_population"
paragraphs <- read_html(url) %>% html_nodes("p") %>% html_text()
paragraphs[1:10]


#Get some other types of HTML obejects. Let’s get all the hyperlinks to other pages

read_html(url) %>% html_nodes("a") 

#What about tables ?
url <- "https://en.wikipedia.org/wiki/World_population"
tables <- read_html(url) %>% html_nodes("table") 
tables


install.packages('tidyr')

library(rvest)
library(tidyr)
library(dplyr)
library(ggplot2)

# Use read_html to fetch the webpage
url <- "https://en.wikipedia.org/wiki/World_population"
ten_most_df <- read_html(url) 

ten_most_populous <- ten_most_df %>% 
  html_nodes("table") %>% `[[`(5) %>% html_table()

# Let's get just the first three columns
ten_most_populous <- ten_most_populous[,2:4]

# Get some content - Change the column names
names(ten_most_populous) <- c("Country_Territory","Population","Date")

# Do reformatting on the columns to be actual numerics where appropriate
ten_most_populous %>% 
  mutate(Population=gsub(",","",Population)) %>% 
  mutate(Population=round(as.numeric(Population)/1e+06))  %>%
  ggplot(aes(x=Country_Territory,y=Population)) + geom_point() + 
  labs(y = "Population / 1,000,000") + coord_flip() +
  ggtitle("Top 10 Most Populous Countries")

