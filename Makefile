.PHONY : fetch_all, clean
objects = data/rail_accidents.csv.gz

fetch_all : $(objects)
	echo all objects fetched

clean :
	rm $(objects)

data/rail_accidents.csv.gz :
	curl "https://data.transportation.gov/api/views/85tf-25kj/rows.csv?accessType=DOWNLOAD" | gzip > data/rail_accidents.csv.gz
