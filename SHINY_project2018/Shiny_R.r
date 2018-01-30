


Citi_Bike_717$starttime = as.POSIXct(Citi_Bike_717$starttime,format="%Y-%m-%d %H:%M:%OS")
Citi_Bike_717$stoptime = as.POSIXct(Citi_Bike_717$stoptime,format="%Y-%m-%d %H:%M:%OS")
Citi_Bike_717$birth.year = as.numeric(Citi_Bike_717$birth.year)
Citi_Bike_717 = Citi_Bike_717 %>% mutate(., Weekdy1 = as.Date(Citi_Bike_717$starttime))
Citi_Bike_717 = Citi_Bike_717 %>% mutate(., Weekdy = sapply(Weekdy1, weekdays))

# each weekday 
Citi_Bike_717_Fri = Citi_Bike_717 %>% filter(., Weekdy == "Freitag")
Citi_Bike_717_Mon = Citi_Bike_717 %>% filter(., Weekdy == "Montag")
Citi_Bike_717_Tue = Citi_Bike_717 %>% filter(., Weekdy == "Dienstag")
Citi_Bike_717_Wed = Citi_Bike_717 %>% filter(., Weekdy == "Mittwoch")
Citi_Bike_717_Thu = Citi_Bike_717 %>% filter(., Weekdy == "Donnerstag")
Citi_Bike_717_Sat = Citi_Bike_717 %>% filter(., Weekdy == "Samstag")
Citi_Bike_717_Sun = Citi_Bike_717 %>% filter(., Weekdy == "Sonntag")

#Overall 
Citi_Bike_717_most_start = Citi_Bike_717 %>% 
  group_by(., start.station.name) %>% 
  summarise(., count = n()) %>%
  arrange(., desc(count))

Citi_Bike_717_least_start = Citi_Bike_717 %>% 
  group_by(., start.station.name) %>% 
  summarise(., count = n()) %>%
  arrange(., count)

Citi_Bike_717_most_end = Citi_Bike_717 %>% 
  group_by(., end.station.name) %>% 
  summarise(., count = n()) %>%
  arrange(., desc(count))

Citi_Bike_717_least_end = Citi_Bike_717 %>% 
  group_by(., end.station.name) %>% 
  summarise(., count = n()) %>%
  arrange(., count)



# Most used Startstation mondays 
Citi_Bike_717_Mon_most = Citi_Bike_717_Mon %>% 
  group_by(., start.station.name) %>% 
  summarise(., count = n()) %>%
  arrange(., desc(count))

#most used startstation tuesdays 
Citi_Bike_717_Tue_most = Citi_Bike_717_Tue %>% 
  group_by(., start.station.name) %>% 
  summarise(., count = n()) %>%
  arrange(., desc(count))

as.POSIXct(Try_Bike2$starttime,format="%Y-%m-%d %H:%M:%OS")
strptime(Try_Bike2$starttime)

weekdays(as.Date('16-08-2012','%d-%m-%Y'))
as.POSIXct("2017-09-01 00:08:12",format="%Y-%m-%d %H:%M:%OS",tz=Sys.timezone())

as.Date("2017-09-01 00:08:12")


routes = Citi_Bike_717 %>% 
  group_by(., start.station.name, end.station.name, start.station.latitude, 
           start.station.longitude, end.station.latitude, end.station.longitude) %>%
  summarise(., counts = n()) %>% 
  arrange(., desc(counts))

saveRDS(routes, "routes.RDS")

Distinct_station = Citi_Bike_717 %>% select(., StattionName = start.station.name, 
                                            Lat = start.station.latitude,
                                            Long = start.station.longitude) %>%
  distinct(StattionName, Lat, Long)


?distinct
library(shiny)
?icon
?infoBox

install.packages("ggthemes")

ggplot(data = Citi_Bike_717_most_start_10, aes(x = start.station.name, y = count)) + 
  geom_bar(stat = "identity") + ggtitle("Most used Start-Stations") + xlab("Station Names") +
  ylab("rides") + theme_economist() + scale_fill_economist() 

