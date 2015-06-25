#!/bin/bash

echo "Creating Directories"
mkdir temp
mkdir output

echo "Cleaning up old output"
rm temp/*
rm output/*
rm 2015-06-24-census.db

echo "Activating virtualenv"
workon 2015-06-24-census

echo "Getting region"
csvgrep -c 3 -r "071|099|113|183|510|189|219" originals/CC-EST2014-ALLDATA-29.csv > temp/mo.csv
csvgrep -c 3 -r "119|163" originals/CC-EST2014-ALLDATA-17.csv | tail -n +2 > temp/il.csv

echo "Combining files"
cat temp/mo.csv temp/il.csv > temp/region.csv

echo "Reducing file"
csvcut -c 4,5,6,7,8,35,36 temp/region.csv > temp/reduced.csv

echo "Creating database"
cat sql/data_create.sql | sqlite3 2015-06-24-census.db
echo ".import temp/reduced.csv data" | sqlite3 -csv 2015-06-24-census.db

# echo "creating population pivot table"
# cat sql/pop_pivot.sql | sqlite3 -csv 2015-06-24-census.db

echo "Running pop query"
cat sql/pop_query.sql | sqlite3 -csv -header 2015-06-24-census.db > output/pop_change.csv

echo "Running region race query"
cat sql/race_query_region.sql | sqlite3 -csv -header 2015-06-24-census.db > output/region_race.csv

echo "Running stl race query"
cat sql/race_query_stl.sql | sqlite3 -csv -header 2015-06-24-census.db > output/stl_race.csv

echo "Running stl race/age query"
cat sql/race_query_stl_age.sql | sqlite3 -csv -header 2015-06-24-census.db > output/stl_race_age.csv

echo "Running region race/age query"
cat sql/race_query_region_age.sql | sqlite3 -csv -header 2015-06-24-census.db > output/region_race_age.csv

echo "Deactivating virtualenv"
deactivate