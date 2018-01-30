


shinyUI(dashboardPage(
  dashboardHeader(title = "Citi Bike September 2017 Analysis"),
  dashboardSidebar(
    sidebarUserPanel("Merle Strahlendorf",
                     image = "https://media-exp2.licdn.com/mpr/mpr/shrinknp_200_200/AAEAAQAAAAAAAASFAAAAJGQ4MWU3M2ZjLTU5YWMtNDcxNC1iNmU0LWQ5MTUzYzQ2OGNkYg.jpg"),
    sidebarMenu(
      #menu bar with different select options 
      menuItem("Frequency", tabName = "frequency"

      ),
      
      #second menu item with different select options
      menuItem("Rides", tabName = "rides"
      )
      
    )),
  dashboardBody(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    ),
    tabItems(
      tabItem(tabName = "frequency",
              fluidRow(
                #drop down for different days
                selectInput('date', 'Pick a date', unique(Citi_Bike_717$Weekdy)),
                tabBox(
                  title = "Frequency",
                  id = "tabset1", height = "250px", width = '100%',
                  tabPanel("Start Station",
                           plotOutput("mostPlot"),
                           br(),
                           br(),
                           plotOutput("leastPlot")),
                  tabPanel("End Station", 
                           plotOutput("mostEndPlot"),
                           br(),
                           br(),
                           plotOutput("leastEndPlot")),
                  tabPanel("Start-Station-Map", 
                           leafletOutput("StartLeaf")),
                  tabPanel("End-Start-Map", leafletOutput("EndLeaf"))
                )
              )
        
      ),
      tabItem(tabName = "rides",
              fluidRow(
                selectInput("gender", "Pick a Gender", c("all", "male", "female", "unknown")),
                tabBox(
                  title = "Rides",
                  id = "tabset2", height = "250px", width = "50%",
                  tabPanel("Graphs", 
                           column(6, 
                           plotOutput("peakPlot"),
                           br(),
                           br(),
                           plotOutput("speedDensityPlot")),
                           column(6, 
                           plotlyOutput("performancePlot"),
                           br(),
                           br(),
                           plotOutput("distDensityPlot"))),
                  tabPanel("Ride-Map", leafletOutput("routeMap"))
                )
              ))
    )

              #
      )))
  

