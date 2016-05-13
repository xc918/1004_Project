import pandas as pd 
import numpy as np 


location_ID = np.load('~/ID_list.npy')

def find_id(location, LOC = location_ID):
	distance2id = np.linalg.norm(LOC - location, axis = 1)
	ID = np.argmin(distance2id)
	return ID

for year in [2009, 2010, 2011, 2012, 2013, 2014, 2015]:
	for month in range(1, 13):
		if month<10:
			month_str = '0'+str(month)
		else:
			month_str = str(month)
		data_path = '~/Taxi_data/yellow_tripdata_%s-%s.csv'%(str(year), month_str)
		print data_path
		data = pd.read_csv(data_path)
		location_list = np.array(data.iloc[:, 5:7]) 
		ID_list = map(find_id, location_list)
		data['Location_ID'] = pd.Series(ID_list)
		data.to_csv(data_path)