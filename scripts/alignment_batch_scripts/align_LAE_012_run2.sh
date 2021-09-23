#!/bin/bash

#SBATCH --job-name=align_LAE_012_run2
#SBATCH -A standby
#SBATCH -t 4:00:00
#SBATCH -N 10

module purge
module load bioinfo
module load bwa/0.7.17

cd $PROJHOME/data/seqs/aligned_reads_Ogor1.0/

bwa mem -t 10 -M $PROJHOME/data/assemblies/Ogor_1.0/GCA_017355495.1_Ogor_1.0_genomic.fna $PROJHOME/data/seqs/trimmed_seqs/trimmed_paired_LAE_012_R1_run2.fastq $PROJHOME/data/seqs/trimmed_seqs/trimmed_paired_LAE_012_R2_run2.fastq > $PROJHOME/data/seqs/aligned_reads_Ogor1.0/batch_output/LAE_012_run2_Ogor1.0_aligned.sam
