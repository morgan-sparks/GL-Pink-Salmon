#!/bin/bash
#SBATCH --job-name=gGVCFs_odd2yrs_ch1_7
#SBATCH -A highmem
#SBATCH -N 1
#SBATCH -n 128
#SBATCH -t 24:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=sparks35@purdue.edu

module purge
PROJHOME=/scratch/bell/sparks35/GL_Pink_Salmon
ASSEMBLY=/scratch/bell/sparks35/GL_Pink_Salmon/data/assemblies/Ogor_1.0/GCA_017355495.1_Ogor_1.0_genomic.fna
GENOMICSDB=/scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/07_genomicsDB
OUT=/scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/08_genotypeGVCFs


while read -a line
do
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx128g -Xms128g" GenotypeGVCFs \
-R $ASSEMBLY \
-V gendb://$GENOMICSDB/odd_2yrs/${line[0]}_genomicsDatabase \
-L ${line[0]} \
-O $OUT/${line[0]}.vcf.gz
done < $PROJHOME/data/seqs/aligned_reads_Ogor1.0/chromosome_list_1_7.txt
wait