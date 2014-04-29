#Function generateCorrelationPlot: 
#Takes the spectral data for three datasets and finds the correlation bteween all the three dataset
#Author: Purva Kulkarni
#Date: 24 March 2014s

#######################################################################################################

#Start of function
library(gclus)

generateCorrelationPlot <- function (intensityData1, intensityData2, intensityData3) {
  data<-cbind(intensityData1, intensityData2, intensityData3)
  data.r <- abs(cor(data))
  data.col <- dmat.color(data.r)
  data.o <- order.single(data.r)
  cpairs(data, data.o, panel.colors=data.col, gap=.5,main="Variables Ordered and Colored by Correlation")
  return(data)
}