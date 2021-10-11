#!/bin/bash

#SBATCH --job-name=hapcall_LAO_163
#SBATCH -A standby
#SBATCH -t 4:00:00
#SBATCH -N 1
#SBATCH -n 126
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=sparks35@purdue.edu

module purge
module load bioinfo
module load bcftools/1.11

PROJHOME=/scratch/bell/sparks35/GL_Pink_Salmon
ASSEMBLY=/scratch/bell/sparks35/GL_Pink_Salmon/data/assemblies/Ogor_1.0/GCA_017355495.1_Ogor_1.0_genomic.fna
MDUPES=/scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/mark_dupes/spark_out
HAPCALLS=/scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/06_hap_calls


while read -a line
do
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx9g -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" HaplotypeCaller \
-I $MDUPES/LAO_163_Ogor1.0_dupmarked.bam \
-O $HAPCALLS/${line[0]}_LAO_163_Ogor1.0.vcf \
-R $ASSEMBLY \
-ERC GVCF \
-L ${line[0]} &
done < $PROJHOME/data/seqs/aligned_reads_Ogor1.0/chromosome_list.txt
wait

cd /scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/06_hap_calls

bcftools concat -O \
CM029847.1_LAO_163_Ogor1.0.vcf CM029861.1_LAO_163_Ogor1.0.vcf CM029848.1_LAO_163_Ogor1.0.vcf CM029862.1_LAO_163_Ogor1.0.vcf \
CM029849.1_LAO_163_Ogor1.0.vcf CM029863.1_LAO_163_Ogor1.0.vcf CM029850.1_LAO_163_Ogor1.0.vcf CM029864.1_LAO_163_Ogor1.0.vcf \
CM029851.1_LAO_163_Ogor1.0.vcf CM029865.1_LAO_163_Ogor1.0.vcf CM029852.1_LAO_163_Ogor1.0.vcf CM029866.1_LAO_163_Ogor1.0.vcf \
CM029853.1_LAO_163_Ogor1.0.vcf CM029867.1_LAO_163_Ogor1.0.vcf CM029854.1_LAO_163_Ogor1.0.vcf CM029868.1_LAO_163_Ogor1.0.vcf \
CM029855.1_LAO_163_Ogor1.0.vcf CM029869.1_LAO_163_Ogor1.0.vcf CM029856.1_LAO_163_Ogor1.0.vcf CM029870.1_LAO_163_Ogor1.0.vcf \
CM029857.1_LAO_163_Ogor1.0.vcf CM029871.1_LAO_163_Ogor1.0.vcf CM029858.1_LAO_163_Ogor1.0.vcf CM029872.1_LAO_163_Ogor1.0.vcf \
CM029859.1_LAO_163_Ogor1.0.vcf CM029873.1_LAO_163_Ogor1.0.vcf CM029860.1_LAO_163_Ogor1.0.vcf > LAO_163_Ogor1.0_hapcalls.vcf

bcftools index LAO_163_Ogor1.0_hapcalls.vcf

rm -rf CM*LAO_163*
