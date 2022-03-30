# Nanopore Sequencing (ifpan-janrod-nanopore)

#### Project logline (technique, organism, tissue type)
Mice C57BL/6N (breeding); coronal sections

Samples:
- TH\_7570 – thalamus, female
- TH\_7566 – thalamus, male
- STR\_7570 – striatum, female
- STR\_7566 – striatum, male

Thalamus: 4 sections 200μm, isolated with a needle  
Striatum: 3 sections 200μm, a whole section


## Methods
This sections should be a description of preprocessin and analysis ready to be included in the publication


## Preprocessing
Each sample has two directories (`{date?}\_{time?}\_{position}\_{flow\_cell\_id}\_{protocol\_run\_id}`):
- 20220224\_146\_5C\_PAK53731\_3f1a4734
- 20220303\_0915\_2B\_PAK51151\_6830aff81

Each directory contains `fastq_pass` directory with fastq files (`...\_{acquisition\_run\_id}\_{nr}.fastq.gz`), e.g.:
- PAK53731\_pass\_barcode45\_51d07536\_1000.fastq.gz
- PAK53731\_pass\_barcode45\_51d07536\_1001.fastq.gz

### Organize files for an analysis
All fastq files in each group striatum and thalamus were merged.
`preprocessing/merge_fastq_copy_summary_to_data.sh`

### QC
For QC MinIOINQC v1.4.2 was used (https://github.com/roblanf/minion\_qc/releases/tag/1.4.2).
Docker container named `minion_qc` was based on r-base:4.1.3 and all needed packages were installed.
```bash
docker container exec --user "$(id -u):$(id -g)" minion_qc Rscript /home/ippas/ifpan-janrod-nanopore/preprocessing/MinIONQC-v1.4.2.R -p 8 -i /home/ippas/ifpan-janrod-nanopore/data/ -o /home/ippas/ifpan-janrod-nanopore/results/minion_qc/
```

MultiQC
```bash
docker run --name multiqc --rm -v $PWD:$PWD --user "$(id -u):$(id -g)" ewels/multiqc /home/ippas/ifpan-janrod-nanopore/results/minion_qc/ -o /home/ippas/ifpan-janrod-nanopore/results/minion_qc/
```

### Alignment
Two programs were used for read alignment. Output _sam_ files were sorted and indexed by samtools afterwards.

#### Minimap2 (v. 2.24)
(https://github.com/lh3/minimap2)

`-N 10` option is recommended by NanoCount.

```bash
minimap2 -ax splice -uf -k14 -N 10 -t 22 raw/refdata-gex-mm10-2020-A/fasta/genome.fa data/str/str.fastq.gz > data/str/str.sam
minimap2 -ax splice -uf -k14 -N 10 -t 22 raw/refdata-gex-mm10-2020-A/fasta/genome.fa data/th/th.fastq.gz > data/th/th.sam

samtools sort --threads 23 data/str/str.sam > data/str/str.bam
samtools sort --threads 23 data/th/th.sam > data/th/th.bam
samtools index data/str/str.bam
samtools index data/th/th.bam
```

#### GraphMap2 (v. 0.6.4)
(https://github.com/lbcb-sci/graphmap2)

Graphmap uses a lot memory and it wasn't possible to align a whole sample (STR or TH).
```bash
graphmap2-v0.6.4 align -x rnaseq -t 22 -r raw/refdata-gex-mm10-2020-A/fasta/genome.fa -d data/str/str-66-02.fastq.gz -o data/str/str-66-02.sam
```

## Analysis
Details of analysis

*notes: all files included in the repo need to be referenced, either in README or other .md files. The analysis has to be fully reproducible, in principle the repo should contain code + description of how to run it while data and results kept outside*

## About this template
Directories:
- _root_ - README.md, *.Rproj, general configuration files, etc.
- raw - raw data
- preprocessing - scripts
- data - useful data, created by scripts/tools/preprocessing
- analysis - analysis source code
- results - output ready to present
