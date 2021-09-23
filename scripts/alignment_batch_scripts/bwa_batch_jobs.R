#=============================================================================================================#
# Script created by Morgan Sparjs
# This script: uses 2 loops to write out job submission files itetating over samples names and runs for 
# bwa mem
# Usage notes: 
#============================================================================================================#


setwd("~/GL-Pink-Salmon/scripts/alignment_batch_scripts/")

file_names <- read.table("~/GL-Pink-Salmon/data/sample_names.txt", sep ="\r", header = FALSE)
file_names <- as.vector(as.character(file_names[,1]))

runs <- c("run1", "run2")

for(z in 1:length(runs)){ #iterate over run1 and run2
  z <- noquote(runs[z])
  for(x in 1:2){ # iterate over file names
  x <- noquote(file_names[x])

  file_1 <- rbind(
    "#!/bin/bash",
    "",
    paste("#SBATCH --job-name=align_", x,"_", z, sep = ""),
    "#SBATCH -A standby",
    "#SBATCH -t 4:00:00",
    "#SBATCH -N 10",
    "",
    "module purge",
    "module load bioinfo",
    "module load bwa/0.7.17",
    "",
    "cd $PROJHOME/data/seqs/aligned_reads_Ogor1.0/",
    "",
    paste("bwa mem -t 10 -M $PROJHOME/data/assemblies/Ogor_1.0/GCA_017355495.1_Ogor_1.0_genomic.fna $PROJHOME/data/seqs/trimmed_seqs/trimmed_paired_",x,"_R1_",z,".fastq"," ","$PROJHOME/data/seqs/trimmed_seqs/trimmed_paired_",x,"_R2_",z,".fastq"," ","> $PROJHOME/data/seqs/aligned_reads_Ogor1.0/batch_output/",x,"_",z,"_Ogor1.0_aligned.sam", sep = "")
    )
  
  writeLines(file_1, paste("align_",x,"_",z,".sh", sep = ""))
  }
}



