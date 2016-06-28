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