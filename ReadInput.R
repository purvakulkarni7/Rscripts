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
source('~/Lab_proceedings/Work/Mina_SIMS_Data/Rscripts/generatePlot.R', echo=TRUE)
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

#plotName = "Raw Data"
#m = matrix(spectralData$rawData$V3, nrow, ncol)
#rawDataPlot <- generatePlot(m, plotName)

rawDataPlot <- generatePlot(spectralData, plotName)
png(file="/home/purva/Lab_proceedings/Work/Mina_SIMS_Data/Deliverable6/High_Resolution_Images/RPlot_Original_png/plot.png",width=8,height=8,units="cm",res=300, pointsize=7)
spplot(rawDataPlot, scales = list(draw = TRUE), col.regions=hotmetal(255), main=plotName)
dev.off()



#Transpose the third coloumn (containing intensity values for further use)
intensityDataTransposed<-t(intensityData$V3)

#Using ALS - Asymmetric Least Squares baseline correction
bc.als <-baseline(intensityDataTransposed, method='als')
plotName = "ALS"
bcAlsPlot <- baselineCorrection(bc.als, nrow, ncol, plotName)
png(file="/home/purva/Lab_proceedings/Work/Mina_SIMS_Data/Deliverable6/High_Resolution_Images/RPlot_Baseline_Corrected/plot.png",width=8,height=8,units="cm",res=300, pointsize=7)
#spplot(bcAlsPlot, zlim=c(30,110), col.regions=hotmetal(255), main=plotName)
spplot(bcAlsPlot, col.regions=hotmetal(255), main=plotName)
dev.off()

# Using Baseline Correction and Peak Detetection at the same time
bc.pks<-baseline(intensityDataTransposed, method='peakDetection', left=300, right=300, lwin=50, rwin=50)
plotName = "Peak Detection"
bcPksPlot <- baselineCorrection(bc.pks, nrow, ncol, plotName)

# Using Iterative Restricted Least Squares Baseline Correction
bc.irls<-baseline(intensityDataTransposed, method='irls')
plotName = "IRLS"
bcIrlsPlot <- baselineCorrection(bc.irls, nrow, ncol, plotName)

# Using Low Pass FFT Filter Baseline Correction
# bc.lowpass<-baseline(intensityDataTransposed, method='lowpass')
# plotName = "Lowpass"
# bcLowpassPlot <- baselineCorrection(bc.lowpass, nrow, ncol, plotName)

# Using Median Window for Baseline Correction
bc.medianWindow<-baseline(intensityDataTransposed, hwm = 300, method='medianWindow')
plotName = "Median Window"
bcMedianWindowPlot <- baselineCorrection(bc.medianWindow, nrow, ncol, plotName)

# Using Modified Polynomial Fitting for Baseline Correction
bc.modpolyfit<-baseline(intensityDataTransposed, deg=6, method='modpolyfit')
plotName = "Modified Poly. Fit"
bcModpolyfitPlot <- baselineCorrection(bc.modpolyfit, nrow, ncol, plotName)

# for(i in 1:length(transpostedCorrected))
# {
#   if(transpostedCorrected[i] < 0)
#     transpostedCorrected[i] = 0  
# }
# head(transpostedCorrected)

grid.arrange(rawDataPlot, rawDataPlot, rawDataPlot, rawDataPlot, rawDataPlot, bcAlsPlot, bcPksPlot, bcIrlsPlot, bcMedianWindowPlot, bcModpolyfitPlot, ncol=5, nrow=2)

