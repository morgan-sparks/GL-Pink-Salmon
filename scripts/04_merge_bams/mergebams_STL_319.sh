#!/bin/bash

#SBATCH --job-name=mergebams_STL_319
#SBATCH -A standby
#SBATCH -t 4:00:00
#SBATCH -N 1
#SBATCH -n 126
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=sparks35@purdue.edu

module purge
module load bioinfo
module load picard-tools/2.20.8
module load samtools/1.12

PROJHOME=/scratch/bell/sparks35/GL_Pink_Salmon
ADDRG=/scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/addedRG_bam
MERGED=/scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/merged_bams


java -Xmx250g -jar /group/bioinfo/apps/apps/picard-tools-2.9.0/picard.jar MergeSamFiles \
I=$ADDRG/STL_319_run1_Ogor1.0_addedRG.bam \
I=$ADDRG/STL_319_run2_Ogor1.0_addedRG.bam \
SORT_ORDER=coordinate \
O=$MERGED/STL_319_Ogor1.0_merged.bam

samtools flagstat -@ 126 -O tsv $MERGED/STL_319_Ogor1.0_merged.bam > $MERGED/merged_flagstat/STL_319_rgroups_flagstat_out.txt
