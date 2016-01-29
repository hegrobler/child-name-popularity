setwd("C:/Users/Lambert/Documents/Google Drive/Study/poker/")
source(file="global.R")
data.all <- loadDataset()

top <- topOverall(data.all, 10)
write.csv(top, file = "presentation_top.csv")

