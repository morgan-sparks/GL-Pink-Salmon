#!/bin/bash
#SBATCH --job-name=align_reads
#SBATCH -A beagle
#SBATCH -N 1
#SBATCH -n 20
#SBATCH -t 300:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=sparks35@purdue.edu

cd $SLURM_SUBMIT_DIR
module purge
module load bioinfo
module load bwa/0.7.17 #bwa version 0.7.17

# create objects for directories

PROJHOME=/scratch/bell/sparks35/GL_Pink_Salmon



while read -a line
do
  bwa mem -t 20 -M $PROJHOME/data/assemblies/Ogor_1.0/GCA_017355495.1_Ogor_1.0_genomic.fna \
  $PROJHOME/data/seqs/trimmed_seqs/trimmed_paired_${line[0]}_R1_run1.fastq \ 
  $PROJHOME/data/seqs/trimmed_seqs/trimmed_paired_${line[0]}_R2_run1.fastq \
  > $PROJHOME/data/seqs/aligned_reads_Ogor1.0/${line[0]}_run1_Ogor1.0_aligned.bam
  
  bwa mem -t 20 -M $PROJHOME/data/assemblies/Ogor_1.0/GCA_017355495.1_Ogor_1.0_genomic.fna \
  $PROJHOME/data/seqs/trimmed_seqs/trimmed_paired_${line[0]}_R1_run2.fastq \ 
  $PROJHOME/data/seqs/trimmed_seqs/trimmed_paired_${line[0]}_R2_run2.fastq \
  > $PROJHOME/data/seqs/aligned_reads_Ogor1.0/${line[0]}_run2_Ogor1.0_aligned.bam

done < $PROJHOME/data/sample_names.txt