ggplot(data = Citi_Bike_717_most_end_10, aes(x = end.station.name, y = count)) + 
  geom_bar(stat = "identity") + ggtitle("Most used End Stations")



#adding weekday to the dataframe 
Citi_Bike_717$starttime = as.POSIXct(Citi_Bike_717$starttime,format="%Y-%m-%d %H:%M:%OS")
Citi_Bike_717$stoptime = as.POSIXct(Citi_Bike_717$stoptime,format="%Y-%m-%d %H:%M:%OS")
Citi_Bike_717$birth.year = as.numeric(Citi_Bike_717$birth.year)
Citi_Bike_717 = Citi_Bike_717 %>% mutate(., Weekdy1 = as.Date(Citi_Bike_717$starttime))
Citi_Bike_717 = Citi_Bike_717 %>% mutate(., Weekdy = sapply(Weekdy1, weekdays))


Genderconversion = function(x) {
  if(x == 2) {
    return("female")
  }else if(x == 1) {
    return("male")
  }else {
    return("unknown")
  }
}

Citi_Bike_717 = Citi_Bike_717 %>% mutate(., GenderChr = sapply(gender, Genderconversion))





leat_end_list = Citi_Bike_717_least_end_10$end.station.name
least_start_list = Citi_Bike_717_least_start_10$start.station.name
more_start_list = Citi_Bike_717_most_start_10$start.station.name
most_end_list = Citi_Bike_717_most_end_10$end.station.name

xyy = Citi_Bike_717 %>% select(., end.station.name, end.station.latitude, 
                               end.station.longitude) %>%
  filter(., end.station.name %in% most_end_list) %>% distinct()


xye = Citi_Bike_717 %>% select(., end.station.name, end.station.latitude, 
                               end.station.longitude) %>%
  filter(., end.station.name %in% leat_end_list) %>% distinct()

eyx = Citi_Bike_717 %>% select(., start.station.name, start.station.latitude, 
                              start.station.longitude) %>%
  filter(., start.station.name %in% least_start_list) %>% distinct()

yyx = Citi_Bike_717 %>% select(., start.station.name, start.station.latitude, 
                           start.station.longitude) %>%
  filter(., start.station.name %in% more_start_list) %>% distinct()


xye$Color = "L"
eyx$Color = "L"
xyy$Color = "M"
yyx$Color = "M"
  

CCC = rbind(xyy, xye)
OOO = rbind(eyx, yyx)

saveRDS(CCC, "EndStation.RDS")
saveRDS(OOO, "StartStation.RDS")

library(leaflet)
leaflet_citibike_end = leaflet(data = CCC) %>% 
  addProviderTiles("Esri.WorldTopoMap") %>%
  addMarkers(lng = CCC$end.station.longitude, 
             lat = CCC$end.station.latitude)
leaflet_citibike_end


#leaflet_citibike_start

getColor <- function(CCC) {
  unname(sapply(CCC$Color, function(Color) {
    if(Color == "M") {
      "red"
    } else {
      "green"
    } }))
}


icons <- awesomeIcons(
  icon = 'bicycle',
  iconColor = 'black',
  library = 'ion',
  markerColor = getColor(CCC)
)
leaflet(CCC) %>% addProviderTiles("Esri.WorldTopoMap") %>%
  addAwesomeMarkers(lng = CCC$end.station.longitude, 
                    lat = CCC$end.station.latitude, icon=icons, 
                    label=~as.character(Color))

getColor <- function(OOO) {
  unname(sapply(OOO$Color, function(Color) {
    if(Color == "M") {
      "red"
    } else {
      "green"
    } }))
}


icons <- awesomeIcons(
  icon = 'bicycle',
  iconColor = 'black',
  library = 'ion',
  markerColor = getColor(OOO)
)
leaflet(OOO) %>% addProviderTiles("Esri.WorldTopoMap") %>%
  addAwesomeMarkers(lng = OOO$start.station.longitude, 
                    lat = OOO$start.station.latitude, icon=icons, 
                    label=~as.character(Color))




