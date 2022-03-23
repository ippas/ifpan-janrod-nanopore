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

    # Create new dir inside for MinIONQC - it overwrites duplicated directories
    SUFF=$(basename -- "$SAMPLE_DATA_PATH")
    PREF=$(basename -- $(dirname "$SAMPLE_DATA_PATH"))
    mkdir -p "$SAMPLE_DATA_PATH/$PREF-$SUFF"

    echo "Merging $MERGED_FASTQ_FILE..."
    cat "$FASTQ_PASS_DIR"/* > "$SAMPLE_DATA_PATH/$MERGED_FASTQ_FILE"

    echo "Copying summary files..."
    cp "$SAMPLE_PATH/"/final_summary_*.txt \
        "$SAMPLE_DATA_PATH/$PREF-$SUFF/final_summary.txt"
    cp "$SAMPLE_PATH"/sequencing_summary_*.txt \
        "$SAMPLE_DATA_PATH/$PREF-$SUFF/sequencing_summary.txt"
    echo
done
