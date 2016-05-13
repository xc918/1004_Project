library(maptools)
library(ggplot2)
gpclibPermit() 
## [1] TRUE 
#worldmap <- readShapeSpatial("nyct2010.shp") 
file<- readShapePoly(file.choose())

worldmap <- fortify(file) 

worldmap2 <- worldmap[seq(1, nrow(worldmap), .2), ] 
head(worldmap)

cor = read.csv('/Users/XingCui/Desktop/DS_1004_Big_Data/Project/NYC_b/ly.csv')
pickup_long = cor$start_lng
#pickup_long = abs(pickup_long*10000)
pickup_lat = cor$start_lat
#pickup_lat = pickup_lat*10000
count = cor$Counts


#pickup = query("SELECT * FROM trips_by_lat_long_cab_type ORDER BY count")

alpha_range = c(0.14, 0.75)
size_range = c(0.134, 0.173)

ggplot() + 
  geom_polygon(data = worldmap2, aes(x = long, y = lat, group = group),colour = "#0000FF",fill = '#080808')+
  #geom_path(colour = "#0000FF")
  #theme(panel.background = element_rect(fill = "lightsteelblue2", colour = "white"),
  #panel.grid.major = element_line(colour = "#080808")) 

  geom_point(data = cor,
           aes(x = pickup_long, y = pickup_lat, alpha = count, size = count,color = "#FF0000",fill = '#0000FF'))#

  #scale_alpha_continuous(range = alpha_range, trans = "log") +
  #scale_size_continuous(range = size_range, trans = "log") +
  #scale_color_manual(values = c("#ffffff", green_hex)) +
  coord_map(xlim = range(worldmap2$long), ylim = range(worldmap2$lat)) 
  #theme_dark_map() +
  theme(legend.position = "none")

  
  
  

  
fname = "graphs/taxi_pickups_map_hires.png"
png(filename = fname, width = 2880, height = 4068, bg = "black")
print(p)
dev.off()