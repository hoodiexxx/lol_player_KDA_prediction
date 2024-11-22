#### Preamble ####
# Purpose: Simulates a dataset of Australian electoral divisions, including the 
  # state and party that won each division.
# Author: Rohan Alexander
# Date: 26 September 2024
# Contact: rohan.alexander@utoronto.ca
# License: MIT
# Pre-requisites: 
  # - `polars` must be installed (pip install polars)
  # - `numpy` must be installed (pip install numpy)


#### Workspace setup ####
import numpy as np
import pandas as pd
np.random.seed(853)

#### Simulate data ####
# State names
simulated_league = "LPL"
simulated_teamname = "Bilibili Gaming"
simulated_playername_list = ["Xun", "ON", "Bin", "Knight", "ELK"]
# Positions and champions
simulated_positions = ["jng", "sup", "top", "mid", "bot"]
simulated_champions = ["Lee Sin", "Thresh", "Renekton", "Ahri", "Aphelios"]

# Generate simulated data
simulated_data = {
    "gameid": [f"game_{i}" for i in range(1, 6)],
    "league": [simulated_league] * 5,
    "year": [2024] * 5,
    "split": ["Spring"] * 5,
    "side": ["Blue"] * 5,
    "position": simulated_positions,
    "playername": simulated_playername_list,
    "teamname": [simulated_teamname] * 5,
    "champion": simulated_champions,
    "kills": np.random.randint(0, 10, 5),
    "deaths": np.random.randint(0, 5, 5),
    "assists": np.random.randint(0, 15, 5),
    "teamkills": [20] * 5,
    "teamdeaths": [10] * 5,
    "visionscore": np.random.randint(10, 100, 5),
    "totalgold": np.random.randint(8000, 15000, 5),
    "total.cs": np.random.randint(50, 300, 5),
    "damagetochampions": np.random.randint(5000, 25000, 5),
    "result": [1] * 5,
    "KDA": np.round((np.random.randint(0, 10, 5) + np.random.randint(0, 15, 5)) /
                    np.maximum(np.random.randint(1, 5, 5), 1), 2)
}

# Create a Polars DataFrame
simulated_lol_data = pd.DataFrame(simulated_data)

# Display the simulated data
print(simulated_lol_data)


#### Save data ####
simulated_lol_data.to_parquet("data/00-simulated_data/simulated_data.parquet")
