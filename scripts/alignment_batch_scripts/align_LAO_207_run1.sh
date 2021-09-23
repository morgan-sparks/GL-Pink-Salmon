#!/bin/bash

#SBATCH --job-name=align_LAO_207_run1
#SBATCH -A standby
#SBATCH -t 4:00:00
#SBATCH -N 1
#SBATCH -n 126

module purge
module load bioinfo
module load bwa/0.7.17

PROJHOME=/scratch/bell/sparks35/GL_Pink_Salmon

cd $PROJHOME/data/seqs/aligned_reads_Ogor1.0/

bwa mem -t 126 -M $PROJHOME/data/assemblies/Ogor_1.0/GCA_017355495.1_Ogor_1.0_genomic.fna $PROJHOME/data/seqs/trimmed_seqs/trimmed_paired_LAO_207_R1_run1.fastq $PROJHOME/data/seqs/trimmed_seqs/trimmed_paired_LAO_207_R2_run1.fastq > $PROJHOME/data/seqs/aligned_reads_Ogor1.0/batch_output/LAO_207_run1_Ogor1.0_aligned.sam
