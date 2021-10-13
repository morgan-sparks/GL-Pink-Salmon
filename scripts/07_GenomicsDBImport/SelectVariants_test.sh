#!/bin/bash

#SBATCH --job-name=SelectVariants_test
#SBATCH -A standby
#SBATCH -t 4:00:00
#SBATCH -N 1
#SBATCH -n 126
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=sparks35@purdue.edu

module purge

PROJHOME=/scratch/bell/sparks35/GL_Pink_Salmon
ASSEMBLY=/scratch/bell/sparks35/GL_Pink_Salmon/data/assemblies/Ogor_1.0/GCA_017355495.1_Ogor_1.0_genomic.fna
HAPCALLS=/scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/06_hap_calls

/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" SelectVariants \
-V $HAPCALLS/LAE_006_Ogor1.0.g.vcf.gz \
-R $ASSEMBLY \
--select-type-to-include SNP \
-O ./SelectVariantsTest.vcf
