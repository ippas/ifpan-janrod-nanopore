#!/usr/bin/env bash


RAW_DATA_DIR=raw/X201SC22012366-Z01-F001/raw_data/

echo "Merging fastq files..."
cat $RAW_DATA_DIR/STR*/*/fastq_pass/*.fastq.gz > data/str/str.fastq.gz
cat $RAW_DATA_DIR/TH*/*/fastq_pass/*.fastq.gz > data/th/th.fastq.gz


echo "Merging sequencing summary files..."
SEQ_SUM_FILE=$RAW_DATA_DIR/STR_7566/20220224_1416_5C_PAK53731_3f1a4734/sequencing_summary_PAK53731_51d07536_barcode45.txt

STR_DIR=data/str/
TH_DIR=data/th/

head -n 1 $SEQ_SUM_FILE > $STR_DIR/sequencing_summary.txt
tail -n +2 -q $RAW_DATA_DIR/STR*/*/sequencing_*.txt >> $STR_DIR/sequencing_summary.txt

head -n 1 $SEQ_SUM_FILE > $TH_DIR/sequencing_summary.txt
tail -n +2 -q $RAW_DATA_DIR/TH*/*/sequencing_*.txt >> $TH_DIR/sequencing_summary.txt
