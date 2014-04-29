#Function generatePlot: 
#Takes the spectral data and plot name (string) as input and generates a raster image with the rainbow color scheme
#Author: Purva Kulkarni
#Date: 24 March 2014

#######################################################################################################

#Start of function
generatePlot_Thresholded <- function (data, plotName) {
  
    # which values are below 0.5*max?
    below = which(data<0.5*max(data,na.rm=T))
    
    # change these values to NA
    data[below] <- 0
    
    # make a raster of the matrix
    rv1 <- raster(t(data))
    return(rv1)
}