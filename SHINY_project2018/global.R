
library(dplyr)
library(leaflet)
library(ggplot2)
install.packages("plotly")
#library(plotly)

Citi_Bike_717_most_start = Citi_Bike_717 %>% 
  group_by(., start.station.name) %>% 
  summarise(., Anzahl = n()) %>%
  arrange(., desc(Anzahl)) %>%
  top_n(., 10)








# convert matrix to dataframe
#state_stat <- data.frame(state.name = rownames(state.x77), state.x77)
# remove row names
#rownames(state_stat) <- NULL
# create variable with colnames as choice
#choice <- colnames(state_stat)[-1]