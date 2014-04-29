#Function generatePlot: 
#Takes the spectral data and plot name (string) as input and generates a raster image with the rainbow color scheme
#Author: Purva Kulkarni
#Date: 24 March 2014

#######################################################################################################

#Start of function
generatePlot <- function (data, plotName) {
  
#   # which values are below 0.5*max?
#   below = which(data<0.5*max(data,na.rm=T))
#   
#   # change these values to NA
#   data[below] <- 0
#   
#   # make a raster of the matrix
#   rv1 <- raster(data, xmn=0, ymn=0, xmx=1, ymx=1)
#   
#   # create the plot
#   #plotData <- spplot(rv1, scales = list(draw = TRUE), col.regions=rainbow(100, start = 1/6, end = 1), main=plotName)
#   plotData <- spplot(rv1, scales = list(draw = TRUE),  col.regions=hotmetal(255), main=plotName)
#   
#   return(plotData)
  
   #rv <- raster(nrows=data$xPixels, ncols=data$xPixels)
   rv1 <- raster(matrix(data$rawData$V3, nrow = data$xPixels, byrow = T), xmn=0, ymn=0, xmx=1, ymx=1)
 #plotData <- spplot(rv1, scales = list(draw = TRUE), col.regions=rainbow(100, start = 1/6, end = 1), main=plotName)
 
#spplot(rv1, scales = list(draw = TRUE), col.regions=hotmetal(255), main=plotName)
return(rv1)
 #return(plotData)

 
 #plotData <- spplot(rv1, scales = list(draw = TRUE), col.regions=topo.colors(255), main=plotName)
 #plotData <- spplot(rv1, zlim=c(8,10), col.regions=topo.colors(255), main=plotName)
}