# convert binary file to data.frame
bin2data <- function(binFile)
{
    fCon <- file(binFile, "rb")
    rData <- readBin(fCon, integer(), n = 65536)
    close(fCon)
    
    rdf <- data.frame(x = numeric(), y = numeric(), signal = numeric())
    
    xCoord <- 0
    yCoord <- 0
    for (reading in rData)
    {
        if (reading != 0 && reading != 11810) 
        {
            trdf <- data.frame(x = xCoord, y = yCoord, signal = reading)
            rdf <- rbind(rdf, trdf)
        }
        if (xCoord > 254) 
        {                
            xCoord <- 0
            yCoord <- yCoord +1
        }
        else xCoord <- xCoord + 1
    }
    return(rdf)
}

# INPUT FOR SENSDATAREADER
# pathToFiles : path to the directory where txt or bin files are
# suffix : it just a little comment if you wanna add to the final distilled data (e.g. "FilterUsed", etc.)
# fileType : if the input is binary put "bin"
# inPattern : particular patern of files to be selected
# skipHeader : if the data files contain some non-data header lines one can skip them
# parsing : if data file naming convention is not observed, i.e. filenames do not contain segging info (<delay>d<voltage>v<threshold>)
# returnData : make this true if you just want total data return instead of distilled data
# example : myData <- sensDataReader(<path>, fyleType = "bin")

sensDataReader <- function(pathToFiles, suffix = "", fileType = "txt", skipHeader = 0, parsing = TRUE, returnData = FALSE, inPattern = "")
    {
    nominalThr <- c(H4W261 = 360, C7W260 = 385, E7W260 = 390, H9W261 = 300, H5W261 = 400, H6W261 = 340)
    sensorDepth <- c(H4W261 = 300, C7W260 = 200, E7W260 = -1, H9W261 = 50, H5W261 = 120, H6W261 = 200)
    vLength <- c(Blue = 470, Red = 630, Green = 525, Yellow = 595, UV = 405)
    dirs <- unlist(strsplit(pathToFiles, split = "/"))
    
    color <- dirs[9]
    sensor <- dirs[10]
    lambda <- vLength[color]
    
    print(paste(color, " : ", sensor))

    filePattern = paste("*_*.", fileType, sep = "")
    fileNames <- list.files(pathToFiles, pattern = c(filePattern, inPattern), recursive = FALSE, include.dirs = FALSE, full.names = TRUE)
    
    fileNames <- Filter(function(x) grepl(inPattern, x), fileNames)
    
    out <- data.frame(signal = numeric(), voltage = numeric(), delay = numeric(), threshold = numeric(), nPixel = numeric())
    
    tempVoltage <- -999
    tempDelay <- -999
    tempThreshold <- -999
    tempSignal <- -999
    tempNPixel <- -999
    
    if (returnData) tempd <- data.frame(x = numeric(), y = numeric(), signal = numeric(), voltage = numeric(), nAppearance = numeric())
    else tempd <- data.frame(x = numeric(), y = numeric(), signal = numeric())
    
    progressCounter <- 0
    for (f in fileNames)
        {
        if ((progressCounter %% 10) == 0) print(paste(progressCounter, "of", length(fileNames), "", tempVoltage))
        progressCounter <- progressCounter + 1
        
        info = file.info(f)
        
        if (info$size == 0) next()
        
        bf <- basename(f)
        if (fileType == "txt")
        {
            d <- read.table(f, skip = skipHeader)
            colnames(d) <- c("x", "y", "signal")
        } 
        else d <- bin2data(f)
        
        if (parsing)
        {
            pos_d <- regexpr('d', bf)[1]
            delay <- as.numeric(substr(bf, start = 1, stop = pos_d - 1))
        
            pos_v <- regexpr('v', bf)[1]
            voltage <- as.numeric(substr(bf, start = pos_d + 1, stop = pos_v - 1))
        
            pos_th <- regexpr('_', bf)[1]
            threshold <- as.numeric(substr(bf, start = pos_v + 1, stop = pos_th - 1))
        }
        else
        {
            delay <- 9999
            voltage <- 9999
            threshold <- 9999
        }
        
        if (returnData)
            {
            d$voltage <- voltage
            d$nAppearance <- 1
            }
        
        if (tempVoltage != voltage || tempDelay != delay || tempThreshold != threshold)
            {
        #    cutOut <- subset(tempd, tempd$signal > 10 & tempd$signal < 200 & tempd$x > 80 & tempd$x < 140 & tempd$y > 80 & tempd$y < 140)
        #    cutOut <- subset(tempd, tempd$signal > 10 & tempd$signal < 500)
            cutOut <- tempd
            tempSignal <- mean(cutOut$signal)
            if (tempVoltage != -999)
                {
                tempData <- data.frame(signal = tempSignal, voltage = tempVoltage, threshold = tempThreshold, delay = tempDelay, nPixel = tempNPixel)
                out <- rbind(out, tempData)
                }
            
            if (returnData)
                if (tempVoltage == -999)
                    {
                    tempd <- d
                    startNP <- 0
                    }
                else
                    {
                    startNP <- nrow(tempd)
                    tempd <- rbind(tempd, d)
                    }
            else tempd <- d
            
            
            if (returnData) print (paste("NEW VOLTAGE", voltage, "already have", startNP, "rows!"))

            tempVoltage <- voltage
            tempThreshold <- threshold
            tempDelay <- delay
            }
        else
            {
#           checking how many times pixel appeared in different data snapshots
            if (returnData)
                {
                for (np in (startNP+1):nrow(tempd))
                    {
#                   if ((np - startNP) %% 10 == 0) print (paste(np, "of", nrow(tempd)))
                    for (npd in 1:nrow(d))
                       {
                        if (tempd[np,]$x == d[npd,]$x && tempd[np,]$y == d[npd,]$y)
                            {
                            tempd[np,]$nAppearance <- tempd[np,]$nAppearance + 1
#                           print(paste(tempd[np,]$x, "", d[npd,]$x, "", tempd[np,]$y, "", d[npd,]$y))
                            }
                        }
                }
            }
                
            tempd <- rbind(tempd, d)
            if (tempNPixel != 0) {tempNPixel <- mean(c(tempNPixel, nrow(d)))}
            else {tempNPixel <- nrow(d)}

            }
#        print(paste(voltage, " : ", delay, " : ", threshold))
        remove(d)
        }
    
#   Last entry
#    cutOut <- subset(tempd, tempd$signal > 10 & tempd$signal < 200 & tempd$x > 90 & tempd$x < 130 & tempd$y > 90 & tempd$y < 130)
#    cutOut <- subset(tempd, tempd$signal > 10 & tempd$signal < 500)
    cutOut <- tempd
    tempSignal <- mean(cutOut$signal)
    tempData <- data.frame(signal = tempSignal, voltage = tempVoltage, threshold = tempThreshold, delay = tempDelay, nPixel = tempNPixel)
    out <- rbind(out, tempData)
    
    if (returnData) return(tempd)
    else remove(tempd)
    
    out$sensor <- sensor
    out$LED <- color
    out$lambda <- lambda
    out$comment <- suffix
    out$depth <- sensorDepth[sensor]
    out$Id <- paste(sensor, " : ", suffix, " : ", sensorDepth[sensor], " (nm)")
    
#    out <- subset(out, out$threshold == nominalThr[sensor])
    
    return(out)
    }

