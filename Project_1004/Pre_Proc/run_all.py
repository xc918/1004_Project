import os

dash = ' | '
for year in [2009, 2010, 2011, 2012, 2013, 2014, 2015]:
	for month in range(1, 13):
		if month<10:
			month_str = '0'+str(month)
		else:
			month_str = str(month)
		file_name = 'Taxi_data/yellow_tripdata_%s-%s.csv'%(str(year), month_str)
		command_1 = 'cat ' + file_name
		command_1 = command_1 + dash
		command_2 = 'python map_test.py'
		command_2 = command_2 + dash
		command_3 = 'sort -n'
		command_3 = command_3 + dash
		command_4 = 'python reduce_test.py >> '
		output_name = 'output/%s-%s.txt'%(str(year), month_str)
		command_4 = command_4 + output_name
		command = command_1+command_2+command_3+command_4
		print command
		os.system(command)
