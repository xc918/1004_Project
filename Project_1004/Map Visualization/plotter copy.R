library(ggmap)
library(RgoogleMaps)
library(rgdal)
library(ggplot2)
library(plotrix)
library(classInt) 
library(dismo)
library(raster)
library(plyr)         # To manipulate data
library(lattice)      # To have Lattice graphic interface
library(sp)   
gpclibPermit()
  


setwd('~/Desktop/DS_1004_Big_Data/Project/Neighborhood Tabulation Areas/')

CenterOfMap <- geocode("New York City")
NYC <- get_map(c(-73.8549,40.755),zoom = 11, maptype = 'satellite', source = "google")
NYC <- ggmap(NYC)

NYC <- get_map(c(-73.9849,40.765),zoom = 13, maptype = 'roadmap', source = "google")
NYC <- ggmap(NYC)
NYC



NYC <- get_map(c(lon=CenterOfMap$lon[1], lat=CenterOfMap$lat[1]),zoom = 11, maptype = "toner", source = "stamen")
NYC <- ggmap(NYC)
NYC
#Baltimore <- get_map(c(lon=CenterOfMap$lon, lat=CenterOfMap$lat),zoom = 12, maptype = "toner", source = "stamen")
#BaltimoreMap <- ggmap(Baltimore)
  
dist_man_normal = read.csv('dist_man_normal.csv',col.names = c('id','man'))
dist_brok_normal = read.csv(' dist_brok_snow.csv',col.names = c('id','brok'))
dist_que_normal = read.csv(' dist_que_snow.csv',col.names = c('id','que'))

dist_brok_normal$brok = sqrt(dist_brok_normal$brok) 
dist_que_normal$que = sqrt(dist_que_normal$que)


dist_u14 = read.csv('u14.csv',col.names = c('x','id','cts'))
dist_u14$que = sqrt(dist_u14$id)


Neighborhoods <- readOGR(dsn = "." ,"geo_export_b9ed049f-9a51-476c-bbfa-739885e2831f")
Neighborhoods <- spTransform(Neighborhoods, CRS("+proj=longlat +datum=WGS84"))
Neighborhoods$id <- row.names(Neighborhoods)


temp1 = join(Neighborhoods@data,dist_u14,by = 'id')
temp1[is.na(temp1$id),'loc'] =0
Neighborhoods@data$id = temp1$loc

temp2 = join(Neighborhoods@data,dist_que_normal,by = 'id')
temp2[is.na(temp2$que),'que'] =0
Neighborhoods@data$que = temp2$que

temp3 = join(Neighborhoods@data,dist_brok_normal,by = 'id')
temp3[is.na(temp3$brok),'brok'] =0
Neighborhoods@data$brok = temp3$brok

Neighborhoods.df = fortify(Neighborhoods)
Neighborhoods.df <- join(Neighborhoods.df, Neighborhoods@data)


#BaltimoreMap <- NYC + 
                geom_polygon(aes(x=long, y=lat, group=group), fill ='grey' , size=.2,color='black', data=Neighborhoods, alpha=0.2)

pal3 <- colorRampPalette(c("white", "blue"))
              
NYC <- NYC + 
  geom_polygon(aes(x=long, y=lat, group=group ,alpha = sqrt(id)),show.legend = FALSE,fill= 'red',data=Neighborhoods.df)+
  geom_polygon(aes(x=long, y=lat, group=group ,alpha = sqrt(brok)),show.legend = FALSE,fill = 'green',data=Neighborhoods.df)+
  geom_polygon(aes(x=long, y=lat, group=group ,alpha = sqrt(que)),show.legend = FALSE,fill = 'blue',data=Neighborhoods.df)+
  geom_polygon(aes(x=long, y=lat, group=group), fill ='grey' , size=.2,color='black', data=Neighborhoods, alpha=0.2)+
  ggtitle("Pick Up Distribution")+
  theme(plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=32, hjust=0)) +
  theme(axis.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=22)) 


dist_man_normal = read.csv('pointer_man_normal.csv',col.names = c('id','to','man'))

connection = c()
place = c()
for (i in 1:nrow(dist_man_normal)){
  from = as.numeric(dist_man_normal[i,][1]+1)
  to = as.numeric(dist_man_normal[i,][2]+1)
  connection = rbind(connection,
                     c(Neighborhoods@polygons[[from]]@labpt,Neighborhoods@polygons[[to]]@labpt,
                       as.numeric(dist_man_normal[i,][3])))
  place = rbind(place,c(Neighborhoods@polygons[[from]]@labpt,as.character(Neighborhoods@data[from,'ntaname'])))
  place = rbind(place,c(Neighborhoods@polygons[[to]]@labpt,as.character(Neighborhoods@data[to,'ntaname'])))
  
  }
place = place[!duplicated(place), ]
#colnames(place) = c('x1','x2','text')
place = data.frame(x1 = as.numeric(place[,1]),x2 = as.numeric(place[,2]),text = place[,3])

connection = data.frame(x1 = connection[,1],x2 = connection[,2], y1 =  connection[,3], y2 =connection[,4],val =  connection[,5])


NYC + geom_point(data = connection,aes(x = ,data= connection))
  geom_curve(aes(x = long, y = lat, xend = long, yend = lat), data = connection)

NYC+ geom_polygon(aes(x=long, y=lat, group=group ,alpha = sqrt(man)),show.legend = FALSE,fill= 'grey',data=Neighborhoods.df)+
  geom_point(data = connection,aes(x =x1 , y =x2,size=val),color = 'blue',alpha = 0.5)+scale_size_continuous(range=c(1,10))+
  geom_point(data = connection,aes(x =y1 , y =y2,size=val),color = 'blue',alpha =0.5)+
  geom_curve(aes(x = x1, y = x2, xend = y1, yend = y2),size = val*10,  curvature = 0.26,data = connection,arrow=arrow(angle=15,ends="first",length=unit(0.4,"cm"),type="closed"))+
  coord_cartesian()+
  geom_polygon(aes(x=long, y=lat, group=group), fill ='grey' , size=.2,color='black', data=Neighborhoods, alpha=0.2)+
  geom_text(data = place, aes(x = x1, y = x2+0.003, label = as.character(text)), size=4)+
  ggtitle("Trips in Manhattan")+
  theme(plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=32, hjust=0)) +
  theme(axis.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=22))
  



