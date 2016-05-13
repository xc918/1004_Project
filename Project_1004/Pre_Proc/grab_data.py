import urllib2, os

for year in [2009, 2010, 2011, 2012, 2013, 2014, 2015]:
	os.system('mkdir '+str(year))
	os.system('cd '+str(year))
	os.system('mkdir yellow')
	os.system('cd yellow')
	for month in range(1, 13):
		if month<10:
			month_str = '0'+str(month)
		else:
			month_str = str(month)
		os.system('wget https://storage.googleapis.com/tlc-trip-data/%s/yellow_tripdata_%s-%s.csv'%(str(year), str(year), month_str))
	os.system('cd ..')
	os.system('cd ..')
