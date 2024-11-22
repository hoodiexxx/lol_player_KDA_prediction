#### Preamble ####
# Purpose: Downloads and saves the data from https://oracleselixir.com/tools/downloads
# Author: Colin Sihan Yang
# Date: 18 November 2024
# Contact: colinsihan.yang@mail.utoronto.ca
# License: MIT
# Pre-requisites: None


#### Workspace setup ####
library(tidyverse)

#### Download data ###
url <- "https://drive.usercontent.google.com/download?id=1IjIEhLc9n8eLKeY-yh_YigKVWbhgGBsN&export=download&authuser=0&confirm=t&uuid=8b1e7c18-e43c-4047-ae9a-4cf6acb95b69&at=AENtkXZukYEBpxyA_ZDjT-x-V4PD:1731978750526"


#### Save data ####
# change the_raw_data to whatever name you assigned when you downloaded it.
# Save the data csv
download.file(url, "data/01-raw_data/2024_lol_esport.csv")

         
