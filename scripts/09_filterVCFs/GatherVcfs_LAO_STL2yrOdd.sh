#!/bin/bash

#SBATCH --job-name=gather_chroms
#SBATCH -A beagle
#SBATCH -t 24:00:00
#SBATCH -N 1
#SBATCH -n 20
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=sparks35@purdue.edu

module purge
PROJHOME=/scratch/bell/sparks35/GL_Pink_Salmon
FILTERED=/scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/09_filterVCFs/gatk_HardFilter


## note: I leave out CM029873.1_hardfiltered_snps.vcf.gz because that is the mitochondrial scafffold
# Below commnad uses GatherVcfs to merge chromosomes into a single vcf file with all jointly called
# individuals from LAO and STL 2yrOdds. These are hard filtered SNPs only.

/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx40g " GatherVcfs \
-I $FILTERED/CM029847.1_hardfiltered_snps.vcf.gz \
-I $FILTERED/CM029848.1_hardfiltered_snps.vcf.gz \
-I $FILTERED/CM029849.1_hardfiltered_snps.vcf.gz \
-I $FILTERED/CM029850.1_hardfiltered_snps.vcf.gz \
-I $FILTERED/CM029851.1_hardfiltered_snps.vcf.gz \
-I $FILTERED/CM029852.1_hardfiltered_snps.vcf.gz \
-I $FILTERED/CM029853.1_hardfiltered_snps.vcf.gz \
-I $FILTERED/CM029854.1_hardfiltered_snps.vcf.gz \
-I $FILTERED/CM029855.1_hardfiltered_snps.vcf.gz \
-I $FILTERED/CM029856.1_hardfiltered_snps.vcf.gz \
-I $FILTERED/CM029857.1_hardfiltered_snps.vcf.gz \
-I $FILTERED/CM029858.1_hardfiltered_snps.vcf.gz \
-I $FILTERED/CM029859.1_hardfiltered_snps.vcf.gz \
-I $FILTERED/CM029860.1_hardfiltered_snps.vcf.gz \
-I $FILTERED/CM029861.1_hardfiltered_snps.vcf.gz \
-I $FILTERED/CM029862.1_hardfiltered_snps.vcf.gz \
-I $FILTERED/CM029863.1_hardfiltered_snps.vcf.gz \
-I $FILTERED/CM029864.1_hardfiltered_snps.vcf.gz \
-I $FILTERED/CM029865.1_hardfiltered_snps.vcf.gz \
-I $FILTERED/CM029866.1_hardfiltered_snps.vcf.gz \
-I $FILTERED/CM029867.1_hardfiltered_snps.vcf.gz \
-I $FILTERED/CM029868.1_hardfiltered_snps.vcf.gz \
-I $FILTERED/CM029869.1_hardfiltered_snps.vcf.gz \
-I $FILTERED/CM029870.1_hardfiltered_snps.vcf.gz \
-I $FILTERED/CM029871.1_hardfiltered_snps.vcf.gz \
-I $FILTERED/CM029872.1_hardfiltered_snps.vcf.gz \
-O $FILTERED/LAO_STL2yrOdd_hardfiltered_snps.vcf.gz



