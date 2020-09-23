# shiny-dashboard

This repository is used to learn a simple monitoring dashboard for E-commerce platform using shiny dashboard. This dashboard is made very concise and easy for educational needs. For the beauty of presenting information through visualization can use a lot of additional functions. This dashboard is not only for a data monitoring tools, but also as a data presentation tool that has been processed into various kinds of insight with interactive concepts

## Dependencies

Make sure to install the following library:

- library(shiny)
- library(shinydashboard)
- library(lubridate)
- library(dplyr)
- library(ggplot2)
- library(glue)
- library(scales)
- library(plotly)
- library(DT)

you can get the dataset at this link below:
https://drive.google.com/drive/folders/1EYiY01KU5KJzUenkSKlOgl1DkmFndvOl?usp=sharing

## Data Preparation

At this stage you have to prepare the data that used to make attractive visualizations. I recommend that you should use Rmarkdown for concepting the content.

- read dataset
- preprocessing data (feature engineering)
- visualization (ggplot and ggplotly)

## Preparing global.R

The code needed to create the visualization is placed in global.R such as required libraries and feature engineering code

## Preparing server.R

You have to prepare the visualization content that will be displayed

## Build UI.R

Build the concept of dashboard
