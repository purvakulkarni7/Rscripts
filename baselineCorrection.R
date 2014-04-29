#Function baselineCorrection: 
#Takes the data generated after applying baseline correction, the image dimensions and the plot name 
#Generates the basline corrected plot
#Author: Purva Kulkarni
#Date: 24 March 2014

#######################################################################################################

#Start of function
baselineCorrection <- function (bcData, xPixels, yPixels, plotName) {
  correctedSpectra <-getCorrected(bcData)  
  transposedCorrected<-t(correctedSpectra)  
  
  #Generate raster color map of the the transposedCorrected map
  rvCorrected <- raster(nrows=xPixels, ncols=yPixels)
  rv1Corrected <- raster(matrix(transposedCorrected, nrow = xPixels, byrow = T), xmn=0, ymn=0, xmx=1, ymx=1)
  #rv1Correctedals[rv1Correctedals < 40] <- 0 
  #plotCorrected <-spplot(rv1Corrected, zlim=c(30,110), col.regions=rainbow(100, start = 1/6, end = 1), main=plotName)
 # return(plotCorrected)
  return(rv1Corrected)
}