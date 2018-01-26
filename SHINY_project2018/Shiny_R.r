Citi_Bike_717 = read.csv("JC-201709-citibike-tripdata.csv", stringsAsFactors = F)
Try_Bike2 = Citi_Bike_717

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


routes = Citi_Bike_717 %>% group_by(., start.station.name, end.station.name) %>% 
  summarise(., counts = n()) %>% 
  arrange(., desc(counts)) %>% 
  head(., 10)

