url <- "https://millercenter.org/the-presidency/presidential-speeches/march-4-1865-second-inaugural-address"
library(rvest)
lincoln_doc <- read_html(url) %>%
  html_nodes(".view-transcript") %>%
  html_text()
lincoln_doc


word_vec <- unlist(strsplit(lincoln_doc," "))
word_vec[1:20]

sort(table(word_vec),decreasing = TRUE)[1:10]

library(tidytext)
library(tidyr)
text_df <- data_frame(line = 1:length(lincoln_doc), text = lincoln_doc)

text_df

token_text <- text_df %>%
  unnest_tokens(word, text)

# Let's now count them

token_text %>% count(word,sort=TRUE)


data(stop_words)

# Sample 40 random stop words

stop_words %>% sample_n(40)

tidy_text <- token_text %>%
  anti_join(stop_words)

tidy_text <- token_text %>%
  filter(!word %in% stop_words$word)

tidy_text %>% count(word,sort=TRUE)

tidy_text %>% count(word,sort=TRUE)

tidy_text %>%
  count(word, sort = TRUE) %>%
  filter(n > 2) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip()


#refernce:https://steviep42.github.io/webscraping/book/bagofwords.html#simple-example