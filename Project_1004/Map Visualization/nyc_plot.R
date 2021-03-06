library(plyr)         # To manipulate data
library(ggplot2)      # To have ggplot2 graphic interface
library(lattice)      # To have Lattice graphic interface
library(sp)
library(rgdal)        # To load "shapefiles" into R and use in conversions of spatial formats 
library(rgeos)        # To use in geometrical operations
library(spatstat)     # To use with Voronoi Tesselation
library(sp)           # Methods for retrieving coordinates from spatial objects.
library(maptools)     # A package for building maps
library(maps)         # A package for building maps
library(RColorBrewer) # To build RColorBrewer color palettes
library(grDevices)    # To build grDevices color palettes
library(reshape2)     # To have more flexibility when transforming data
library(rCharts)      # To create and customize interactive javascript visualizations in R
library(knitr)        # For dynamic report generation in R
library(base64enc)    # Tools for base64 encoding
suppressPackageStartupMessages(library(googleVis)) # To use with Google visualization in R


setwd('/Users/XingCui/Desktop/DS_1004_Big_Data/Project/Neighborhood Tabulation Areas/')
norway2 <- readOGR(dsn = "." ,"geo_export_b9ed049f-9a51-476c-bbfa-739885e2831f")
norway2_data <- norway2@data
str(norway2_data); head(norway2_data)

d <- norway2_data$ntaname
e <- rnorm(length(norway2_data$ntaname),1)
name3 <- c("NAME_1", "Churn")
dt2 <- as.data.frame(cbind(d, e), stringsAsFactors=TRUE) 
dt2$e <- as.numeric(dt2$e); colnames(dt2) <- name3; churn <- dt2

IDs <- dt2$NAME_1#used to be dt2$d
norway3_new <- unionSpatialPolygons(norway2, IDs)
norway4_new <- SpatialPolygonsDataFrame(norway3_new, churn) 

pal2 <- colorRampPalette(c("white", "blue"))
# Remove the plot frame
trellis.par.set(axis.line=list(col=NA))
# Plot the regions with Lattice
spplot(norway4_new, "Churn", main="Churn Rate per Norwegian Region (Fylke)", 
       lwd=.4, col="white", col.regions=pal2(19), colorkey = FALSE, bty="n")

library(ggmap)
CenterOfMap <- geocode("New York")
Baltimore <- get_map(c(lon=CenterOfMap$lon, lat=CenterOfMap$lat),zoom = 11, maptype = "terrain", source = "google")
base.map <- ggmap(Baltimore)




