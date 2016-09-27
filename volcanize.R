library(data.table)

volcanize <- function(inFile)
{
    T <- read.table(inFile)
    
    TcolNames <- c("x", "y", "signal")
    
    colnames(T) <- TcolNames
    
    volcanized <- matrix(ncol = (max(T$x) - min(T$x) + 1), nrow = (max(T$y) - min(T$y) + 1))

    for(i in 1:(max(T$x)-min(T$x)+1))
        {
        for (j in 1:(max(T$y)-min(T$y)+1))
            {
            if(length(T$signal[T$x == (min(T$x) + i) & T$y == (min(T$y) + j)]) != 0)
                {
                volcanized[j,i] <- T$signal[T$x == (min(T$x) + i) & T$y == (min(T$y) + j)]
                }
                else
                {
                    volcanized[j,i] <- 0
                }
            }
        }
    vPlot <- plot_ly(z = volcanized, type = "surface")
    vPlot
}

#this routine will average same coordinate pixel signal and make a matrix from it

volcanize1 <- function(indf, outputVariable = "nAppearance", inVoltage = -1, setMaximum = 0, xmin = 1, xmax = 256, ymin = 1, ymax = 256)
# outputVaiable : either nAppearance by devault, or signal to have signal map
# setMaxumum : this puts a little dot in the corner to set the z axis color scale
    {
    if (inVoltage != -1) ldf <- subset(indf, indf$voltage == inVoltage)
    else ldf <- indf
    
    ldf$nAppearance <- 1
    ldf$id <- ldf$x*1000 + ldf$y
    dt <- data.table(ldf, key = "id")
    dt1 <- dt[, list(x = mean(x), y = mean(y), signal = mean(signal), nAppearance = sum(nAppearance), voltage = mean(voltage)), by = id]
    ldf <- data.frame(dt1)
    ldf <- ldf[order(ldf$id), ]
    
    f <- matrix(nrow = 256, ncol = 256)
    
    for (i in 1:256)
        for (j in 1:256)
        {
            if (is.na(match(i*1000 + j, ldf$id))) f[i, j] <- 0
            else
            {
                if (outputVariable == "nAppearance") f[i, j] <- ldf$nAppearance[ldf$id == i*1000 + j]
                if (outputVariable == "signal") f[i, j] <- ldf$signal[ldf$id == i*1000 + j]
            }
        }
    
    f[xmax, ymax] <- setMaximum
    f <- f[xmin:xmax, ymin:ymax]
    return(f)
    }

drawHeatMap <- function(m)
{
    list_f <- c(m)
    ulist_f <- unique(list_f)
    vals <- scales::rescale(ulist_f)
    o <- order(vals, decreasing = FALSE)
    cols <- scales::col_numeric("Reds", domain = NULL)(vals)
    cols[1] <- "#00AAAA"
    colz <- setNames(data.frame(vals[o], cols[o]), NULL)
    
    p1 <- plot_ly(z = m, colorscale = colz, type = "heatmap")
    return(p1)
}
