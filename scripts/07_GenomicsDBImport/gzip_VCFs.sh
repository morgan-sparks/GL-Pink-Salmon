#!/bin/bash
#SBATCH --job-name=index_VCFs
#SBATCH -A standby
#SBATCH -N 1
#SBATCH -n 126
#SBATCH -t 4:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=sparks35@purdue.edu

module purgue
module load bioinfo
module load bcftools/1.11
module load sa

PROJHOME=/scratch/bell/sparks35/GL_Pink_Salmon
HAPCALLS=$PROJHOME/data/seqs/aligned_reads_Ogor1.0/06_hap_calls

while read -a line
do
bgzip -d --threads 4 $HAPCALLS/${line[0]}_Ogor1.0_hapcalls.vcf.gz &
done <$PROJHOME/data/population_lists/sample_names.txt
wait



