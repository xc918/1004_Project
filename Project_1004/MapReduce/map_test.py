#!/usr/bin/python

import sys

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
	else:
		passenger_count = float(passenger_count)

	### get trip distance
	trip_distance = line[5]
	if not RepresentsFloat(trip_distance):
		trip_distance = 0.
	else:
		trip_distance = float(trip_distance)

	### get fare amount
	fare_amount = line[13]
	if not RepresentsFloat(fare_amount):
		fare_amount = 0.
	else:
		fare_amount = float(fare_amount)

	### get surcharge
	surcharge = line[14]
	if not RepresentsFloat(surcharge):
		surcharge = 0.
	else:
		surcharge = float(surcharge)

	### get tip amount
	tip_amount = line[16]
	if not RepresentsFloat(tip_amount):
		tip_amount = 0.
	else:
		tip_amount = float(tip_amount)

	### get tolls amount
	tolls_amount = line[17]
	if not RepresentsFloat(tolls_amount):
		tolls_amount = 0.
	else:
		tolls_amount = float(tolls_amount)

	### get total amount
	total_amount = line[18]
	if not RepresentsFloat(total_amount):
		total_amount = 0.
	else:
		total_amount = float(total_amount)

	return [passenger_count, trip_distance, fare_amount, surcharge, tip_amount, tolls_amount, total_amount]


for line in sys.stdin:
	l = line.strip().split(',')
	if l[0] == '':
		continue
	else:
		key = get_key(l)
		value = get_value(l)
		value_string = '\t'
		for v in value:
			a = '%.2f,'%(v)
			value_string = value_string+a

		value_string = value_string[:-2]
		print key+value_string




