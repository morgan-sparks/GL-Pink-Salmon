#!/bin/bash

#SBATCH --job-name=mergebams_LAE_082
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
I=$ADDRG/LAE_082_run1_Ogor1.0_addedRG.bam \
I=$ADDRG/LAE_082_run2_Ogor1.0_addedRG.bam \
SORT_ORDER=coordinate \
O=$MERGED/LAE_082_Ogor1.0_merged.bam

samtools flagstat -@ 126 -O tsv $MERGED/LAE_082_Ogor1.0_merged.bam > $MERGED/merged_flagstat/LAE_082_rgroups_flagstat_out.txt