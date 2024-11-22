#### Preamble ####
# Purpose: Cleans the raw plane data recorded from oracleselixir.com
# Author: Colin Sihan Yang
# Date: 18 November 2024
# Contact: colinsihan.yang@mail.utoronto.ca
# License: MIT
# Pre-requisites: None


#### Workspace setup ####
library(tidyverse)
library(arrow)
library(here)

#### Clean data ####
raw_data = read.csv(here("data/01-raw_data/2024_lol_esport.csv"))

cleaned_data = raw_data |> filter(league == "LPL",
teamname == "Bilibili Gaming") |> select(gameid, league, year, split, side, position, playername, teamname, champion, kills, deaths, assists, teamkills, teamdeaths, visionscore, totalgold, total.cs, damagetochampions, gamelength, result) |> drop_na() |> mutate(gamelength = gamelength/60, KDA = (kills + assists) / ifelse(deaths == 0, 1, deaths))

#### Save data ####
# write_csv(cleaned_data, "data/02-analysis_data/cleaned_lol_data.csv")
write_parquet(cleaned_data, "data/02-analysis_data/cleaned_lol_data.parquet")
