library(plotly)

green <- read.csv("Spectra Measurement/green.csv")
dgreen <- read.csv("Spectra Measurement/green_Dark.csv")
rgreen <- read.csv("Spectra Measurement/green_ref.csv")

green$Average <- green$Average - dgreen$Average
green$LED <- "Green"

red <- read.csv("Spectra Measurement/red.csv")
dred <- read.csv("Spectra Measurement/red_Dark.csv")
rred <- read.csv("Spectra Measurement/red_ref.csv")

red$Average <- red$Average - dred$Average
red$LED <- "Red"

yellow <- read.csv("Spectra Measurement/yellow.csv")
dyellow <- read.csv("Spectra Measurement/yellow_Dark.csv")
ryellow <- read.csv("Spectra Measurement/yellow_ref.csv")

yellow$Average <- yellow$Average - dyellow$Average
yellow$LED <- "Yellow"

blue <- read.csv("Spectra Measurement/blue.csv")
dblue <- read.csv("Spectra Measurement/blue_Dark.csv")
rblue <- read.csv("Spectra Measurement/blue_ref.csv")

blue$Average <- blue$Average - dblue$Average
blue$LED <- "Blue"

uv <- read.csv("Spectra Measurement/UV.csv")
duv <- read.csv("Spectra Measurement/UV_Dark.csv")
ruv <- read.csv("Spectra Measurement/UV_ref.csv")

uv$Average <- uv$Average - duv$Average
uv$LED <- "UV"

pgreen <- plot_ly(green, x = Wavelength.nm., y = Average, marker = list(color = "green"), name = "Green")
pred <- add_trace(pgreen, y = red$Average, marker = list(color = "red"), name = "Red")
pyellow <- add_trace(pred, y = yellow$Average, marker = list(color = "yellow"), name = "Yellow")
pblue <- add_trace(pyellow, y = blue$Average, marker = list(color = "blue"), name = "Blue")
puv <- add_trace(pblue, y = uv$Average, marker = list(color = "purple"), name = "UV")