sensorPlotMaker <- function(sensData, mainThreshold)
    {
    library(plotly)
    
    # ================== macros
    out <- subset(sensData, sensData$voltage == 5)
    m <- tapply(out$nPixels, out$threshold, mean)
    thresholds <- as.numeric(names(m))
    pixelCount <- unname(m)
    
    d1 <- data.frame(threshold = thresholds, nPixels = pixelCount)
    p1 <- plot_ly(d1, x = threshold, y = nPixels)
    
    #------------------------------------------------
    m <- tapply(out$meanCentralSignal, out$threshold, mean)
    thresholds <- as.numeric(names(m))
    signalValue <- unname(m)
    
    d4 <- data.frame(threshold = thresholds, signal = signalValue)
    p4 <- plot_ly(d4, x = voltage, y = signal, mode = "markers")
    
    #------------------------------------------------
    out <- subset(sensData, sensData$threshold == mainThreshold & sensData$delay == 100)
    m <- tapply(out$nPixels, out$voltage, mean)
    voltages <- as.numeric(names(m))
    pixelCount <- unname(m)
    
    d2 <- data.frame(voltage = voltages, nPixels = pixelCount)
    p2 <- plot_ly(d2, x = voltage, y = nPixels, mode = "markers")
    #------------------------------------------------
    
    m <- tapply(out$meanCentralSignal, out$voltage, mean)
    voltages <- as.numeric(names(m))
    signalValue <- unname(m)
    
    d3 <- data.frame(voltage = voltages, signal = signalValue)
    p3 <- plot_ly(d3, x = voltage, y = signal, mode = "markers")
    #------------------------------------------------
    
    
    outPlots <- list("p1" = p1, "p2" = p2, "p3" = p3, "p4" = p4, "d1" = d1, "d2" = d2, "d3" = d3, "d4" = d4)
    outPlots
    }

moneyPlots <- function(mData)
    {
    mPlot <- plot_ly(mData, x = voltage, y = signal, color = sensor)
    }
