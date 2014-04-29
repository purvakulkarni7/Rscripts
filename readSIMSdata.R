#Function readSIMSdata: 
#Takes the file path of the SIMS data .txt file and returns the data in the form of a list
#Return: spectraldata, xpixel, ypixel
#Author: Purva Kulkarni
#Date: 24 March 2014

#######################################################################################################

#Start of function
readSIMSdata <- function(path) {
  
  FILE_HANDLE=file(path,open="r")
  open(FILE_HANDLE)
  
  line8=readLines(FILE_HANDLE,n=8)
  for(i in 1:length(line8)){
    if(i==8){
      ## get the 8th line of each file and fetch the pixel size
      imageSize <- gsub("^# Image Size: ([[:digit:] x]+) *pixels$", "\\1", line8[8])
      
      ## split the strings at the " x " and turn into a matrix
      sizes <- do.call(cbind, lapply(strsplit(imageSize, " ?x ?"), as.numeric))
      
      ## find max values for x and y
      mc <- max.col(sizes)
      nx <- sizes[1, mc[1]]
      ny <- sizes[2, mc[2]]
    }
  }
  spectralData = read.table(FILE_HANDLE,skip=1:8)
  close(FILE_HANDLE)
  
  #Return the data in the form of table and the image sizes nx and ny
  tempList <- list("rawData" = spectralData, "xPixels" = nx, "yPixels" = ny)
  
  return(tempList)
}