library(ggplot2); library(patchwork); library(qqman); library(gaston)

# outlier_windows <- read.table("~/GL-Pink-Salmon/data/AFS_pogen/outlier_snps_windows.txt", sep = " ", header = TRUE)
# index <- c(1:nrow(outlier_windows))
# outlier_windows <- cbind(outlier_windows, index)
# out_starts <- outlier_windows[1:nrow(outlier_windows), c(1,2,6)]
# colnames(out_starts)[2] <- "POS"
# out_ends <- outlier_windows[1:nrow(outlier_windows), c(1,3,6)]
# colnames(out_ends)[2] <- "POS"
# outlier_windows <- rbind(out_starts, out_ends)
# outlier_windows <-cbind(outlier_windows, fakeFST = rep(5.5, nrow(outlier_windows)))
# colnames(outlier_windows)[1] <- "CHROM"

fst_persite <- read.table("~/GL-Pink-Salmon/data/AFS_pogen/LAOvsSTL2yrOdd_allSitesMAFfilt.weir.fst", sep = "\t", header = TRUE)
alt_chrom <- fst_persite$CHROM
fst_persite <- cbind(fst_persite, alt_chrom)
fst_persite$alt_chrom <- dplyr::recode(fst_persite$alt_chrom,
                           "CM029847.1" = 1,
                           "CM029848.1" = 2,
                           "CM029849.1" = 3,
                           "CM029850.1" = 4,
                           "CM029851.1" = 5,
                           "CM029852.1" = 6,
                           "CM029853.1" = 7,
                           "CM029854.1" = 8,
                           "CM029855.1" = 9,
                           "CM029856.1" = 10,
                           "CM029857.1" = 11,
                           "CM029858.1" = 12,
                           "CM029859.1" = 13,
                           "CM029860.1" = 14,
                           "CM029861.1" = 15,
                           "CM029862.1" = 16,
                           "CM029863.1" = 17,
                           "CM029864.1" = 18,
                           "CM029865.1" = 19,
                           "CM029866.1" = 20,
                           "CM029867.1" = 21,
                           "CM029868.1" = 22,
                           "CM029869.1" = 23,
                           "CM029870.1" = 24,
                           "CM029871.1" = 25,
                           "CM029872.1" = 26)

hist(fst_persite$WEIR_AND_COCKERHAM_FST, breaks = 1000, xlim = c(0.01, 1), main = "Distribution of Fst")
hist(nomissing_fst$WEIR_AND_COCKERHAM_FST, breaks = 1000, xlim = c(0.01, 1), main = "Distribution of Fst")

nomissing_fst <- na.omit(fst_persite)
nomissing_fst$Zfst <- c(NA)
final_fst <- nomissing_fst

chromosomes <- as.factor(unique(nomissing_fst$alt_chrom))
chrom.cols <- c(rep(c("#000000" , "DarkViolet"), length(chromosomes)/2))

manplot <- ggplot(nomissing_fst, aes(x = POS/1e6, y =Zfst, colour = CHROM)) +
  geom_point(size = 0.05, shape = 16)+
  facet_grid(.~alt_chrom, switch = "x") +
  scale_y_continuous(limits=c(0,7)) +
  scale_color_manual(values=chrom.cols) + 
  xlab("Chromosome")+
  ylab(bquote(paste(italic('ZF'['ST']*' ')))) +
  geom_hline(yintercept = 5, linetype = "dashed", size = 0.5, color = "dodgerblue") +
  theme_classic(base_size = 20) +
  theme(legend.position="none", # no legened
        strip.background = element_rect(colour="white", fill="white", size=1.5, linetype="solid"), #formatting for facets
        panel.spacing.x=unit(.01, "lines"),
        axis.title.x=element_blank(), # remove x axis 
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())




ggsave("~/Downloads/manplot.png", manplot, width = 20, height = 8, unit = "in" )




