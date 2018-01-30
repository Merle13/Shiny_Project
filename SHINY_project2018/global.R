library(dplyr)
library(leaflet)
library(shiny)
library(ggthemes)
library(ggplot2)
library(RColorBrewer)
library(plotly)
library(rsconnect)
library(shinydashboard)




Citi_Bike_717 = readRDS('citibike717.RDS')
OOO = readRDS("StartStation.RDS")
CCC = readRDS("EndStation.RDS")
routes = readRDS("routes.RDS")
routes_map = readRDS("routes_map.RDS")


# MAPBOX_TOKEN = "pk.eyJ1IjoibWFuZ29saW5hIiwiYSI6ImNqY3o1dDhiczBvdXYyd24yaXBuMm0wcTQifQ.CuPZPh3sZfw3_Y6gV6ekPg"
# Sys.setenv('MAPBOX_TOKEN' = 'pk.eyJ1IjoibWFuZ29saW5hIiwiYSI6ImNqY3o1dDhiczBvdXYyd24yaXBuMm0wcTQifQ.CuPZPh3sZfw3_Y6gV6ekPg')


# convert matrix to dataframe
#state_stat <- data.frame(state.name = rownames(state.x77), state.x77)
# remove row names
#rownames(state_stat) <- NULL
# create variable with colnames as choice
#choice <- colnames(state_stat)[-1]