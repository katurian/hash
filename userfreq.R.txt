library(tidyverse)
library(rtweet)
library(twitteR)
library(ggplot2)
library(tidytext)
library(dplyr)
library(stringr)
library(lubridate)

users <- get_timeline(
  c("ContraPoints", "jordanbpeterson", "realDonaldTrump"),
  n = 3000
)

ts_plot(dplyr::group_by(users, screen_name), trim = 0L, "weeks") +
  ggplot2::theme_minimal() +
  ggplot2::theme(plot.title = ggplot2::element_text(face = "bold")) +
  ggplot2::labs(
    x = NULL, y = NULL,
    color = NULL,
    title = "Twitter activity of Donald Trump, Jordan Peterson, and Natalie Wynn",
    subtitle = "Data collected from Twitter's REST API via rtweet")


