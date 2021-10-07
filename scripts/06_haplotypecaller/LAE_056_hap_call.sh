#!/bin/bash
#SBATCH --job-name=hap_call_LAE_056
#SBATCH -A standby
#SBATCH -N 1
#SBATCH -n 126
#SBATCH -t 4:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=sparks35@purdue.edu

module purge
module load bioinfo
module load samtools
module load picard-tools/2.20.8

PROJHOME=/scratch/bell/sparks35/GL_Pink_Salmon/
ASSEMBLY=/scratch/bell/sparks35/GL_Pink_Salmon/data/assemblies/Ogor_1.0/GCA_017355495.1_Ogor_1.0_genomic.fna
MDUPES=/scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/mark_dupes
HAPCALLS=/scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/06_hap_calls

cd $PROJHOME/data/assemblies/Ogor_1.0/

#samtools faidx GCA_017355495.1_Ogor_1.0_genomic.fna

java -Xmx250g -jar /group/bioinfo/apps/apps/picard-tools-2.20.8/picard.jar CreateSequenceDictionary \
R=GCA_017355495.1_Ogor_1.0_genomic.fna \
O=GCA_017355495.1_Ogor_1.0_genomic.fna.dict


while read -a line
do
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx9g -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" HaplotypeCaller \
-I $MDUPES/LAE_056_Ogor1.0_dupmarked.bam \
-O $HAPCALLS/LAE_056_Ogor1.0.vcf.gz \
-R $ASSEMBLY \
-ERC GVCF \
-L ${line[0]}
done < $PROJHOME/data/seqs/aligned_reads_Ogor1.0/chromosome_list.txt 