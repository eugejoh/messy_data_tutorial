# Explore Messy Data ------------------------------------------------------
# Eugene Joh
# 2019-05-21

# load libraries
library(here) #0.1
library(readr) #1.3.1
library(dplyr) #0.7.8
library(tidyr) #0.8.1
# library(visdat) #0.5.3

# explore '/data' directory
list.files(here::here("data"))
list.files(file.path(getwd(),"data"))

# import
data1 <- readr::read_csv(file = here::here("data", "messy_data_01.csv"))
data2 <- readr::read_csv(file = here::here("data", "messy_data_02.csv"))
data3 <- readr::read_csv(file = here::here("data", "messy_data_03.csv"))

# quick preview of tables
head(data1)
tail(data1)

head(data2)
tail(data3)

head(data3)
tail(data3)

# quick summary of tables
dplyr::glimpse(data1)
dplyr::glimpse(data2)
dplyr::glimpse(data3)

# # quick visual of content
# # quick visual of table content
# visdat::vis_dat(data1, sort_type = FALSE, palette = "cb_safe")
# # quick visual of missing data
# visdat::vis_miss(data1, sort_miss = FALSE)
# 
