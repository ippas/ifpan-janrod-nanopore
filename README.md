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
`preprocessing/merge_fastq_copy_summary_to_data.sh`


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
