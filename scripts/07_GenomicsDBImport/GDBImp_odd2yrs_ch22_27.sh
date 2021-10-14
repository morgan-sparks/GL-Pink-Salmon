#!/bin/bash
#SBATCH --job-name=GDBImp_odd2yrs_ch22_27
#SBATCH -A highmem
#SBATCH -N 1
#SBATCH -n 128
#SBATCH -t 24:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=sparks35@purdue.edu

module purge
PROJHOME=/scratch/bell/sparks35/GL_Pink_Salmon
HAPCALLS=/scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/06_hap_calls

while read -a line
do
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx128g -Xms128g" GenomicsDBImport \
-V $HAPCALLS/${line[0]}_LAO_161_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_162_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_163_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_164_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_165_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_170_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_171_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_173_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_177_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_182_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_183_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_185_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_186_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_187_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_188_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_189_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_191_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_192_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_193_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_194_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_195_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_198_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_199_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_201_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_203_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_204_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_205_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_206_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_LAO_207_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_101_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_105_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_112_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_113_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_125_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_136_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_159_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_160_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_187_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_189_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_191_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_201_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_205_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_206_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_210_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_226_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_228_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_244_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_247_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_259_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_264_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_270_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_271_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_290_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_304_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_315_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_316_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_318_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_328_Ogor1.0.g.vcf.gz \
-V $HAPCALLS/${line[0]}_STL_331_Ogor1.0.g.vcf.gz \
--genomicsdb-workspace-path $PROJHOME/data/seqs/aligned_reads_Ogor1.0/07_genomicsDB/odd_2yrs/${line[0]}_genomicsDatabase \
-L ${line[0]} \
--batch-size 30 \
--tmp-dir tmpdir \
--genomicsdb-shared-posixfs-optimizations true \
--reader-threads 4 &
done < $PROJHOME/data/seqs/aligned_reads_Ogor1.0/chromosome_list_22_27.txt
wait