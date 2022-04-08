"""Annotate abundant transcripts with their positon in the genome and select
proper transcript end."""

import pandas as pd
import numpy as np


# ensmust-genes.tsv is downloaded from the BioMart website:
# http://nov2020.archive.ensembl.org/biomart/martview/8f49fc0ccfd5a16046a5a8177
# 512dc11?VIRTUALSCHEMANAME=default&ATTRIBUTES=mmusculus_gene_ensembl.default.f
# eature_page.ensembl_gene_id|mmusculus_gene_ensembl.default.feature_page.ensem
# bl_transcript_id_version|mmusculus_gene_ensembl.default.feature_page.strand|m
# musculus_gene_ensembl.default.feature_page.transcript_start|mmusculus_gene_en
# sembl.default.feature_page.transcript_end|mmusculus_gene_ensembl.default.feat
# ure_page.chromosome_name|mmusculus_gene_ensembl.default.feature_page.external
# _gene_name&FILTERS=&VISIBLEPANEL=attributepanel
df = pd.read_csv('raw/ensmust-genes.tsv', sep='\t')
df = df.drop(columns=['Gene stable ID'])
df = df.rename(
    columns={
        'Chromosome/scaffold name': 'chr',
        'Gene name': 'gene_name',
        'Transcript stable ID version': 'transcript_name'
    }
)
nc_str = pd.read_csv('data/str/str-cdna-transcript_counts.tsv', sep='\t')
nc_th = pd.read_csv('data/th/th-cdna-transcript_counts.tsv', sep='\t')

df_str = df.merge(
    nc_str,
    on='transcript_name',
    how='right',
)

str_peaks = df_str.loc[df_str['tpm'] > 2, :].copy()
str_peaks['end'] = np.where(
    str_peaks['Strand'] == 1,
    str_peaks['Transcript end (bp)'],
    str_peaks['Transcript start (bp)']
)
str_peaks = str_peaks.drop(
    columns=['Transcript start (bp)', 'Transcript end (bp)', 'Strand', 'raw']
)
patches = str_peaks['chr'].str.match('^(CHR_|JH|GL)')
str_peaks = str_peaks.loc[~patches, :]

str_peaks.to_csv('results/mateusz/str-cdna-peaks.csv', index=False)


goi = [
    'Egr1', 'Egr2', 'Egr3', 'Egr4', 'Fkbp5', 'Junb', 'Fos', 'Fosb', 'Sgk1',
    'Homer1', 
]
