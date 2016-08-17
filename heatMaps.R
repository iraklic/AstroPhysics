library(plotly)
library(data.table)

source('~/R/AstroPhysics/sensDataReader.R')

prepSensData <- function(pathToFolder, inVoltage)
    {
    s <- sensDataReader(pathToFolder, returnData = TRUE)

    # remove one noise pixel
    s <- subset(s, s$x < 220)

    # add nAppearance variable
    s$nAppearance <- 1

    # add unique id to each pixel
    s$id <- s$x*1000 + s$y

    print (inVoltage)
    
    s1 <- subset(s, s$voltage == inVoltage)
    
    return(s1)
    
    dt <- data.table(s1, key = "id")
    dt1 <- dt[, list(x = mean(x), y = mean(y), signal = mean(signal), nAppearance = sum(nAppearance), voltage = mean(voltage)), by = id]
    s11 <- data.frame(dt1)
    s11 <- s11[order(s11$id), ]

    f <- matrix(nrow = 256, ncol = 256)
    for (i in 1:256)
        for (j in 1:256)
            {
            if (is.na(match(i*1000 + j, s11$id))) f[i, j] <- 0
            else f[i, j] <- s11$nApp[s4$id == i*1000 + j]
            }

    p1 <- plot_ly(z = f, type = "heatmap")
    
    return(s11)
    }