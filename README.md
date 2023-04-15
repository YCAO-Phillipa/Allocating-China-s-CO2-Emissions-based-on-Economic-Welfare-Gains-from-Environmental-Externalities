# Allocating-China-s-CO2-Emissions-based-on-Economic-Welfare-Gains-from-Environmental-Externalities
This repository provides code for responsibility allocation model in the article Allocating China’s CO2 Emissions based on Economic Welfare Gains from Environmental Externalities, as well as template data to guide users to use this model. 

## Overview of the model
This model is used to reallocate environmental responsibility to consumers and producers simultaneously based on their economic welfare gains from getting away with environmental regulations. The results of the model show the responsibility share of agents in each trade flow. Find the relevant equations used in this model in the article. 

## How to use the model
### Model components
The model consists of two files:
1. ShareEmissionBasedOnEcon: you don't need to change any parameters in this function
2. compute_tBasedOn_T: this part will output the responsibility sharing results

### Data input
You need three matrices to run the model:
1. T_MTX(>=0): (Value of externality) / (Value of Product)
2. sigmaMTX(>0): Supply elesticity
3. deltaMTX(>0): Demand elesticity

### Running in MATLAB
After inputting the necessary data, you can run the model by running the script compute_tBasedOn_T. 
