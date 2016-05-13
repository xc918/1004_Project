#!/usr/bin/python

#import sys
import pandas as pd

print('start reading...\n')
data = pd.read_csv('yellow_tripdata_2009-01.csv')
print('finish reading!')

def RepresentsFloat(s):
    try: 
        float(s)
        return True
    except ValueError:
        return False


def get_key(line):
	pickup_location = str(line[-1])
	pickup_time = line[2]
	if len(pickup_time)>6:
		pickup_time = pickup_time[:-6].replace('-', ' ')
		pickup_time = pickup_time.split(' ')
		pickup_time = ','.join(pickup_time)
	key = ','.join([pickup_location, pickup_time])
	return key


def get_value(line):
	### get passenger count 
	passenger_count = line[4]
	if not RepresentsFloat(passenger_count):
		passenger_count = 0.

	### get trip distance
	trip_distance = line[5]
	if not RepresentsFloat(trip_distance):
		trip_distance = 0.

	### get fare amount
	fare_amount = line[13]
	if not RepresentsFloat(fare_amount):
		fare_amount = 0.

	### get surcharge
	surcharge = line[14]
	if not RepresentsFloat(surcharge):
		surcharge = 0.

	### get tip amount
	tip_amount = line[16]
	if not RepresentsFloat(tip_amount):
		tip_amount = 0.

	### get tolls amount
	tolls_amount = line[17]
	if not RepresentsFloat(tolls_amount):
		tolls_amount = 0.

	### get total amount
	total_amount = line[18]
	if not RepresentsFloat(total_amount):
		total_amount = 0.

	return [passenger_count, trip_distance, fare_amount, surcharge, tip_amount, tolls_amount, total_amount]



for i in range(1000):
	l = data.iloc[i,:].tolist()
	#if not isinstance(l[0], int):
		#continue
	#else:
	key = get_key(l)
	value = get_value(l)
	value_string = '\t'
	for v in value:
		a = '%.2f,'%(v)
		value_string = value_string+a

	value_string = value_string[:-2]
	print i, key+value_string




