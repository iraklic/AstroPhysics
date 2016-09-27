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
    
    dt <- data.table(s1, key = "id")
    dt1 <- dt[, list(x = mean(x), y = mean(y), signal = mean(signal), nAppearance = sum(nAppearance), voltage = mean(voltage)), by = id]
    s11 <- data.frame(dt1)
    s11 <- s11[order(s11$id), ]
    
    f <- matrix(nrow = 256, ncol = 256)
    for (i in 1:256)
        for (j in 1:256)
            {
            if (is.na(match(i*1000 + j, s11$id))) f[i, j] <- 0
            else f[i, j] <- s11$nAppearance[s11$id == i*1000 + j]
            }

    f[256, 256] <- 80 # this is to fix the upper scale on the color code axis
    
    list_f <- c(f)
    ulist_f <- unique(list_f)
    vals <- scales::rescale(ulist_f)
    o <- order(vals, decreasing = FALSE)
    cols <- scales::col_numeric("Reds", domain = NULL)(vals)
    cols[1] <- "#00AAAA"
    colz <- setNames(data.frame(vals[o], cols[o]), NULL)

    plotTitle <- paste("Voltage = ", inVoltage, sep = "")
    
    p1 <- plot_ly(z = f, colorscale = colz, type = "heatmap")
#    p1 <- layout(title = plotTitle)
    return(p1)
    
    return(p1)
    }