library(tidyverse)
library(rtweet)
library(twitteR)
library(ggplot2)
library(tidytext)
library(dplyr)
library(stringr)

create_token(
  app = "my_twitter_research_app",
  consumer_key = "XYzXXXXXXXXXXXXXXXXXXX",
  consumer_secret = "CtkGEXXXXXXXXXXXXXXXXXXXXXXX",
  access_token = "9551451262XXXXXXXXXXXXXXXXXXXXX",
  access_secret = "9vpiSGKgXXXXXXXXXXXXXXXXXXXXX")

# you can find these strings within the "Keys and Tokens" tab of the app you made with your Twitter developer account

 raw_tweets <- search_tweets(
  "trump", n = 1800, lang = "en", include_rts = TRUE
)

# the hashtags, number of tweets, or language can be changed to find specific data.

tweets_text <- gsub("#[A-Za-z0-9]+|@[A-Za-z0-9]+|\\w+(?:\\.\\w+)*/\\S+", "", raw_tweets$text)

tweets_text <- gsub("http.*","",tweets_text)

tweets_text <- gsub("https.*","",tweets_text)

# this narrows the data frame down to just the text, and cleans the data

tweets_tokened <- tweets_text %>%
     as_tibble %>% 
     unnest_tokens(word, value) %>%
     anti_join(stop_words)

# this "tokenizes" the tweets into individual words and removes the most common/uninteresting words

mystopwords <- tibble(word = c("rt", "succ", "he's", "it's", "op", "ed"))
tweets_tokened <- anti_join(tweets_tokened, mystopwords, by = "word")

# remember you can make your own list of words to be removed from your corpus

tweets_tokened %>%
  count(word, sort = TRUE) %>%
  filter(n > 1700, n < 5000) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  xlab(NULL) +
  ylab(NULL) +
  ggtitle("Common Words In #Trump", subtitle = "Data collected from Twitter's REST API via rtweet") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(plot.subtitle = element_text(hjust = 0.5)) +
  coord_flip()

# this visualizes the most common words
