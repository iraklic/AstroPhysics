#(rH4W261, 360)
#(rC7W270, 385)
#(rE7W260, 390)
#(rH9W261, 300)
#(rH5W261, 400)
#(rH6W261, 340)

library(plotly)

source("sensDataReader.R")

# BLUE

#100 ns signal pulse
# b1 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Blue/H4W261/2016-03-15/")
# b2 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Blue/C7W260/2016-04-14/")
# b3 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Blue/E7W260/2016-04-14/")
# b4 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Blue/H9W261/2016-04-14/")
# b5 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Blue/H5W261/2016-05-11/", "NS")
# b6 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Blue/H6W261/2016-05-11/", "NS")
# b7 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Blue/H4W261/2016-05-19/", "NS")

#50 ns signal pulse
b1 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Blue/50/H4W261/2016-08-31/")
b2 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Blue/50/H5W261/2016-08-31/")
b3 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Blue/50/H9W261/")

print("BLUE DONE")

# RED
# r1 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Red/H4W261/2016-03-30/")
# r2 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Red/C7W260/2016-04-14/")
# r3 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Red/E7W260/2016-04-14/")
# r4 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Red/H9W261/2016-04-14/")
# r5 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Red/H5W261/2016-05-11/", "NS")
# r6 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Red/H6W261/2016-05-11/", "NS")
# r7 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Red/H4W261/2016-05-19/", "NS")

r1 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Red/50/H4W261/2016-08-31/")
r2 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Red/50/H5W261/")
r3 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Red/50/H9W261/2016-08-31/")

print("RED DONE")

#GREEN
# g1 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Green/H4W261/2016-03-31/")
# g2 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Green/C7W260/2016-04-14/")
# g3 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Green/E7W260/2016-04-14/")
# g4 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Green/H9W261/2016-04-14/")
# g5 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Green/H5W261/2016-05-11/", "NS")
# g6 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Green/H6W261/2016-05-11/", "NS")
# g7 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Green/H4W261/2016-05-19/", "NS")

g1 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Green/50/H4W261/2016-08-31/")
g2 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Green/50/H5W261/2016-08-31/")
g3 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Green/50/H9W261/")

print("GREEN DONE")

#YELLOW
# y1 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Yellow/H4W261/2016-04-04/")
# y2 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Yellow/C7W260/2016-04-14/")
# y3 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Yellow/E7W260/2016-04-14/")
# y4 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Yellow/H9W261/2016-04-14/")
# y5 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Yellow/H5W261/2016-05-11/", "NS")
# y6 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Yellow/H6W261/2016-05-11/", "NS")
# y7 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Yellow/H4W261/2016-05-19/", "NS")

y1 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Yellow/50/H4W261/2016-08-31/")
y2 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Yellow/50/H5W261/2016-08-31/")
y3 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/Yellow/50/H9W261/")

print("YELLOW DONE")

#UV
# u1 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/UV/H4W261/2016-04-07/")
# u2 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/UV/C7W260/")
# u3 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/UV/E7W260/")
# u4 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/UV/H9W261/")
# u5 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/UV/H5W261/2016-05-11/", "NS")
# u6 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/UV/H6W261/2016-05-11/", "NS")
# u7 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/UV/H4W261/2016-05-19/", "NS")

u1 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/UV/50/H4W261/2016-08-31/")
u2 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/UV/50/H5W261/2016-08-31/")
u3 <- sensDataReader("../../../Dropbox/ImagingLab/Irakli/SensorTesting/Data/UV/50/H9W261/2016-08-31/")

print("UV DONE")
# ----------------------------------------------


# tData <- rbind(r1, r2, r3, r4, r5, r6, r7, b1, b2, b3, b4, b5, b6, b7, g1, g2, g3, g4, g5, g6, g7, y1, y2, y3, y4, y5, y6, y7, u1, u2, u3, u4, u5, u6, u7)
tData <- rbind(r1, r2, r3, b1, b2, b3, g1, g2, g3, y1, y2, y3, u1, u2, u3)

#tData <- tData[order(tData$sensor, tData$LED, tData$voltage), ]

p <- moneyPlots(tData)