quantile(fst_persite$WEIR_AND_COCKERHAM_FST, 0.995, na.rm = TRUE)


                                       
ggplot(fst_persite, aes(POS, WEIR_AND_COCKERHAM_FST, color = CHROM),) +
  geom_point(size = 0.001, alpha=.1) +
  scale_color_manual(values=chrom.cols) +
  labs(x = "Position", y= "Fst") +
  theme_classic()

chr1 <- fst_persite[which(fst_persite$CHROM == "CM029847.1"),]

ggplot(chr1, aes(POS, WEIR_AND_COCKERHAM_FST)) +
  geom_point(size =0.1, alpha=.25) +
  labs(x = "Position", y= bquote(paste(italic('ZF'['ST']*' '))), title = "Chromosome 1") +
  theme_classic()

chr10 <- nomissing_fst[which(nomissing_fst$alt_chrom == 10),]

ggplot(chr10, aes(POS, Zfst)) +
  geom_point(size =0.1, alpha=.25) +
  scale_y_continuous(limits=c(0,7)) +
  labs(x = "Position", y= bquote(paste(italic('ZF'['ST']*' '))), title = "Chromosome 10") +
  theme_classic()



#### for qqman
fstsubset<-fst_persite[complete.cases(fst_persite),]
SNP<-c(1:(nrow(fstsubset)))
fstsubset <- cbind(fstsubset, SNP)

manhattan(fstsubset, chr = "alt_chrom", bp = "POS", p = "WEIR_AND_COCKERHAM_FST", snp="SNP", logp = FALSE)

###
ind_het<- read.table("~/GL-Pink-Salmon/data/AFS_pogen/indvidualHeterozygosity.het", sep = "\t", header = TRUE)
head(ind_het)

o.het <- (ind_het$N_SITES - ind_het$O.HOM.)/ind_het$N_SITES
e.het  <- (ind_het$N_SITES - ind_het$E.HOM.)/ind_het$N_SITES
populations <- c(rep("LakelseOdd", times = 29), rep("SteelOdd2yr", times = 30))

ind.het <- data.frame(cbind(populations, inds = ind_het$INDV, o.het, e.het))
ind.het$e.het <- as.numeric(as.character(ind.het$e.het))
ind.het$o.het <- as.numeric(as.character(ind.het$o.het))

o <- ggplot(ind.het) +
  geom_histogram(aes(x =o.het, fill = populations), bins = 50) +
  labs(x = "Observed Heterozygosity") +
  xlim(0, 0.4) +
  theme_classic()

e <- ggplot(ind.het) +
  geom_histogram(aes(x =e.het, fill = populations), bins = 50) +
  labs(x = "Expected Heterozygosity") +
  xlim(0, 0.4) +
  theme_classic()

o/e

### sliding window analysis
fst_windows <- read.table("~/GL-Pink-Salmon/data/AFS_pogen/LAO_het_100kb50kb.windowed.weir.fst", sep = "\t", header = TRUE)

fst_windows$CHROM <- dplyr::recode(fst_windows$CHROM,
                                       "CM029847.1" = 1,
                                       "CM029848.1" = 2,
                                       "CM029849.1" = 3,
                                       "CM029850.1" = 4,
                                       "CM029851.1" = 5,
                                       "CM029852.1" = 6,
                                       "CM029853.1" = 7,
                                       "CM029854.1" = 8,
                                       "CM029855.1" = 9,
                                       "CM029856.1" = 10,
                                       "CM029857.1" = 11,
                                       "CM029858.1" = 12,
                                       "CM029859.1" = 13,
                                       "CM029860.1" = 14,
                                       "CM029861.1" = 15,
                                       "CM029862.1" = 16,
                                       "CM029863.1" = 17,
                                       "CM029864.1" = 18,
                                       "CM029865.1" = 19,
                                       "CM029866.1" = 20,
                                       "CM029867.1" = 21,
                                       "CM029868.1" = 22,
                                       "CM029869.1" = 23,
                                       "CM029870.1" = 24,
                                       "CM029871.1" = 25,
                                       "CM029872.1" = 26)



fst_windows$POS <- (fst_windows[,"BIN_END"]/2)
fst_windows$Zfst <-c(NA)
final_fst <-fst_windows

