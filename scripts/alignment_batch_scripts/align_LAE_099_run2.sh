#!/bin/bash

#SBATCH --job-name=align_LAE_099_run2
#SBATCH -A standby
#SBATCH -t 4:00:00
#SBATCH -N 1
#SBATCH -n 126

module purge
module load bioinfo
module load bwa/0.7.17

PROJHOME=/scratch/bell/sparks35/GL_Pink_Salmon

cd $PROJHOME/data/seqs/aligned_reads_Ogor1.0/

bwa mem -t 126 -M $PROJHOME/data/assemblies/Ogor_1.0/GCA_017355495.1_Ogor_1.0_genomic.fna $PROJHOME/data/seqs/trimmed_seqs/trimmed_paired_LAE_099_R1_run2.fastq $PROJHOME/data/seqs/trimmed_seqs/trimmed_paired_LAE_099_R2_run2.fastq > $PROJHOME/data/seqs/aligned_reads_Ogor1.0/batch_output/LAE_099_run2_Ogor1.0_aligned.sam
