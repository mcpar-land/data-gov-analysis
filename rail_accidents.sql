.echo on
.maxwidth 100

select * from read_csv('data/rail_accidents.csv.gz', all_varchar=true);