chrom.list <- as.character(unique(fst_windows$CHROM))
temp.chrom <-NULL
for (c in 1:length(chrom.list)){
  c_num <- chrom.list[c]
  temp.chrom <- fst_windows[which(fst_windows$CHROM == c_num),]
  final_fst[which(final_fst$CHROM == c_num), "Zfst"] <- scale(temp.chrom$MEAN_FST)
}


ggplot(final_fst, aes(x = POS, y =Zfst, colour = as.factor(CHROM))) +
  geom_point(size = 0.75, shape = 16)+
  facet_grid(.~CHROM, switch = "x", scales = "free_x") +
  #geom_point(data = outlier_windows, aes(x = POS, y =fakeFST, group = index), color = "limegreen", size  =2, shape = 15, alpha = 0.25) +
  scale_y_continuous(limits=c(-1,11)) +
  scale_color_manual(values=chrom.cols) + 
  xlab("Chromosome")+
  ylab(bquote(paste('Z',italic('F'['ST']*' '), sep = ""))) +
  geom_hline(yintercept = 5, linetype = "dashed", size = 0.5, color = "dodgerblue") +
  theme_classic(base_size = 20) +
  theme(legend.position="none", # no legened
        strip.background = element_rect(colour="white", fill="white", size=1.5, linetype="solid"), #formatting for facets
        panel.spacing.x=unit(.1, "lines"),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())

##################################################

STL_TajD<- read.table("~/GL-Pink-Salmon/data/AFS_pogen/STL2yr_TajD_10kbWind.Tajima.D", sep = "\t", header = TRUE)

STL_TajD$CHROM <- dplyr::recode(STL_TajD$CHROM,
                                   "CM029847.1" = 1,
                                   "CM029848.1" = 2,
                                   "CM029849.1" = 3,
                                   "CM029850.1" = 4,
                                   "CM029851.1" = 5,
                                   "CM029852.1" = 6,
                                   "CM029853.1" = 7,
                                   "CM029854.1" = 8,
                                   "CM029855.1" = 9,
                                   "CM029856.1" = 10,
                                   "CM029857.1" = 11,
                                   "CM029858.1" = 12,
                                   "CM029859.1" = 13,
                                   "CM029860.1" = 14,
                                   "CM029861.1" = 15,
                                   "CM029862.1" = 16,
                                   "CM029863.1" = 17,
                                   "CM029864.1" = 18,
                                   "CM029865.1" = 19,
                                   "CM029866.1" = 20,
                                   "CM029867.1" = 21,
                                   "CM029868.1" = 22,
                                   "CM029869.1" = 23,
                                   "CM029870.1" = 24,
                                   "CM029871.1" = 25,
                                   "CM029872.1" = 26)

ggplot(STL_TajD, aes(x = BIN_START, y =TajimaD, colour = as.factor(CHROM))) +
  geom_point(size = 0.1, shape = 16) +
  facet_grid(.~CHROM, switch = "x", scales = "free_x") +
  #geom_line(data = outlier_windows, aes(x = POS, y =fakeFST, group = index), color = "limegreen", size  =2 ) +
  scale_y_continuous() +
  scale_color_manual(values=chrom.cols) + 
  xlab("Chromosome") +
  theme_classic(base_size = 20) +
  geom_hline(yintercept = -2, linetype = "dashed", size = 0.5, color = "dodgerblue") +
  theme(legend.position="none", # no legened
        strip.background = element_rect(colour="white", fill="white", size=1.5, linetype="solid"), #formatting for facets
        panel.spacing.x=unit(.1, "lines"),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())

ggplot(STL_TajD[which(STL_TajD$CHROM == 3),], aes(x = BIN_START, y =TajimaD, colour = as.factor(CHROM))) +
  geom_point(size = 0.1, shape = 16)+
  facet_grid(.~CHROM, switch = "x", scales = "free_x") +
  #geom_line(data = outlier_windows, aes(x = POS, y =fakeFST, group = index), color = "limegreen", size  =2 ) +
  scale_y_continuous() +
  scale_color_manual(values=chrom.cols) + 
  xlab("Chromosome") +
  theme_classic(base_size = 20) +
  geom_hline(yintercept = -2, linetype = "dashed", size = 0.5, color = "dodgerblue") +
  theme(legend.position="none", # no legened
        strip.background = element_rect(colour="white", fill="white", size=1.5, linetype="solid"), #formatting for facets
        panel.spacing.x=unit(.1, "lines"),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())

