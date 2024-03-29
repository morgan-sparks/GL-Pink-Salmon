#!/bin/bash

#SBATCH --job-name=mergebams_batch_STL_125toSTL_191
#SBATCH -A highmem
#SBATCH -t 24:00:00
#SBATCH -N 1
#SBATCH -n 126
#SBATCH --mail-type=FAIL,END
#SBATCH --mail-user=sparks35@purdue.edu

module purge
module load bioinfo

PROJHOME=/scratch/bell/sparks35/GL_Pink_Salmon
MDUPES=/scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/mark_dupes
MERGED=/scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/merged_bams


#process 1
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx80G -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" MarkDuplicatesSpark \
-I $MERGED/STL_125_Ogor1.0_merged.bam \
-O $MDUPES/spark_out/STL_125_Ogor1.0_dupmarked.bam \
-M $MDUPES/metrics_out/STL_125_Ogor1.0_dupmarked_metrics.txt \
--conf 'spark.executor.cores=11'

#process 2
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx80G -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" MarkDuplicatesSpark \
-I $MERGED/STL_134_Ogor1.0_merged.bam \
-O $MDUPES/spark_out/STL_134_Ogor1.0_dupmarked.bam \
-M $MDUPES/metrics_out/STL_134_Ogor1.0_dupmarked_metrics.txt \
--conf 'spark.executor.cores=11'

#process 3
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx80G -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" MarkDuplicatesSpark \
-I $MERGED/STL_136_Ogor1.0_merged.bam \
-O $MDUPES/spark_out/STL_136_Ogor1.0_dupmarked.bam \
-M $MDUPES/metrics_out/STL_136_Ogor1.0_dupmarked_metrics.txt \
--conf 'spark.executor.cores=11'

#process 4
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx80G -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" MarkDuplicatesSpark \
-I $MERGED/STL_139_Ogor1.0_merged.bam \
-O $MDUPES/spark_out/STL_139_Ogor1.0_dupmarked.bam \
-M $MDUPES/metrics_out/STL_139_Ogor1.0_dupmarked_metrics.txt \
--conf 'spark.executor.cores=11'

#process 5
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx80G -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" MarkDuplicatesSpark \
-I $MERGED/STL_153_Ogor1.0_merged.bam \
-O $MDUPES/spark_out/STL_153_Ogor1.0_dupmarked.bam \
-M $MDUPES/metrics_out/STL_153_Ogor1.0_dupmarked_metrics.txt \
--conf 'spark.executor.cores=11'

#process 6
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx80G -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" MarkDuplicatesSpark \
-I $MERGED/STL_159_Ogor1.0_merged.bam \
-O $MDUPES/spark_out/STL_159_Ogor1.0_dupmarked.bam \
-M $MDUPES/metrics_out/STL_159_Ogor1.0_dupmarked_metrics.txt \
--conf 'spark.executor.cores=11'

#process 7
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx80G -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" MarkDuplicatesSpark \
-I $MERGED/STL_160_Ogor1.0_merged.bam \
-O $MDUPES/spark_out/STL_160_Ogor1.0_dupmarked.bam \
-M $MDUPES/metrics_out/STL_160_Ogor1.0_dupmarked_metrics.txt \
--conf 'spark.executor.cores=11'

#process 8
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx80G -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" MarkDuplicatesSpark \
-I $MERGED/STL_175_Ogor1.0_merged.bam \
-O $MDUPES/spark_out/STL_175_Ogor1.0_dupmarked.bam \
-M $MDUPES/metrics_out/STL_175_Ogor1.0_dupmarked_metrics.txt \
--conf 'spark.executor.cores=10'

#process 9
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx80G -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" MarkDuplicatesSpark \
-I $MERGED/STL_179_Ogor1.0_merged.bam \
-O $MDUPES/spark_out/STL_179_Ogor1.0_dupmarked.bam \
-M $MDUPES/metrics_out/STL_179_Ogor1.0_dupmarked_metrics.txt \
--conf 'spark.executor.cores=10'

#process 10
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx80G -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" MarkDuplicatesSpark \
-I $MERGED/STL_187_Ogor1.0_merged.bam \
-O $MDUPES/spark_out/STL_187_Ogor1.0_dupmarked.bam \
-M $MDUPES/metrics_out/STL_187_Ogor1.0_dupmarked_metrics.txt \
--conf 'spark.executor.cores=10'

#process 11
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx80G -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" MarkDuplicatesSpark \
-I $MERGED/STL_189_Ogor1.0_merged.bam \
-O $MDUPES/spark_out/STL_189_Ogor1.0_dupmarked.bam \
-M $MDUPES/metrics_out/STL_189_Ogor1.0_dupmarked_metrics.txt \
--conf 'spark.executor.cores=10'

#process 12
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx80G -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" MarkDuplicatesSpark \
-I $MERGED/STL_191_Ogor1.0_merged.bam \
-O $MDUPES/spark_out/STL_191_Ogor1.0_dupmarked.bam \
-M $MDUPES/metrics_out/STL_191_Ogor1.0_dupmarked_metrics.txt \
--conf 'spark.executor.cores=10'

