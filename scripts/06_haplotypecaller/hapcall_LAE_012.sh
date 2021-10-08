#!/bin/bash

#SBATCH --job-name=hapcall_LAE_012
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
MDUPES=/scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/mark_dupes
HAPCALLS=/scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/06_hap_calls


while read -a line
do
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx9g -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" HaplotypeCaller \
-I $MDUPES/LAE_012_Ogor1.0_dupmarked.bam \
-O $HAPCALLS/${line[0]}_LAE_012_Ogor1.0.vcf.gz \
-R $ASSEMBLY \
-ERC GVCF \
-L ${line[0]} &
done < $PROJHOME/data/seqs/aligned_reads_Ogor1.0/chromosome_list.txt
wait

cd /scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/06_hap_calls

bcftools concat -Oz \
CM029847.1_LAE_012_Ogor1.0.vcf.gz CM029861.1_LAE_012_Ogor1.0.vcf.gz CM029848.1_LAE_012_Ogor1.0.vcf.gz CM029862.1_LAE_012_Ogor1.0.vcf.gz \
CM029849.1_LAE_012_Ogor1.0.vcf.gz CM029863.1_LAE_012_Ogor1.0.vcf.gz CM029850.1_LAE_012_Ogor1.0.vcf.gz CM029864.1_LAE_012_Ogor1.0.vcf.gz \
CM029851.1_LAE_012_Ogor1.0.vcf.gz CM029865.1_LAE_012_Ogor1.0.vcf.gz CM029852.1_LAE_012_Ogor1.0.vcf.gz CM029866.1_LAE_012_Ogor1.0.vcf.gz \
CM029853.1_LAE_012_Ogor1.0.vcf.gz CM029867.1_LAE_012_Ogor1.0.vcf.gz CM029854.1_LAE_012_Ogor1.0.vcf.gz CM029868.1_LAE_012_Ogor1.0.vcf.gz \
CM029855.1_LAE_012_Ogor1.0.vcf.gz CM029869.1_LAE_012_Ogor1.0.vcf.gz CM029856.1_LAE_012_Ogor1.0.vcf.gz CM029870.1_LAE_012_Ogor1.0.vcf.gz \
CM029857.1_LAE_012_Ogor1.0.vcf.gz CM029871.1_LAE_012_Ogor1.0.vcf.gz CM029858.1_LAE_012_Ogor1.0.vcf.gz CM029872.1_LAE_012_Ogor1.0.vcf.gz \
CM029859.1_LAE_012_Ogor1.0.vcf.gz CM029873.1_LAE_012_Ogor1.0.vcf.gz CM029860.1_LAE_012_Ogor1.0.vcf.gz > LAE_012_Ogor1.0_hapcalls.vcf.gz


rm -rf CM*LAE_012*
