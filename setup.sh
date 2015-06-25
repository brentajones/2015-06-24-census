#!/bin/bash

echo "Creating directories"
mkdir originals

echo "Creating virtualenv"
mkvirtualenv 2015-06-24-census

echo "Installing requirements"
pip install -r requirements.txt

echo "Downloading data"
curl -L -o originals/CC-EST2014-ALLDATA-17.csv https://www.census.gov/popest/data/counties/asrh/2014/files/CC-EST2014-ALLDATA-17.csv
curl -L -o originals/CC-EST2014-ALLDATA-29.csv https://www.census.gov/popest/data/counties/asrh/2014/files/CC-EST2014-ALLDATA-29.csv