ggplot(STL_TajD[which(STL_TajD$CHROM == 10),], aes(x = BIN_START, y =TajimaD, colour = as.factor(CHROM))) +
  geom_point(size = 0.1, shape = 16)+
  facet_grid(.~CHROM, switch = "x", scales = "free_x") +
  #geom_line(data = outlier_windows, aes(x = POS, y =fakeFST, group = index), color = "limegreen", size  =2 ) +
  scale_y_continuous() +
  scale_color_manual(values=chrom.cols) + 
  xlab("Chromosome") +
  geom_hline(yintercept = -2, linetype = "dashed", size = 0.5, color = "dodgerblue") +
  theme_classic(base_size = 20) +
  theme(legend.position="none", # no legened
        strip.background = element_rect(colour="white", fill="white", size=1.5, linetype="solid"), #formatting for facets
        panel.spacing.x=unit(.1, "lines"),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())

ggplot(STL_TajD[which(STL_TajD$CHROM == 12),], aes(x = BIN_START, y =TajimaD, colour = as.factor(CHROM))) +
  geom_point(size = 0.1, shape = 16)+
  facet_grid(.~CHROM, switch = "x", scales = "free_x") +
  #geom_line(data = outlier_windows, aes(x = POS, y =fakeFST, group = index), color = "limegreen", size  =2 ) +
  scale_y_continuous() +
  scale_color_manual(values=chrom.cols) + 
  xlab("Chromosome") +
  theme_classic(base_size = 20) +
  theme(legend.position="none", # no legened
        strip.background = element_rect(colour="white", fill="white", size=1.5, linetype="solid"), #formatting for facets
        panel.spacing.x=unit(.1, "lines"),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())



##################################################
# Heterozygosity

LAO_het <- read.table("~/GL-Pink-Salmon/data/AFS_pogen/mafs_and_Ho_LAO.txt", sep = "\t", header = TRUE)
LAO_het <- LAO_het[-which(LAO_het$Ho == 0),]

STL_het <- read.table("~/GL-Pink-Salmon/data/AFS_pogen/mafs_and_Ho_STL.txt", sep = "\t", header = TRUE)
STL_het <- STL_het[-which(STL_het$Ho == 0),]
STL_het <- na.omit(STL_het)

step.size <- 999
LAO_window_het <- NULL
w <- 1
temp = NULL
temp.row = NULL
while (w <= nrow(LAO_het)){
  temp <- LAO_het[c(w:(w+step.size)),]
  Ho <- mean(temp$Ho)
  He <- mean(temp$He)
  MAF <- mean(temp$maf)
  
  temp.row <- cbind(w, Ho, He, MAF)
  
  LAO_window_het <- rbind(LAO_window_het, temp.row)
  
  temp.row = NULL
  
  w <- w + (step.size+1)
}

LAO_window_het <- data.frame(LAO_window_het)

step.size <- 9999
LAO_10Kwindow_het <- NULL
w <- 1
temp = NULL
temp.row = NULL
while (w <= nrow(LAO_het)){
  temp <- LAO_het[c(w:(w+step.size)),]
  Ho <- mean(temp$Ho)
  He <- mean(temp$He)
  MAF <- mean(temp$maf)
  
  temp.row <- cbind(w, Ho, He, MAF)
  
  LAO_10Kwindow_het <- rbind(LAO_10Kwindow_het, temp.row)
  
  temp.row = NULL
  
  w <- w + (step.size+1)
}

LAO_10Kwindow_het <- data.frame(LAO_10Kwindow_het)

