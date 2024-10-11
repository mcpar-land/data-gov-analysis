.mode csv

select
    "Longitude":: FLOAT long,
    "Latitude"::FLOAT lat
from read_csv('data/rail_accidents.csv.gz', all_varchar=true)
where lat is not null and lat > 24 and lat < 49 and lat != 0
and long is not null and long > -125 and long < -67 and long != 0
;
