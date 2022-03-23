#!/usr/bin/env bash


for FASTQ_PASS_DIR in $(find -type d -name fastq_pass)
do
    echo "Processing $FASTQ_PASS_DIR..."
    FILE_TEMPLATE=$(find "$FASTQ_PASS_DIR" -name "*_0\.fastq\.gz")

    SAMPLE_PATH=$(dirname "$FASTQ_PASS_DIR")
    SAMPLE_DATA_PATH=$(
        echo "$SAMPLE_PATH" \
            | sed 's/\/raw\/X201SC22012366-Z01-F001\/raw_data\//\/data\//'
    )
    MERGED_FASTQ_FILE=$(
        basename -- $(echo "$FILE_TEMPLATE" | sed 's/_0\.fastq\.gz/.fastq.gz/')
    )

    mkdir -p "$SAMPLE_DATA_PATH"

    echo "Merging $MERGED_FASTQ_FILE..."
    cat "$FASTQ_PASS_DIR"/* > "$SAMPLE_DATA_PATH/$MERGED_FASTQ_FILE"

    echo "Copying summary file..."
    cp "$SAMPLE_PATH"/sequencing_summary_*.txt \
        "$SAMPLE_DATA_PATH/sequencing_summary.txt"
    echo
done

STR_DIR=data/str/
TH_DIR=data/th/
mkdir $STR_DIR $TH_DIR

echo "Merging fastq files..."
cat data/STR*/*/*.fastq.gz > $STR_DIR/str.fastq.gz
cat data/TH*/*/*.fastq.gz > $TH_DIR/th.fastq.gz

echo "Merging sequencing summary files..."
cat data/STR*/*/sequencing_summary.txt > $STR_DIR/sequencing_summary.txt
cat data/TH*/*/sequencing_summary.txt > $TH_DIR/sequencing_summary.txt

echo "Removing tmp files..."
rm -r data/STR*
rm -r data/TH*