step.size <- 999
STL_window_het <- NULL
w <- 1
temp = NULL
temp.row = NULL
while (w <= nrow(STL_het)){
  temp <- STL_het[c(w:(w+step.size)),]
  Ho <- mean(temp$Ho)
  He <- mean(temp$He)
  MAF <- mean(temp$maf)
  
  temp.row <- cbind(w, Ho, He, MAF)
  
  STL_window_het <- rbind(STL_window_het, temp.row)
  
  temp.row = NULL
  
  w <- w + (step.size+1)
}

STL_window_het <- data.frame(STL_window_het)

step.size <- 9999
STL_10Kwindow_het <- NULL
w <- 1
temp = NULL
temp.row = NULL
while (w <= nrow(STL_het)){
  temp <- STL_het[c(w:(w+step.size)),]
  Ho <- mean(temp$Ho)
  He <- mean(temp$He)
  MAF <- mean(temp$maf)
  
  temp.row <- cbind(w, Ho, He, MAF)
  
  STL_10Kwindow_het <- rbind(STL_10Kwindow_het, temp.row)
  
  temp.row = NULL
  
  w <- w + (step.size+1)
}

STL_10Kwindow_het <- data.frame(STL_10Kwindow_het)


S_het <- ggplot(STL_window_het, aes(x = w, y = Ho)) +
  geom_point(size = 1, shape = 16, alpha =0.35) +
  geom_line(data = STL_10Kwindow_het, aes(x =w, y =He), color = "dodgerblue") +
  lims(y = c(0,.5)) +
  labs(x= "Site", title = "Steel 2yr Olds") +
  theme_classic()



L_het <- ggplot(LAO_window_het, aes(x = w, y = Ho)) +
  geom_point(size = 1, shape = 16, alpha =0.35) +
  geom_line(data = LAO_10Kwindow_het, aes(x =w, y =He), color = "dodgerblue") +
  lims(y = c(0,.5)) +
  labs(x= "Site", title = "Lakelse Odd") +
  theme_classic()

het_windows_plot <- L_het / S_het

ggsave("~/Downloads/het_windows_plot.png", het_windows_plot, width = 5, height = 3.25, unit = "in", dpi = 600 )


### avg het, make sure XXX_het file hasn't removed 0s
LAO_hets <-c(He = mean(LAO_het$He), Ho = mean(LAO_het$Ho))
STL_hets <-c(He = mean(STL_het$He), Ho = mean(STL_het$Ho))

pop_hets <- rbind(LAO_hets, STL_hets)
pop_hets <- data.frame(pop_hets)
pop_hets <-tibble::rownames_to_column(pop_hets, "population")
pop_hets[,1] <- c("Lakelse Odd","Steel 2yr Odd")
pop_hets <- tidyr::gather(pop_hets, het_meas, het, He:Ho)

het.cols <- c(rep(c("dodgerblue3" , "skyblue1"), length(pop_hets)/2))

ggplot(pop_hets, aes(x = population, y = het, fill = het_meas)) +
  geom_bar(stat = "identity", position = position_dodge(width = 1)) +
  scale_fill_manual(values = het.cols) +
  ylim(0,.35) +
  labs(x = "Population", y = "Heterozygosity") +
  theme_classic(base_size = 14) +
  guides(fill=guide_legend(title="")) +
  theme(legend.position = c(0.8, 0.9))
 

######

pops_vcf <- read.vcf("data/AFS_pogen/LAO_STL2yrOdd_PASS_MAF3ind_hardfiltered_snps.vcf", convert.chr = FALSE)
ind1_vcf <- pops_vcf[1,]

chrom_pos_LAO <- data.frame(matrix(ncol = 2, nrow = nrow(LAO_het)))
temp <- NULL
temp.row <- NULL
for (i in 1:nrow(LAO_het)){
  temp <- LAO_het[i,]
  j <- temp[, "locus"] 
  chr <- pops_vcf[,j]@snps[,"chr"]
  pos <- pops_vcf[,j]@snps[, "pos"]
  temp.row <- cbind(chr, pos)
  chrom_pos_LAO[i,] <- temp.row
  
  if( i%%50000 == 0){
    print(paste("Finished locus ", i))
    Sys.time()
  }
  
}
