#=============================================================================================================#
# Script created by Morgan Sparks
# This script: uses a loop to loop file names to output a bash script that call haplotypecaller
# from GATK. The script loops through chromosomes of pink salmon to call haplotypes in a vcf file
# and then concatenates those into a single file and indexes them at the end of the script with bcftools.
# Usage notes: 
#============================================================================================================#


setwd("~/GL-Pink-Salmon/scripts/06_haplotypecaller//")

file_names <- read.table("~/GL-Pink-Salmon/data/sample_names.txt", sep ="\r", header = FALSE)
file_names <- as.vector(as.character(file_names[,1]))



for(x in c(1:length(file_names))){ # iterate over file names
  x <- noquote(file_names[x])
  
  file_1 <- rbind(
    "#!/bin/bash",
    "",
    paste("#SBATCH --job-name=hapcall_", x, sep = ""),
    "#SBATCH -A standby",
    "#SBATCH -t 4:00:00",
    "#SBATCH -N 1",
    "#SBATCH -n 126",
    "#SBATCH --mail-type=FAIL",
    "#SBATCH --mail-user=sparks35@purdue.edu",
    "",
    "module purge",
    "module load bioinfo",
    "module load bcftools/1.11",
    "",
    
    "PROJHOME=/scratch/bell/sparks35/GL_Pink_Salmon",
    "ASSEMBLY=/scratch/bell/sparks35/GL_Pink_Salmon/data/assemblies/Ogor_1.0/GCA_017355495.1_Ogor_1.0_genomic.fna",
    "MDUPES=/scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/mark_dupes/spark_out",
    "HAPCALLS=/scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/06_hap_calls",
    "",
    "",
    "while read -a line",
    "do",
    "/home/sparks35/gatk-4.2.2.0/gatk --java-options \"-Xmx9g -Djava.io.tmpdir=/scratch/bell/sparks35/tmpdir\" HaplotypeCaller \\",
    paste("-I $MDUPES/", x, "_Ogor1.0_dupmarked.bam \\", sep = ""),
    paste("-O $HAPCALLS/${line[0]}_",x, "_Ogor1.0.vcf \\", sep = ""),
    "-R $ASSEMBLY \\",
    "-ERC GVCF \\",
    "-L ${line[0]} &",
    "done < $PROJHOME/data/seqs/aligned_reads_Ogor1.0/chromosome_list.txt",
    "wait",
    "",
    
    "cd /scratch/bell/sparks35/GL_Pink_Salmon/data/seqs/aligned_reads_Ogor1.0/06_hap_calls",
    "",
    "bcftools concat -O \\",
    paste("CM029847.1_",x,"_Ogor1.0.vcf CM029861.1_",x,"_Ogor1.0.vcf CM029848.1_",x,"_Ogor1.0.vcf CM029862.1_",x,"_Ogor1.0.vcf \\", sep =""),
    paste("CM029849.1_",x,"_Ogor1.0.vcf CM029863.1_",x,"_Ogor1.0.vcf CM029850.1_",x,"_Ogor1.0.vcf CM029864.1_",x,"_Ogor1.0.vcf \\", sep =""),
    paste("CM029851.1_",x,"_Ogor1.0.vcf CM029865.1_",x,"_Ogor1.0.vcf CM029852.1_",x,"_Ogor1.0.vcf CM029866.1_",x,"_Ogor1.0.vcf \\", sep =""),
    paste("CM029853.1_",x,"_Ogor1.0.vcf CM029867.1_",x,"_Ogor1.0.vcf CM029854.1_",x,"_Ogor1.0.vcf CM029868.1_",x,"_Ogor1.0.vcf \\", sep =""),
    paste("CM029855.1_",x,"_Ogor1.0.vcf CM029869.1_",x,"_Ogor1.0.vcf CM029856.1_",x,"_Ogor1.0.vcf CM029870.1_",x,"_Ogor1.0.vcf \\", sep =""),
    paste("CM029857.1_",x,"_Ogor1.0.vcf CM029871.1_",x,"_Ogor1.0.vcf CM029858.1_",x,"_Ogor1.0.vcf CM029872.1_",x,"_Ogor1.0.vcf \\", sep =""),
    paste("CM029859.1_",x,"_Ogor1.0.vcf CM029873.1_",x,"_Ogor1.0.vcf CM029860.1_",x,"_Ogor1.0.vcf > ",x,"_Ogor1.0_hapcalls.vcf", sep =""),
    "",
    paste("bcftools index ",x,"_Ogor1.0_hapcalls.vcf", sep =""),
    "",
    paste("rm -rf CM*",x,"*", sep = "")
  )
  
  writeLines(file_1, paste("hapcall_",x,".sh", sep = ""))
}




