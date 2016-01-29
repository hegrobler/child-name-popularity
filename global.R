setwd("~/Google Drive/Study/child-name-popularity/")

loadDataset <- function() {
  data.all <- read.csv(paste(getwd(),'all_states.csv', sep='/'), header = FALSE)
  colnames(data.all) <- c('State', 'Gender', 'Year', 'Name', 'Count')
  data.all
}

#dataForState <- function(ds, year) {
#  data.state <-  subset(ds, Year == year)
#  data.state <- data.state[order(-data.state$Count),]
#  data.state
#}

#dataForStateAndYear <- function(ds, state, year) {
#  data.state <-  subset(ds, Year == year & State == state)
#  data.state <- data.state[order(-data.state$Count),]
#  data.state
#}

#topN <- function(ds, year, numberOfNames) {
#  data.state <- dataForState(ds, year)
#  data.top <- as.character(data.state[1:numberOfNames,]$Name)
#  data.top
#}

#topNPerState <- function(ds, state, year, numberOfNames) {
#  data.state <- dataForStateAndYear(ds, state, year)
#  data.top <- as.character(data.state[1:numberOfNames,]$Name)
#  data.top
#}

topOverall <- function(ds, numNames) {
  
  # Most polular names 
  data.popular <- aggregate(ds$Count, by=list(Name=data.all$Name), FUN=sum)
  colnames(data.popular) <- c('Name', 'Count')
  
  total <- sum(data.popular$Count)
  data.popular <- data.popular[with(data.popular, order(-Count)),]
  data.popular <- data.popular[c(1:numNames),] 
  data.popular$percentOf <- round(data.popular$Count / total * 100, 2)
  data.popular
}


