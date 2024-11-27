# Forecasting League of Legends Player Performance through In-Game Metrics and Key Statistics

## Overview

This paper introduces a hybrid predictive model for analyzing and forecasting player performance for the Bilibili Gaming (BLG) team in the League of Legends Pro League (LPL). Using advanced statistical methods, including Bayesian mixed-effects modeling, the study evaluates key in-game metrics to provide actionable insights for player evaluation and team strategy optimization.


## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from X.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `other/datasheet` contains the datasheet
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.


## Statement on LLM usage

The drafted outline, some of the visualization plot and the figure captions were written with the help of ChatGPT 4. The entire chat history is available in other/llm_usage/usage.txt.

## Note

This R project is setup with [Positron](https://positron.posit.co/), the new IDE by Posit PBC. The properties of this project is stored in `/renv/settings.json`. We use renv for reproducibility and portability. With the metadata from the lockfile, other researchers can install exactly the same version of every package.
You can run 
```sh
renv::restore()
```
to restore the R project emvironment. We also included a .Rproj file for RStudio users. For more information, see [this Github Issue](https://github.com/posit-dev/positron/discussions/3967) and [renv](https://rstudio.github.io/renv/articles/renv.html).