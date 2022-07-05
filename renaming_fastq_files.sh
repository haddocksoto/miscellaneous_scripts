#!/usr/bin/env bash


# Renaming FASTQ files downloaded from BASESPACE 

echo 'make sure you `cd` to a directory upstream of where all the files are located'

echo 'Removing unnecesary characters'

for f in */*R1*.fastq.gz; do mv "$f" "${f%_S*.fastq.gz}_R1.fastq.gz" ; done

for f in */*R2*.fastq.gz; do mv "$f" "${f%_S*.fastq.gz}_R2.fastq.gz" ; done


echo 'getting everything to a new location'

mkdir files_to_transfer

mv */*.fastq.gz files_to_transfer

cd files_to_transfer

#remove "-" and replace with "_"

find *.fastq.gz -depth -name '*-*' \
    -execdir bash -c 'mv -- "$1" "${1//-/_}"' bash {} \;
