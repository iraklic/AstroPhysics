library(shiny)
library(plotly)
library(xlsx)

source("spectraPlotter.R")

#tData <- read.csv("sensorData.csv")

alltData <- read.csv("sensorData.csv")
alltData <- alltData[with(alltData, order(LED, depth, sensor, voltage)),]

tData_NS <- subset(alltData, alltData$comment == "NS")
tData <- subset(alltData, alltData$comment != "NS")


withIIData <- read.csv("withII_below1v.csv")
#tData <- tData[with(tData, order(LED, sensor, voltage)),]

ui <- fluidPage(
    checkboxInput("TimePix", "Intime Hits Only", FALSE),
    plotlyOutput("withIIXY"),
    plotlyOutput("withIISignal"),
    sliderInput(inputId = "voltage_withII", min = 0.7, max = 1, value = 0.9, label = "Select Voltage", step = 0.02),
    sliderInput(inputId = "appearance_withII", min = 1, max = 60, value = 5, label = "Select Voltage", step = 1),
    plotlyOutput("ledPower"),
    plotlyOutput("ledSpectra"),
    selectInput(inputId = "lambda", choices = c("UV", "Blue", "Green", "Yellow", "Red"), label = "Select LED"),
    plotlyOutput("vPlot"),
    sliderInput(inputId = "voltage", min = 3, max = 10, value = 8, label = "Select Voltage", step = 0.5),
    plotlyOutput("tPlot")
)

server <- function(input, output)
{
    output$withIIXY <- renderPlotly(
        {
            if (input$TimePix) 
                sWithII <- subset(withIIData, withIIData$voltage == input$voltage_withII & withIIData$nAppearance >= input$appearance_withII & withIIData$signal > 4975 & withIIData$nAppearance < 4995)
            else
            sWithII <- subset(withIIData, withIIData$voltage == input$voltage_withII & withIIData$nAppearance >= input$appearance_withII)
                plot_ly(sWithII, x = x, y = y, color = signal, mode = "markers")
        }
    )
    output$withIISignal <- renderPlotly(
        {
            if (input$TimePix)
                s1WithII <- subset(withIIData, withIIData$nAppearance >= input$appearance_withII  & withIIData$signal > 4975 & withIIData$nAppearance < 4995)
            else
                s1WithII <- subset(withIIData, withIIData$nAppearance >= input$appearance_withII)
            meanWithII <- tapply(s1WithII$signal, s1WithII$voltage, mean)
            s2WithII <- data.frame(voltage = as.numeric(names(meanWithII)), signal = as.numeric(unlist(meanWithII)))
            plot_ly(s2WithII, x = voltage, y = signal)
        }
    )
    output$ledPower <- renderPlotly(
        {
            ledData <- read.xlsx("LedData.xlsx", sheetIndex = 1)
            plot_ly(ledData, x = Voltage, y = Power, color = LED, marker = list(color = ledData$LED), mode = "markers")
        }
    )
    output$ledSpectra <- renderPlotly(
        {
            puv
        }
    )
    output$vPlot <- renderPlotly(
        {
        plot_ly(subset(alltData, alltData$LED == input$lambda), x = voltage, y = signal, color = Id)
        }
    )
    output$tPlot <- renderPlotly(
        {
            subData <- subset(tData, tData$voltage == input$voltage)
            subData <- subData[with(subData, order(lambda)),]
            subData$signal[subData$sensor == "H9W261"] <- subData$signal[subData$sensor == "H9W261"] / subData$signal[subData$sensor == "H4W261"]
            subData$signal[subData$sensor == "C7W260"] <- subData$signal[subData$sensor == "C7W260"] / subData$signal[subData$sensor == "H4W261"]
            subData$signal[subData$sensor == "E7W260"] <- subData$signal[subData$sensor == "E7W260"] / subData$signal[subData$sensor == "H4W261"]
            subData$signal[subData$sensor == "H4W261"] <- subData$signal[subData$sensor == "H4W261"] / subData$signal[subData$sensor == "H4W261"]

            subData_NS <- subset(tData_NS, tData_NS$voltage == input$voltage)
            subData_NS <- subData_NS[with(subData_NS, order(lambda)),]
            subData_NS$signal[subData_NS$sensor == "H5W261"] <- subData_NS$signal[subData_NS$sensor == "H5W261"] / subData_NS$signal[subData_NS$sensor == "H4W261"]
            subData_NS$signal[subData_NS$sensor == "H6W261"] <- subData_NS$signal[subData_NS$sensor == "H6W261"] / subData_NS$signal[subData_NS$sensor == "H4W261"]
            subData_NS$signal[subData_NS$sensor == "H4W261"] <- subData_NS$signal[subData_NS$sensor == "H4W261"] / subData_NS$signal[subData_NS$sensor == "H4W261"]

            subData <- rbind(subData, subData_NS)
            
            plot_ly(subData, x = lambda, y = signal, color = Id)
        }
    )
    
}

shinyApp (ui = ui, server = server)