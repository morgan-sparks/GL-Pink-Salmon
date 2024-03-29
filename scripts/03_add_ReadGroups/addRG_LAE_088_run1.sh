#!/bin/bash

#SBATCH --job-name=addreadgroups_LAE_088_run1
#SBATCH -A standby
#SBATCH -t 4:00:00
#SBATCH -N 1
#SBATCH -n 126
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=sparks35@purdue.edu

module purge
module load bioinfo
module load picard-tools/2.20.8

PROJHOME=/scratch/bell/sparks35/GL_Pink_Salmon
ALIGNED=/scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/batch_output
RGADD=/scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/addedRG_bam


java -Xmx250g -jar /group/bioinfo/apps/apps/picard-tools-2.9.0/picard.jar AddOrReplaceReadGroups \
I=$ALIGNED/LAE_088_run1_Ogor1.0_aligned.bam \
O=$RGADD/LAE_088_run1_Ogor1.0_addedRG.bam \
SORT_ORDER=coordinate RGID=group1 RGLB=lib1 RGPL=illumina RGSM=LAE_088 RGPU=run1
