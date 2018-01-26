library(DT)
library(shiny)
library(shinydashboard)


shinyUI(dashboardPage(
  dashboardHeader(title = "Citi Bike September 2017 Analysis"),
  dashboardSidebar(
    sidebarUserPanel("Merle Strahlendorf",
                     image = "https://media-exp2.licdn.com/mpr/mpr/shrinknp_200_200/AAEAAQAAAAAAAASFAAAAJGQ4MWU3M2ZjLTU5YWMtNDcxNC1iNmU0LWQ5MTUzYzQ2OGNkYg.jpg"),
    sidebarMenu(
      menuItem("Frequency", tabName = "frequency",
               menuSubItem("Monday", tabName = "monday"),
               menuSubItem("Tuesday", tabName = "tuesday"),
               menuSubItem("Wednesday", tabName = "wednesday"),
               menuSubItem("Thursday", tabName = "thursday"),
               menuSubItem("Friday", tabName = "friday"),
               menuSubItem("Saturday", tabName = "saturday"),
               menuSubItem("Sunday", tabName = "sunday")
               ),
       
  
      menuItem("Rides", tabName = "rides",
               menuSubItem("Female", tabName = "female"),
               menuSubItem("Male", tabName = "male")
               ),
        
        
     
      #menuItem("Monday", tabName = "monday"),
      #menuItem("Tuesday", tabName = "tuesday"),
      #menuItem("Wednesday", tabName = "wednesday"),
      #menuItem("Thursday", tabName = "thursday"),
      #menuItem("Friday", tabName = "friday"),
      #menuItem("Saturday", tabName = "saturday"),
      #menuItem("Sunday", tabName = "sunday")
    )),
  dashboardBody(
    tabItems(
      tabItem(tabName = "frequency", 
              plotOutput("most_used_station")
      
    ))
  )
    
))
