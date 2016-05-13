import urllib2, os
import pandas as pd
import numpy as np
from geopy.geocoders import GoogleV3


data = pd.read_csv('taxi-zone-lookup.csv')
Zone_name = data['Zone'].values
Borough_name = data['Borough'].values
location_name = []
for i in range(len(Zone_name)):
	name_1 = Zone_name[i].split('/')[0]
	name_1 = name_1.replace('(', '')
	name_1 = name_1.replace(')', '')
	name_2 = Borough_name[i]
	location_name.append(name_1+', '+name_2+', '+'New York')

latitude = []
longitude = []
for loc in location_name:
	print loc
	geolocator = GoogleV3(api_key = 'AIzaSyC04pypXaLU9h7nom2hrJ-Ymgmsfp4b43Q', timeout = 10)
	location = geolocator.geocode(loc)
	latitude.append(location.latitude)
	longitude.append(location.longitude)

latitude = np.array(latitude)
longitude = np.array(longitude)

np.save('latitude', latitude)
np.save('longitude', longitude)