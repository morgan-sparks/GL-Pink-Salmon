#!/bin/bash

#SBATCH --job-name=mergebams_batch_LAE_006toLAE_062
#SBATCH -A highmem
#SBATCH -t 24:00:00
#SBATCH -N 1
#SBATCH -n 126
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=sparks35@purdue.edu

module purge
module load bioinfo

PROJHOME=/scratch/bell/sparks35/GL_Pink_Salmon
MDUPES=/scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/mark_dupes
MERGED=/scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/merged_bams


#process 1
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx80G -DGATK_STACKTRACE_ON_USER_EXCEPTION=true -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" MarkDuplicatesSpark \
I=$MERGED/LAE_006_Ogor1.0_merged.bam \
O=$MDUPES/spark_out/LAE_006_Ogor1.0_dupmarked.bam \
M=$MDUPES/metrics_out/ LAE_006 _Ogor1.0_dupmarked_metrics.txt \
--conf 'spark.executor.cores=11'

#process 2
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx80G -DGATK_STACKTRACE_ON_USER_EXCEPTION=true -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" MarkDuplicatesSpark \
I=$MERGED/LAE_012_Ogor1.0_merged.bam \
O=$MDUPES/spark_out/LAE_012_Ogor1.0_dupmarked.bam \
M=$MDUPES/metrics_out/ LAE_012 _Ogor1.0_dupmarked_metrics.txt \
--conf 'spark.executor.cores=11'

#process 3
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx80G -DGATK_STACKTRACE_ON_USER_EXCEPTION=true -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" MarkDuplicatesSpark \
I=$MERGED/LAE_024_Ogor1.0_merged.bam \
O=$MDUPES/spark_out/LAE_024_Ogor1.0_dupmarked.bam \
M=$MDUPES/metrics_out/ LAE_024 _Ogor1.0_dupmarked_metrics.txt \
--conf 'spark.executor.cores=11'

#process 4
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx80G -DGATK_STACKTRACE_ON_USER_EXCEPTION=true -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" MarkDuplicatesSpark \
I=$MERGED/LAE_030_Ogor1.0_merged.bam \
O=$MDUPES/spark_out/LAE_030_Ogor1.0_dupmarked.bam \
M=$MDUPES/metrics_out/ LAE_030 _Ogor1.0_dupmarked_metrics.txt \
--conf 'spark.executor.cores=11'

#process 5
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx80G -DGATK_STACKTRACE_ON_USER_EXCEPTION=true -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" MarkDuplicatesSpark \
I=$MERGED/LAE_036_Ogor1.0_merged.bam \
O=$MDUPES/spark_out/LAE_036_Ogor1.0_dupmarked.bam \
M=$MDUPES/metrics_out/ LAE_036 _Ogor1.0_dupmarked_metrics.txt \
--conf 'spark.executor.cores=11'

#process 6
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx80G -DGATK_STACKTRACE_ON_USER_EXCEPTION=true -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" MarkDuplicatesSpark \
I=$MERGED/LAE_042_Ogor1.0_merged.bam \
O=$MDUPES/spark_out/LAE_042_Ogor1.0_dupmarked.bam \
M=$MDUPES/metrics_out/ LAE_042 _Ogor1.0_dupmarked_metrics.txt \
--conf 'spark.executor.cores=11'

#process 7
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx80G -DGATK_STACKTRACE_ON_USER_EXCEPTION=true -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" MarkDuplicatesSpark \
I=$MERGED/LAE_053_Ogor1.0_merged.bam \
O=$MDUPES/spark_out/LAE_053_Ogor1.0_dupmarked.bam \
M=$MDUPES/metrics_out/ LAE_053 _Ogor1.0_dupmarked_metrics.txt \
--conf 'spark.executor.cores=11'

#process 8
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx80G -DGATK_STACKTRACE_ON_USER_EXCEPTION=true -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" MarkDuplicatesSpark \
I=$MERGED/LAE_056_Ogor1.0_merged.bam \
O=$MDUPES/spark_out/LAE_056_Ogor1.0_dupmarked.bam \
M=$MDUPES/metrics_out/ LAE_056 _Ogor1.0_dupmarked_metrics.txt \
--conf 'spark.executor.cores=10'

#process 9
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx80G -DGATK_STACKTRACE_ON_USER_EXCEPTION=true -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" MarkDuplicatesSpark \
I=$MERGED/LAE_057_Ogor1.0_merged.bam \
O=$MDUPES/spark_out/LAE_057_Ogor1.0_dupmarked.bam \
M=$MDUPES/metrics_out/ LAE_057 _Ogor1.0_dupmarked_metrics.txt \
--conf 'spark.executor.cores=10'

#process 10
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx80G -DGATK_STACKTRACE_ON_USER_EXCEPTION=true -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" MarkDuplicatesSpark \
I=$MERGED/LAE_058_Ogor1.0_merged.bam \
O=$MDUPES/spark_out/LAE_058_Ogor1.0_dupmarked.bam \
M=$MDUPES/metrics_out/ LAE_058 _Ogor1.0_dupmarked_metrics.txt \
--conf 'spark.executor.cores=10'

#process 11
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx80G -DGATK_STACKTRACE_ON_USER_EXCEPTION=true -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" MarkDuplicatesSpark \
I=$MERGED/LAE_059_Ogor1.0_merged.bam \
O=$MDUPES/spark_out/LAE_059_Ogor1.0_dupmarked.bam \
M=$MDUPES/metrics_out/ LAE_059 _Ogor1.0_dupmarked_metrics.txt \
--conf 'spark.executor.cores=10'

#process 12
/home/sparks35/gatk-4.2.2.0/gatk --java-options "-Xmx80G -DGATK_STACKTRACE_ON_USER_EXCEPTION=true -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir" MarkDuplicatesSpark \
I=$MERGED/LAE_062_Ogor1.0_merged.bam \
O=$MDUPES/spark_out/LAE_062_Ogor1.0_dupmarked.bam \
M=$MDUPES/metrics_out/ LAE_062 _Ogor1.0_dupmarked_metrics.txt \
--conf 'spark.executor.cores=10'

