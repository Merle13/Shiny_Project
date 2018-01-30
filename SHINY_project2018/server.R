

server <- function(input, output, session) {
  
  start_df = reactive({
    Citi_Bike_717 %>%
      filter(Weekdy==input$date) %>%
      group_by(., start.station.name) %>% 
      summarise(., count = n()) %>%
      arrange(., desc(count))
  })
  
  end_df = reactive({
    Citi_Bike_717 %>%
      filter(Weekdy==input$date) %>%
      group_by(., end.station.name) %>% 
      summarise(., count = n()) %>%
      arrange(., desc(count))
  })
  
  peak_df = reactive({
    if(input$gender == "all") {
      Citi_Bike_717 %>% 
        group_by(., daytime_char, Peak) %>% summarise(., count = n())
    } else {
    Citi_Bike_717 %>% filter(., GenderChr ==input$gender) %>% 
      group_by(., daytime_char, Peak) %>% summarise(., count = n())
    }
  })
  
  speeddist_df = reactive({
    if(input$gender == "all") {
      Citi_Bike_717 %>% filter(., end.station.latitude != 0) %>%
        group_by(usertype, age, GenderChr) %>%
        summarise(mean_speed=mean(speed),
                  mean_sum_duration=mean(sum(tripduration /360)),
                  avg_trip_distance=sum(distance)/n(), 
                  count=n())
    } else {
    Citi_Bike_717 %>% filter(., GenderChr == input$gender, end.station.latitude != 0) %>%
      group_by(usertype, age, GenderChr) %>% 
      summarise(mean_speed=mean(speed),
                mean_sum_duration=mean(sum(tripduration /360)),
                avg_trip_distance=sum(distance)/n(), 
                count=n()) 
    }
  })
  
  StationMap_df = reactive({
    Citi_Bike_717 %>% filter(., GenderChr == input$gender) %>%
      distinct(., start.station.name, start.station.latitude, start.station.longitude)
  })
  
  route_df = Citi_Bike_717 %>% 
      group_by(., start.station.name, end.station.name, start.station.latitude, 
               start.station.longitude, end.station.latitude, end.station.longitude) %>%
      summarise(., counts = n()) %>% 
      arrange(., desc(counts))
  
  stationName_df = routes %>%
      select(., StationName = start.station.name, Lat = start.station.latitude, 
             Long = start.station.longitude, Num = counts)

  mypal = colorRampPalette(brewer.pal(9, "YlGnBu"))
  
  
  output$mostPlot = renderPlot({
    ggplot(data = start_df() %>% top_n(., 10), 
           aes(x = reorder(start.station.name, -count), y = count)) + 
      geom_bar(stat = "identity", aes(fill = start.station.name)) + 
      ggtitle("Most used Start-Stations") + 
      xlab("Station Names") +
      ylab("rides") + theme_economist() + scale_fill_manual(values = mypal(11)) + 
      theme(axis.text.x=element_blank(), 
            axis.title.x = element_text(margin = margin(t = 20, r=0,b=0,l=0), size = 16),
            axis.title.y = element_text(margin = margin(t=0,r=10,b=0,l=0), size = 16)) + 
      guides(fill=guide_legend(title="Station-Names")) 
    
  })
  
  output$leastPlot = renderPlot({
    ggplot(data = start_df() %>% top_n(., -10), 
           aes(x = reorder(start.station.name, -count), y = count)) + 
      geom_bar(stat = "identity", aes(fill = start.station.name)) + 
      ggtitle("Least used Start-Stations") + 
      xlab("Station Names") +
      ylab("rides") + theme_economist() + scale_fill_manual(values = mypal(11)) +
      theme(axis.text.x=element_blank(), 
            axis.title.x = element_text(margin = margin(t = 20, r=0,b=0,l=0), size = 16),
            axis.title.y = element_text(margin = margin(t=0,r=10,b=0,l=0), size = 16)) + 
      guides(fill=guide_legend(title="Station-Names")) 
       
  })
  
  output$mostEndPlot = renderPlot({
    ggplot(data = end_df() %>% top_n(., 10), 
           aes(x = reorder(end.station.name, -count), y = count)) +
      geom_bar(stat = "identity", aes(fill = end.station.name)) + 
      ggtitle("Most used End-Station") + 
      xlab("Station Names") +
      ylab("rides") + theme_economist() + scale_fill_manual(values = mypal(11)) +
      theme(axis.text.x=element_blank(), 
            axis.title.x = element_text(margin = margin(t = 20, r=0,b=0,l=0), size = 16),
            axis.title.y = element_text(margin = margin(t=0,r=10,b=0,l=0), size = 16)) + 
      guides(fill=guide_legend(title="Station-Names")) 
  })
  
  output$leastEndPlot = renderPlot({
    ggplot(data = end_df() %>% top_n(., -10), 
           aes(x = reorder(end.station.name, -count), y = count)) + 
      geom_bar(stat = "identity", aes(fill = end.station.name)) + 
      ggtitle("Least used End-Station") + 
      xlab("Station Names") +
      ylab("rides") + theme_economist() + scale_fill_manual(values = mypal(11)) +
      theme(axis.text.x=element_blank(), 
            axis.title.x = element_text(margin = margin(t = 20, r=0,b=0,l=0), size = 16),
            axis.title.y = element_text(margin = margin(t=0,r=10,b=0,l=0), size = 16)) + 
      guides(fill=guide_legend(title="Station-Names"))
  })
  
  output$StartLeaf =renderLeaflet({
    getColor <- function(OOO) {
      unname(sapply(OOO$Color, function(Color) {
        if(Color == "M") {
          "red"
        } else {
          "green"
        } }))
    }
    
    
    icons <- awesomeIcons(
      icon = 'ion-android-bicycle',
      iconColor = 'black',
      library = 'ion',
      markerColor = getColor(OOO)
    )
    leaflet(OOO) %>% addProviderTiles("Esri.WorldTopoMap") %>%
      addAwesomeMarkers(lng = OOO$start.station.longitude, 
                        lat = OOO$start.station.latitude, icon=icons, 
                        label=~as.character(start.station.name))
  })
  
  output$EndLeaf = renderLeaflet({
    getColor <- function(CCC) {
      unname(sapply(CCC$Color, function(Color) {
        if(Color == "M") {
          "red"
        } else {
          "green"
        } }))
    }
    
    
    icons <- awesomeIcons(
      icon = 'ion-android-bicycle',
      iconColor = 'black',
      library = 'ion',
      markerColor = getColor(CCC)
    )
    leaflet(CCC) %>% addProviderTiles("Esri.WorldTopoMap") %>%
      addAwesomeMarkers(lng = CCC$end.station.longitude, 
                        lat = CCC$end.station.latitude, icon=icons, 
                        label=~as.character(end.station.name))
  })
  
  output$peakPlot = renderPlot({
    ggplot(data = peak_df(), aes(x = daytime_char, y = count)) + 
      geom_bar(stat = "identity", aes(fill = Peak)) + 
      ggtitle("Peak/Off Peak Use") + 
      xlab("Day time") +
      ylab("rides") + theme_economist() + 
      theme(axis.title.x = element_text(margin = margin(t = 20, r=0,b=0,l=0), size = 16),
            axis.title.y = element_text(margin = margin(t=0,r=10,b=0,l=0), size = 16))
    
  })
  
  output$performancePlot = renderPlotly({
     plot_ly(speeddist_df(), x = ~avg_trip_distance, y = ~mean_speed, type = "scatter",
             mode = "markers", size = ~count, color = ~GenderChr, colors = "Paired",
             sizes = c(10,25),
             marker = list(opacity = 0.4, sizemode = "diameter"),
             hoverinfo = "text",
             text = ~paste("Gender:", GenderChr, "<br> Age:", age, "<br> Mean Speed:", round(mean_speed, digits = 2), "<br> Avg Miles:",
                           round(avg_trip_distance, digits = 2), "<br> Count:", count)) %>%
       layout(title = "Performance by Age and Gender",
              xaxis = list(title = "Avg Distance in Kilometer",
                           range= c(0, 3),
                           showgrid = TRUE),
              yaxis =list(title = "Mean Speed (Km/h)",
                          range=c(0, 13),
                          showgrid = TRUE),
              showlegend = TRUE)

   })
  
  output$speedDensityPlot = renderPlot({
    ggplot(data = speeddist_df(), aes(x=mean_speed)) + 
      geom_density(aes(color = GenderChr, fill = GenderChr, alpha = 0.5)) + ggtitle("Speed Density") + 
      xlab("Mean Speed") +
      ylab("Density") + theme_economist() + 
      theme(axis.title.x = element_text(margin = margin(t = 20, r=0,b=0,l=0), size = 16),
            axis.title.y = element_text(margin = margin(t=0,r=10,b=0,l=0), size = 16))
  })
  
  output$distDensityPlot = renderPlot({
    ggplot(data = speeddist_df(), aes(x=avg_trip_distance)) +
      geom_density(aes(color = GenderChr, fill = GenderChr, alpha = 0.5)) + ggtitle("Distance Density") + 
      xlab("Average Distance") +
      ylab("Density") + theme_economist() + 
      theme(axis.title.x = element_text(margin = margin(t = 20, r=0,b=0,l=0), size = 16),
            axis.title.y = element_text(margin = margin(t=0,r=10,b=0,l=0), size = 16))
  })
  
 
   
  
  output$routeMap = renderLeaflet({
    
    icons <- awesomeIcons(
      icon = 'ion-android-bicycle',
      iconColor = 'black',
      library = 'ion',
      markerColor = "green"
    )
    
    map = leaflet()%>%
      addProviderTiles("Esri.WorldTopoMap") %>%
      addAwesomeMarkers(data = routes_map %>% head(., 47), lng = ~long, lat = ~Lat, 
                 icon = icons, label = ~Station) %>%
      
      setView(lng=-74.038624, lat=40.724740, zoom = 13) 
    
    for(i in 1:40) {
      map = map %>%
        addPolylines(data = routes_map %>% filter(group == i), 
                     lng = ~long, lat = ~Lat, group = ~group, weight = 2)
    }
    map
      
  })

}

 