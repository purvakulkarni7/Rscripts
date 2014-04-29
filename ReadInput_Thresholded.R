## ReadInput.R
## This is a R script which takes in the file name (txt file) as an input along with its file path and then extracts the m/z and intensity information in the form of a matrix with two columns m/z and intensity.

library("raster")
library("rasterVis")
library("baseline")
library("dcemriS4")

require(gridExtra) # also loads grid
require(lattice)

#Call the source files of the function which this script will use
source('~/Lab_proceedings/Work/Mina_SIMS_Data/Rscripts/readSIMSdata.R', echo=TRUE)
source('~/Lab_proceedings/Work/Mina_SIMS_Data/Rscripts/generatePlot_Thresholded.R', echo=TRUE)
source('~/Lab_proceedings/Work/Mina_SIMS_Data/Rscripts/baselineCorrection.R', echo=TRUE)
source('~/Lab_proceedings/Work/Mina_SIMS_Data/Rscripts/generateCorrelationPlot.R', echo=TRUE)

grid <- expand.grid(x=200, y=200)

# Prompt the user to enter the filepath
FILE_PATH <- readline(prompt = "Enter a full path and file name: ")

#Call the function readSIMSdata.R and provide FIL_PATH as input
spectralData <- readSIMSdata(FILE_PATH)

#Retrive the data containing the intensity values and the x-y pixels from the list
intensityData<-spectralData$rawData
nrow<-spectralData$xPixels
ncol<-spectralData$yPixels

#Call the function generatePlot and provide spectralData to generate a spplot from the rawdata
plotName <- readline(prompt = "Enter plot name: ")

m = matrix(spectralData$rawData$V3, nrow, ncol)

rawDataPlot <- generatePlot_Thresholded(m, plotName)
png(file="/home/purva/Lab_proceedings/Work/Mina_SIMS_Data/Deliverable6/High_Resolution_Images/RPlot_Thresholded_png/plot.png",width=8,height=8,units="cm",res=300, pointsize=7)
spplot(rawDataPlot, scales = list(draw = TRUE),  col.regions=hotmetal(255), main=plotName)
dev.off()
