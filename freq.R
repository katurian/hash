library(tidyverse)
library(rtweet)
library(twitteR)
library(ggplot2)
library(tidytext)
library(dplyr)
library(stringr)
library(lubridate)

# you have to do this every time you open RStudio. 

 raw_tweets <- search_tweets(
  "incels", n = 50000, lang = "en", include_rts = FALSE
)

raw_tweets <- mutate(raw_tweets, text = gsub("#[A-Za-z0-9]+|@[A-Za-z0-9]+|\\w+(?:\\.\\w+)*/\\S+", "", raw_tweets$text))
raw_tweets <- mutate(raw_tweets, gsub("http.*","", raw_tweets$text))
raw_tweets <- mutate(raw_tweets, gsub("https.*","", raw_tweets$text))

# this narrows down the tweets contained in raw_tweets to plain text.

raw_tweets <- mutate(raw_tweets, ymd_hms(created_at))

# this lubridate function converts the date-time values of created_at into a format easier to work with.

ggplot(raw_tweets, aes(x = created_at, fill = "purple")) +
geom_histogram(position = "identity", bins = 100, show.legend = FALSE) +
  ggplot2::theme_minimal() +
  ggplot2::theme(plot.title = ggplot2::element_text(face = "bold")) +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frequency of incel Twitter statuses from past 8 days",
    subtitle = "Data collected from Twitter's REST API via rtweet")

# this plots how often people in tweet in a given hashtag. note: if you are plotting active hashtags like #trump, you will need to increase the number of tweets you collect on line 11. 

ts_plot(raw_tweets, "3 hours") +
  ggplot2::theme_minimal() +
  ggplot2::theme(plot.title = ggplot2::element_text(face = "bold")) +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frequency of incel Twitter statuses from past 8 days",
    subtitle = "Twitter status (tweet) counts aggregated using three-hour intervals")

# this does the same thing as the histogram except in a line plot. Change ``3 hours`` to ``by = "days"`` or ``by = "mins"`` to adjust the interval of your plot.
# source: https://rtweet.info/reference/ts_plot.html
