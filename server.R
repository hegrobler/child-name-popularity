#install.packages(c('shiny', 'ggvis', 'dplyr'))
library(shiny)
library(googleVis)
library(reshape)

data.all <- loadDataset()
data.top <- NULL

shinyServer(function(input, output, session) {
  
  # Filter the movies, returning a data frame
  geoChartData <- reactive({
    state <- input$state
    year <- input$year
    name <- input$name
    
    if (!is.null(name) && name != "") {
      data.states.all <- subset(data.all, grepl(name, data.all$Name))
    } else {
      data.state <-  subset(data.all, Year == year)
      data.state <- data.state[order(-data.state$Count),]
      data.top.ten <- as.character(data.state[1:10,]$Name)
      data.states.all <- data.all[data.all$Name %in% data.top.ten,]
    }
    
    if (nrow(data.states.all) == 0) {
      values$lineChartAvailable <- FALSE
      data.states.sum <- data.states.all
    } else {
      values$lineChartAvailable <- TRUE
      data.states.sum <- aggregate(data.states.all$Count, by=list(Name=data.states.all$Name, Name=data.states.all$State), FUN=sum)
      colnames(data.states.sum) <- c('Name', 'State', 'Count')
    }
    
    data.states.sum 
  })
  
  stateChildNames <- reactive({
    state <- input$state
    year <- input$year
    name <- input$name
    
    if (!is.null(name) && name != "") {
      data.state <- subset(data.all, State == state & grepl(name, data.all$Name))
      data.top <<- unique(as.character(data.state$Name))
    } else {
      data.state <-  subset(data.all, Year == year & State == state)
      data.state <- data.state[order(-data.state$Count),]
      data.top <<- as.character(data.state[1:10,]$Name)
    }
    
    data.state <- subset(data.all, State == state & Name %in% data.top)
    
    data.state
  })
  
  values <- reactiveValues(
    lineChartAvailable = TRUE,
    geoChartAvailable = TRUE
  )
  
  output$plotTopName <- renderGvis({

    data.state <- stateChildNames()
    
    if (nrow(data.state) == 0) {
      values$lineChartAvailable <- FALSE
      NULL
    } else {
      values$lineChartAvailable <- TRUE
      
      data.states.sum <- cast(data.state, Year~Name, sum, value="Count")
   
      p <- gvisLineChart(
        data.states.sum, xvar="Year", 
        yvar=data.top,
        options=list(width=600, height=400)
      )
      p
    }
  })
  
  output$geoChart <- renderGvis({
    year <- input$year
    state <- input$state
    
    data.geo.chart <- geoChartData()
    
    geoStates <- gvisGeoChart(data.geo.chart, "State", "Count",
          options=list(region="US", 
                       displayMode="regions", 
                       resolution="provinces",
                       width=600, height=400))
    geoStates
  })
  
  output$topNamesError <- renderText({
    if (values$lineChartAvailable) {
      message <- ''
    } else {
      message <- 'No data available'
    }

    message
  })
  
  output$geoChartError <- renderText({
    if (values$geoChartAvailable) {
      message <- ''
    } else {
      message <- 'No data available'
    }
    
    message
  })
  
  output$summary <- renderText({
    state <- input$state
    year <- input$year
    name <- input$name
    
    if (!is.null(name) && name != "") {
      v <- paste("Number of times that a child was named ",name,'during year',year, 'accross the USA.')
    } else {
      data.top.one <- topNPerState(data.all, state, year, 1)
      v <- paste("Top children's name in", state, 'during year',year,'is',data.top.one,". The following chart shows how many children was named", data.top.one, 'in', year, 'accross the USA.')
    }  

    v
  })
  
})