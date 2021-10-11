#!/bin/bash
#SBATCH --job-name=genomicsDBImport
#SBATCH -A highmem
#SBATCH -N 1
#SBATCH -n 126
#SBATCH -t 24:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=sparks35@purdue.edu

module purge
PROJHOME=/scratch/bell/sparks35/GL_Pink_Salmon

while read -a line
do
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx36g -Xms36g -DGATK_STACKTRACE_ON_USER_EXCEPTION=true" GenomicsDBImport \
--genomicsdb-workspace-path $PROJHOME/data/seqs/aligned_reads_Ogor1.0/07_genomicsDB/${line[0]}_database \
--batch-size 50 \
-L ${line[0]} \
--sample-name-map $PROJHOME/scripts/07_GenomicsDBImport/genomicsDB2.txt \
--tmp-dir tmpdir \
--reader-threads 4 &
done < $PROJHOME/data/seqs/aligned_reads_Ogor1.0/chromosome_list.txt
wait