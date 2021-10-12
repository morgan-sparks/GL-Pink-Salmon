#!/bin/bash

#SBATCH --job-name=hapcall_STL_025
#SBATCH -A standby
#SBATCH -t 4:00:00
#SBATCH -N 1
#SBATCH -n 126
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=sparks35@purdue.edu

module purge
module load bioinfo
module load bcftools/1.11
module load samtools/1.7

PROJHOME=/scratch/bell/sparks35/GL_Pink_Salmon
ASSEMBLY=/scratch/bell/sparks35/GL_Pink_Salmon/data/assemblies/Ogor_1.0/GCA_017355495.1_Ogor_1.0_genomic.fna
MDUPES=/scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/mark_dupes/spark_out
HAPCALLS=/scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/06_hap_calls


while read -a line
do
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx9g -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" HaplotypeCaller \
-I $MDUPES/STL_025_Ogor1.0_dupmarked.bam \
-O $HAPCALLS/${line[0]}_STL_025_Ogor1.0.vcf.gz \
-R $ASSEMBLY \
-ERC GVCF \
-L ${line[0]} &
done < $PROJHOME/data/seqs/aligned_reads_Ogor1.0/chromosome_list.txt
wait

