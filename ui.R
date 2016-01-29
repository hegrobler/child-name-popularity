# For dropdown menu
actionLink <- function(inputId, ...) {
  tags$a(href='javascript:void',
         id=inputId,
         class='action-button',
         ...)
}

shinyUI(fluidPage(
  titlePanel("Child Name Popularity In USA"),
  helpText("Popularity of childrens names between 1910 and 2014"),
  fluidRow(
    column(4,
           wellPanel(
             h4("Filter"),
             sliderInput("year", "Year:", min=1910, max=2014, value=2014),
             selectInput("state", "State (USA)",
                         c('AK','AL','AR','AZ','CA','CO','CT','DC','NC','ND','NE','NH','NJ','NM','NV','NY','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VA','VT','WA','WI','WV','WY')
             ),
             textInput("name", "Child name contains (e.g., John)")
           )
    ),
    column(8,
           tabsetPanel(
             tabPanel("Top Name Accross States",
                helpText(''),
                textOutput("summary"),
                htmlOutput("geoChart"),
                textOutput("geoChartError"),
                helpText('* Move your mouse cursor over a particular state to see number of children with the particular name')
                
             ),
             tabPanel("Top 10 Names Over Time", 
              htmlOutput("plotTopName"),  
              textOutput("topNamesError"),
              helpText('    * Top ten names are selected from filter values in the side bar and are then plotted accross the time series')
             ), 
            tabPanel("Info",
              helpText("More information about the dataset can be found at https://www.ssa.gov/oact/babynames/limits.html")
            )
           )
    )
  )
))