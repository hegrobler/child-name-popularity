# child-name-popularity
This repository contains a basic sample R Shiny application that I completed for a Coursera course. It provides the user with the ability to see how many times a child was named a particular name in a specific year in the USA.

## Instructions for use (From RStudio):
### Run the Shiny app
1. Clone the repository a local folder
2. Change the working directory in global.R
3. Open server.R and click on Run App

### Run the RPres presentation
1. Clone the repository a local folder
2. Change the working directory in global.R
3. Run the preparePresentationData.R script. This will create all the neccesary input files needed for the presentation. Doing some of the prep separatedly makes sure that the presentation loads faster
4. Switch to pitch.Rpres and click on Run
5. The presentation should open in your default browser window

## Data:
More information on the dataset can be found on the [US Social Security website](https://www.ssa.gov/oact/babynames/limits.html). The dataset used during this analysis was downloaded from this page by clicking on the **State-Specific data** link on the page.

## Files:
- server.R, ui.R: R Code for the shiny application 
- global.R: Some global functions that is used accross different script files
- all_states.zip: Data for all US states combined into a single csv. The data downloaded from the [US Social Security website](https://www.ssa.gov/oact/babynames/limits.html) has a separate file containing data for each state which makes it somewhat difficult to work with so I combined them all into one file.
- preparePresentationData.R: 

