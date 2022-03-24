#!/usr/bin/env bash


RAW_DATA_DIR=raw/X201SC22012366-Z01-F001/raw_data/

echo "Merging fastq files..."
cat $RAW_DATA_DIR/STR*/*/fastq_pass/*.fastq.gz > data/str/str.fastq.gz
cat $RAW_DATA_DIR/TH*/*/fastq_pass/*.fastq.gz > data/th/th.fastq.gz


echo "Copying sequencing summary files..."

for SEQ_SUM_PATH in $(find -name "sequencing_summary_*")
do
    SUFF=$(basename $(dirname $SEQ_SUM_PATH))
    PREF=$(basename $(dirname $(dirname $SEQ_SUM_PATH)))

    DEST_PATH="data/sequencing-summaries/$PREF-$SUFF/"
    mkdir -p "$DEST_PATH"
    cp "$SEQ_SUM_PATH" "$DEST_PATH/sequencing_summary.txt"
done
