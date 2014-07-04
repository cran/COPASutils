## ----echo=FALSE, message=FALSE-------------------------------------------
require(knitr)

## ----set-options, echo=FALSE, cache=FALSE-----------------------------------------------------------------------------
options(width = 120)

## ----message=FALSE----------------------------------------------------------------------------------------------------
library(COPASutils)

## ----warning=FALSE----------------------------------------------------------------------------------------------------
setupRaw <- plateData1
setupSummarized <- summarizePlate(setupRaw)
colnames(setupSummarized)

## ----warning=FALSE----------------------------------------------------------------------------------------------------
setupSummarized2 <- summarizePlate(setupRaw, quantiles=TRUE, log=TRUE, ends=TRUE)
colnames(setupSummarized2)

## ---------------------------------------------------------------------------------------------------------------------
setupSummarized3 <- removeWells(setupSummarized, c("A2", "A4", "A6")) # All wells you want to remove need to be included here
head(setupSummarized3[,1:10])

## ---------------------------------------------------------------------------------------------------------------------
setupSummarized4 <- removeWells(setupSummarized, c("A2", "A4", "A6"), drop=TRUE)
head(setupSummarized4[,1:10])

## ---------------------------------------------------------------------------------------------------------------------
setupSummarized5 <- fillWells(setupSummarized4)
head(setupSummarized5[,1:10])

## ---------------------------------------------------------------------------------------------------------------------
edgeEffect(setupSummarized, "n")

## ----warning=FALSE, fig.width=10--------------------------------------------------------------------------------------
plotTrait(setupSummarized, "n")

## ----warning=FALSE, fig.width=10--------------------------------------------------------------------------------------
plotTrait(setupSummarized, "n") + ggtitle("Example Heatmap")

## ----warning=FALSE, fig.width=10--------------------------------------------------------------------------------------
plotTrait(setupRaw, "TOF", type="hist")

## ----warning=FALSE, fig.width=10--------------------------------------------------------------------------------------
plotTrait(setupRaw, "TOF", "EXT", type="scatter")

## ----warning=FALSE, fig.width=10--------------------------------------------------------------------------------------
scoreRaw <- plateData2
plotCompare(list(setupRaw, scoreRaw), "TOF", plateNames=c("Setup", "Score"))

## ----warning=FALSE, fig.width=10--------------------------------------------------------------------------------------
scoreSummarized <- summarizePlate(scoreRaw)
plotCompare(list(setupSummarized, scoreSummarized), "mean.TOF", plateNames=c("Setup", "Score"))

## ----warning=FALSE, fig.width=10--------------------------------------------------------------------------------------
plotCorMatrix(setupSummarized)

## ----warning=FALSE, fig.width=10--------------------------------------------------------------------------------------
plotCorMatrix(setupSummarized, scoreSummarized)

## ---------------------------------------------------------------------------------------------------------------------
dosesRaw <- doseData
strains <- rep(c("Strain 1", "Strain 2", "Strain 3", "Strain 4"), each=6, times=4)
dosesSummarized <- summarizePlate(dosesRaw, strains)
doses <- rep(c(0,2.5,5,10,20,NA), times=16)
plotDR(dosesSummarized, dosages=doses, trait="mean.TOF")

## ---------------------------------------------------------------------------------------------------------------------
plotList <- plotDR_allTraits(dosesSummarized, dosages=doses)

## ---------------------------------------------------------------------------------------------------------------------
plotList$median.red
plotList$mean.EXT

