#!/bin/bash
#SBATCH --job-name=name
#SBATCH -A beagle
#SBATCH -N 1
#SBATCH -n 20
#SBATCH -t 300:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=sparks35@purdue.edu

cd $SLURM_SUBMIT_DIR
module purge
module load bioinfo
module load trimmomatic/0.39 # version 0.39
module load fastqc/0.11.9 # version 0.11.9
module load MultiQC/1.8 # version 1.8

# create objects for directories
PROJHOME=/scratch/bell/sparks35/GL_Pink_Salmon
RAWDATA=$PROJHOME/raw_data
OUTPUT=$PROJHOME/data/seqs/trimmed_seqs
FASTQC_OUT=$OUTPUT/trimmed_fastQC/


while read -a line
do
  trimmomatic PE -phred33 -threads 20\ #### run 1 reads ###
  $RAWDATA/${line[0]}*R1*run1.fastq.gz \
  $RAWDATA/${line[0]}*R2*run1.fastq.gz \
  $OUPUT/trimmed_paired_${line[0]}_R1_run1.fastq.qz \
  $OUPUT/trimmed_unpaired_${line[0]}_R1_run1.fastq.gz \
  $OUPUT/trimmed_paired_${line[0]}_R2_run1.fastq.gz \
  $OUPUT/trimmed_unpaired_${line[0]}_R2_run1.fastq.gz \
  LEADING:20 TRAILING:20 MINLEN:30 \
  ILLUMINACLIP:/scratch/bell/sparks35/GL_Pink_Salmon/data/IUPUI_adapter.fa:2:40:10
  
  trimmomatic PE -phred33 -threads 20 \ #### run 2 reads ###
  $RAWDATA/${line[0]}*R1*run2.fastq.gz \
  $RAWDATA/${line[0]}*R2*run2.fastq.gz \
  $OUPUT/trimmed_paired_${line[0]}_R1_run2.fastq.qz \
  $OUPUT/trimmed_unpaired_${line[0]}_R1_run2.fastq.gz \
  $OUPUT/trimmed_paired_${line[0]}_R2_run2.fastq.gz \
  $OUPUT/trimmed_unpaired_${line[0]}_R2_run2.fastq.gz \
  LEADING:20 TRAILING:20 MINLEN:30 \
  ILLUMINACLIP:/scratch/bell/sparks35/GL_Pink_Salmon/data/IUPUI_adapter.fa:2:40:10
  
  fastqc -t 10 -o $FASTQC_OUT \
  trimmed_paired_${line[0]}_R1_run1.fastq.qz \
  trimmed_unpaired_${line[0]}_R1_run1.fastq.gz \
  trimmed_paired_${line[0]}_R2_run1.fastq.gz \
  trimmed_unpaired_${line[0]}_R2_run1.fastq.gz 
  
  fastqc -t 10 -o $FASTQC_OUT trimmed_paired_${line[0]}_R1_run2.fastq.qz \
  trimmed_unpaired_${line[0]}_R1_run2.fastq.gz \
  trimmed_paired_${line[0]}_R2_run2.fastq.gz \
  trimmed_unpaired_${line[0]}_R2_run2.fastq.gz 
done < $PROJHOME/data/sample_names.txt

multiqc $FASTQC_OUT