library(data.table)
library(geosphere)



install.packages("geosphere")

?spDistsN1

library(geosphere)
library(dplyr)

library(sp)
distc= sapply(1:nrow(Citi_Bike_717),function(i)
  spDistsN1(as.matrix(Citi_Bike_717[i,6:7]),as.matrix(Citi_Bike_717[i,10:11]),longlat=T))
distc[1]

start_long = Citi_Bike_717ohne0 %>% select(., start.station.longitude)
start_lat = Citi_Bike_717ohne0 %>% select(., start.station.latitude)
end_long = Citi_Bike_717ohne0 %>% select(., end.station.longitude)
end_lat = Citi_Bike_717ohne0 %>% select(., end.station.latitude)
?cbind
coords = cbind(start_long, start_lat, end_long, end_lat)
distc = sapply(1:nrow(coords),function(i) spDistsN1(as.matrix(coords[i,1:2]),as.matrix(coords[i,3:4]),longlat=T))

Citi_Bike_717[ ,"distance"] = distc


Citi_Bike_717 = Citi_Bike_717 %>% mutate(., hours = tripduration / 3600)
Citi_Bike_717 = Citi_Bike_717 %>% mutate(., speed = distance * 60 * 60 / tripduration)

library(ggplot2)
ggplot(Citi_Bike_717, aes(x = distance, y = tripduration)) + geom_point()

library(dplyr)

dayend = function(x) {
  if(x == "Samstag" | x == "Sonntag") {
    return("Weekend")
  } else {
    return("Weekday")
  }
}

Citi_Bike_717 = Citi_Bike_717 %>% 
  mutate(., Peak = sapply(Weekdy, dayend))

dayhour = strftime(Citi_Bike_717$starttime, format="%H")
Citi_Bike_717[ , "dayhour"] = dayhour
Citi_Bike_717$dayhour = as.integer(Citi_Bike_717$dayhour)

daytime = function(x) {
  if(x > 3 & x < 10) {
    return("Morning")
  }else if(x > 9 & x < 16) {
    return("Midday")
  }else if(x > 15 & x < 22) {
    return("Evening")
  }else {
    return("Night")
  }
}

Citi_Bike_717 = Citi_Bike_717 %>% mutate(., daytime_char = sapply(dayhour, daytime))

library(ggplot2)

rideHour = Citi_Bike_717  %>% filter(., GenderChr == "male") %>%
  group_by(., daytime_char, Peak) %>% summarise(., count = n())

ggplot(data = rideHour, aes(x = daytime_char, y = count)) + 
  geom_bar(stat = "identity", aes(fill = Peak))
  

class(Citi_Bike_717$Peak)



Citi_Bike_717 = Citi_Bike_717 %>% 
  mutate(age=cut(birth.year, breaks=seq(1918,2018, by=5),
                 right = TRUE, labels = seq(100,5,by=-5)))
 
  
Citi_Bike_717ohne0 %>% filter(., distance > 150)

df_cust <- Citi_Bike_717ohne0 %>% select(usertype, age, GenderChr, 
                                    speed, tripduration, distance) %>%
  group_by(usertype, age, GenderChr) %>% 
  summarise(median_speed=median(speed),
            median_sum_duration=median(sum(tripduration /360)),
            avg_trip_distance=sum(distance)/n(), 
            count=n())


BubbleGraph = Citi_Bike_717ohne0 %>% select(usertype, age, GenderChr, 
                                    speed, tripduration, distance) %>%
  group_by(usertype, age, GenderChr) %>% 
  summarise(mean_speed=mean(speed),
            median_sum_duration=median(sum(tripduration /360)),
            avg_trip_distance=sum(distance)/n(), 
            count=n())

sapply(Citi_Bike_717, function(x) sum(is.na(x)))


Citi_Bike_717ohne0 = Citi_Bike_717[!(apply(Citi_Bike_717, 1, function(y) any(y == 0))),]
saveRDS(Citi_Bike_717ohne0, "CitiXZero.RDS")


saveRDS(Citi_Bike_717, 'citibike717.RDS')
