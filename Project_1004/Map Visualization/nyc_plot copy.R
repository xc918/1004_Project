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

#uber2015
u15_new  = read.csv('u15_new.csv',col.names = c('x','ids','count'))
d <- norway2_data$ntaname
e = u15_new$count

#e = log(e+1)
#e <- rnorm(length(norway2_data$ntaname),1000)
name3 <- c("NAME_1", "Churn")
dt2 <- as.data.frame(cbind(d, e), stringsAsFactors=TRUE) 
dt2$e <- as.numeric(dt2$e); colnames(dt2) <- name3; churn <- dt2

IDs <- u15_new$ids#used to be dt2$d
norway3_new <- unionSpatialPolygons(norway2, IDs)
norway4_new <- SpatialPolygonsDataFrame(norway3_new, churn) 

pal2 <- colorRampPalette(c("linen", "Navy"))
trellis.par.set(axis.line=list(col=NA))# Remove the plot frame
spplot(norway4_new, "Churn", main="Uber 2015 Jan-Jun in NYC", # Plot the regions with Lattice
       lwd=.4, col="white", col.regions=pal2(19), as.table = TRUE,#border(outside = TRUE),
       colorkey = TRUE, scales = list(draw = TRUE), bty="n")
       #colorkey=list(space="bottom"),

###Uber 2014

u14_new  = read.csv('ub14haha.csv',col.names = c('x','y','ids','count','cc'))
d <- norway2_data$ntaname
e14 = u14_new$cc

#e = log(e+1)
#e <- rnorm(length(norway2_data$ntaname),1000)
name3 <- c("NAME_1", "Churn")
dt24 <- as.data.frame(cbind(d, e14), stringsAsFactors=TRUE) 
dt2$e14 <- as.numeric(dt24$e14); colnames(dt24) <- name3; churn4 <- dt24

IDs14 <- u14_new$ids#used to be dt2$d
norway3_new <- unionSpatialPolygons(norway2, IDs14)
norway4_new <- SpatialPolygonsDataFrame(norway3_new, churn4) 

pal2 <- colorRampPalette(c("linen", "darkorchid4"))
trellis.par.set(axis.line=list(col=NA))# Remove the plot frame
spplot(norway4_new, "Churn", main="Uber 2014 Apr-Sept in NYC", # Plot the regions with Lattice
       lwd=.4, col="white", col.regions=pal2(19), as.table = TRUE,#border(outside = TRUE),
       colorkey = TRUE, scales = list(draw = TRUE), bty="n")

###taxi average
taxi_dist  = read.csv('taxi_dist_heat_new.csv',col.names = c('ids','count'))
#q = taxi_dist$ids
d <- norway2_data$ntaname
eee = taxi_dist$count
name33 <- c("NAME_1", "Churn")
dt22 <- as.data.frame(cbind(d, eee), stringsAsFactors=TRUE) 

dt22$eee <- as.numeric(dt22$eee)

colnames(dt22) <- name33

churn <- dt22

arrow = list("SpatialPolygonsRescale", layout.north.arrow(),
             offset = c(-74.2,40.85), scale = 0.5, which = 2)
IDsss <- taxi_dist$ids#used to be dt2$d
norway33_new <- unionSpatialPolygons(norway2, IDsss)
norway44_new <- SpatialPolygonsDataFrame(norway33_new, churn) 

pal2 <- colorRampPalette(c("aliceblue", "goldenrod4"))
trellis.par.set(axis.line=list(col=NA))# Remove the plot frame
spplot(norway44_new, "Churn", main="Taxi Average in NYC", # Plot the regions with Lattice
       lwd=.4, col="white", col.regions=pal2(19), as.table = TRUE,sp.layout = list(arrow),#border(outside = TRUE),
       colorkey = TRUE, scales = list(draw = TRUE), bty="n")









library(ggmap)
CenterOfMap <- geocode("New York")
Baltimore <- get_map(c(lon=CenterOfMap$lon, lat=CenterOfMap$lat),zoom = 11, maptype = "terrain", source = "google")
base.map <- ggmap(Baltimore)




