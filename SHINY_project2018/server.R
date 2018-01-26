library(DT)
library(shiny)
library(googleVis)
library(maps)



server <- function(input, output, session) {
  output$most_used_station = renderPlot({
    ggplot(data = Citi_Bike_717_most_start, aes(x = start.station.name, y = Anzahl)) + geom_bar(stat = "identity")
    
  })
}
  