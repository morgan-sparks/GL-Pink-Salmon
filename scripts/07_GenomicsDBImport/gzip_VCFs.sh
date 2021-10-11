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

PROJHOME=/scratch/bell/sparks35/GL_Pink_Salmon
HAPCALLS=$PROJHOME/data/seqs/aligned_reads_Ogor1.0/06_hap_calls

while read -a line
do
bcftools view --threads 4 \
-I $HAPCALLS/${line[0]}_Ogor1.0_hapcalls.vcf.gz \
-Oz -o $HAPCALLS/${line[0]}_Ogor1.0_hapcalls.vcf.gz &
done <$PROJHOME/data/population_lists/ample_names.txt
wait
