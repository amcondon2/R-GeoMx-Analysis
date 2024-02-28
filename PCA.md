---
title: "R Notebook"
output: 
  html_document:
    keep_md: true
---




# Import Libraries

```r
library(NanoStringNCTools)
library(GeomxTools)
library(BiocSingular)

library(SpatialExperiment)
library(standR)

library(dplyr)
library(tidyverse)

library(ggplot2)
library(ggalluvial)

library(scater)
library(ggrepel)
library(ggpubr)
```

#Load Data

```r
datadir <- "data/"
DCCFiles <- dir(datadir, pattern=".dcc$", full.names=TRUE)
PKCFiles <- unzip(zipfile = file.path(datadir,  "/Mm_R_NGS_WTA_v1.0.zip"))
SampleAnnotationFile <- file.path(datadir, "ModifiedWorksheet2.xlsx")

dataSet <-
  readNanoStringGeoMxSet(dccFiles = DCCFiles,
                                          pkcFiles = PKCFiles,
                                          phenoDataFile = SampleAnnotationFile,
                                          phenoDataSheet = "Sheet1",
                                          phenoDataDccColName = "Sample_ID",
                                          protocolDataColNames = c("Roi",
                                                                   "Aoi"))

dataSet <- dataSet[,pData(dataSet)$SlideName != "No Template Control"] #remove no template control

#make spatial experiment object
dataSet_target <- aggregateCounts(dataSet)
seDataSet <- as.SpatialExperiment(dataSet_target, normData = "exprs" ,forceRaw = TRUE)

assay(seDataSet, "counts") <- assay(seDataSet, "GeoMx")
assay(seDataSet, "logcounts") <- log2(assay(seDataSet, "GeoMx") + 1)
```

#QC

```r
#Gene Level
dim(seDataSet)
```

```
## [1] 19963    72
```

```r
seDataSet <- addPerROIQC(seDataSet, rm_genes=TRUE, sample_fraction = 0.9, min_count = 5)

dim(seDataSet)
```

```
## [1] 19961    72
```

```r
metadata(seDataSet) |> names()
```

```
##  [1] "PKCFileName"       "PKCModule"         "PKCFileVersion"   
##  [4] "PKCFileDate"       "AnalyteType"       "MinArea"          
##  [7] "MinNuclei"         "shiftedByOne"      "sequencingMetrics"
## [10] "lcpm_threshold"    "genes_rm_rawCount" "genes_rm_logCPM"
```

```r
plotGeneQC(seDataSet, ordannots = "Segment", col = Segment, point_size = 2, top_n = 9)
```

![](PCA_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

```r
#ROI Level
#On RLE plots:
#https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5798764/

plotROIQC(seDataSet, x_axis="Nuclei", y_axis = "lib_size",  x_lab = "Nuclei", x_threshold = 50, color = Segment)
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

![](PCA_files/figure-html/unnamed-chunk-3-2.png)<!-- -->

```r
plotROIQC(seDataSet, x_axis="Area", y_axis = "lib_size", x_lab = "Area", color = Segment)
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

![](PCA_files/figure-html/unnamed-chunk-3-3.png)<!-- -->

```r
plotRLExpr(seDataSet, ordannots = "Segment", color = Segment, assay = 2) #counts
```

![](PCA_files/figure-html/unnamed-chunk-3-4.png)<!-- -->

```r
plotRLExpr(seDataSet, ordannots = "Segment", color = Segment, assay = 3) #logcounts
```

![](PCA_files/figure-html/unnamed-chunk-3-5.png)<!-- -->

#PCA on PanCK+ Raw Data

```r
set.seed(100)

subset <- seDataSet[, seDataSet$Segment == "PanCK+"]

subset <- scater::runPCA(subset, scale = TRUE, exprs_values = "logcounts", ncomponents = 20, BSPARAM=ExactParam(deferred=FALSE, fold=Inf)) #run PCA on log counts

pca_results <- reducedDim(subset, "PCA")

plotScreePCA(subset, precomputed = pca_results)
```

![](PCA_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

```r
#drawPCA(subset, precomputed = pca_results, col = Group)

plotPCA(subset, color_by="Group", shape_by="Sex", ncomponents=5)
```

![](PCA_files/figure-html/unnamed-chunk-4-2.png)<!-- -->

```r
  #plotPCAbiplot(subset, n_loadings = 10, precomputed = pca_results, col = Group)

#standR::plotMDS(subset, assay = 3, color = Group)


#investigate gene relation to PCs
pc_loadings <- as_tibble(attr(pca_results, "rotation"), rownames = "gene")

#https://tavareshugo.github.io/data-carpentry-rnaseq/03_rnaseq_pca.html
top_genes <- pc_loadings %>% 
  # select only the PCs we are interested in
  select(gene, PC3) %>%
  # convert to a "long" format
  pivot_longer(matches("PC"), names_to = "PC", values_to = "loading") %>% 
  # for each PC
  group_by(PC) %>% 
  # arrange by descending order of loading
  arrange(desc(abs(loading))) %>% 
  # take the 10 top rows
  slice(1:20) %>% 
  # pull the gene column as a vector
  pull(gene) %>% 
  # ensure only unique genes are retained
  unique()

dput(top_genes)
```

```
## c("Cyp2d34", "Cyp4f14", "Cyp2d26", "Saa1", "Edn3", "Slc34a2", 
## "Calcb", "Ace2", "Enpep", "Spink1", "Ifit1bl1", "Ada", "Anpep", 
## "Ces2a", "Cyp2c55", "Ly6m", "Ddx3y", "Gal3st2", "Lypd8l", "Efna3"
## )
```

```r
top_loadings <- pc_loadings %>% 
  filter(gene %in% top_genes)

pca_readable <- as_tibble(pca_results, rownames = "Sample")
pca_readable <- cbind(pca_readable, as_tibble(colData(subset)))

loadScale <- 50
ggplot() +
  geom_segment(data = top_loadings, aes(x = 0, y = 0, xend = PC1*loadScale, yend = PC3*loadScale), 
               arrow = arrow(length = unit(0.1, "in")),
               color = "brown") +
  geom_text_repel(data = top_loadings, aes(x = PC1*loadScale, y = PC3*loadScale, label = gene),
            nudge_y = 0.005, size = 3) +
  geom_point(data = pca_readable, aes(x = PC1, y = PC3, color=Group, shape=Sex, size=lib_size)) +
  scale_x_continuous(expand = c(0.02, 0.02)) +
  theme_bw() +
  #coord_fixed(ratio = 3/64) +
  xlab("PC1 (64%)") + ylab("PC3 (6%)")
```

```
## Warning: ggrepel: 9 unlabeled data points (too many overlaps). Consider
## increasing max.overlaps
```

![](PCA_files/figure-html/unnamed-chunk-4-3.png)<!-- -->

```r
plotExplanatoryVariables(subset, variables=c("Group", "Sex", "Area", "sample", "lib_size", "Nuclei"))
```

![](PCA_files/figure-html/unnamed-chunk-4-4.png)<!-- -->

```r
plotExplanatoryPCs(subset, variables=c("Group", "Sex", "Area", "sample", "lib_size", "Nuclei"),npcs_to_plot = 5)
```

![](PCA_files/figure-html/unnamed-chunk-4-5.png)<!-- -->

```r
getExplanatoryPCs(subset)
```

```
## Warning in beachmat_internal_FUN(X[[3]], ...): ignoring 'SlideName' with fewer
## than 2 unique levels
```

```
## Warning in beachmat_internal_FUN(X[[3]], ...): ignoring 'ScanName' with fewer
## than 2 unique levels
```

```
## Warning in beachmat_internal_FUN(X[[3]], ...): ignoring 'Panel' with fewer than
## 2 unique levels
```

```
## Warning in beachmat_internal_FUN(X[[3]], ...): ignoring 'Segment' with fewer
## than 2 unique levels
```

```
## Warning in beachmat_internal_FUN(X[[3]], ...): ignoring 'Tags' with fewer than
## 2 unique levels
```

```
## Warning in beachmat_internal_FUN(X[[3]], ...): ignoring 'ScanDate' with fewer
## than 2 unique levels
```

```
## Warning in beachmat_internal_FUN(X[[3]], ...): ignoring 'ScanWidth' with fewer
## than 2 unique levels
```

```
## Warning in beachmat_internal_FUN(X[[3]], ...): ignoring 'ScanHeight' with fewer
## than 2 unique levels
```

```
## Warning in beachmat_internal_FUN(X[[3]], ...): ignoring 'ScanOffsetX' with
## fewer than 2 unique levels
```

```
## Warning in beachmat_internal_FUN(X[[3]], ...): ignoring 'ScanOffsetY' with
## fewer than 2 unique levels
```

```
## Warning in beachmat_internal_FUN(X[[3]], ...): ignoring
## 'x_v1_0_MouseNGSWholeTranscriptomeAtlasRNA' with fewer than 2 unique levels
```

```
## Warning in beachmat_internal_FUN(X[[3]], ...): ignoring 'Tissue' with fewer
## than 2 unique levels
```

```
## Warning in beachmat_internal_FUN(X[[3]], ...): ignoring 'Roi' with fewer than 2
## unique levels
```

```
## Warning in beachmat_internal_FUN(X[[3]], ...): ignoring 'Aoi' with fewer than 2
## unique levels
```

```
## Warning in beachmat_internal_FUN(X[[3]], ...): ignoring 'sample_id' with fewer
## than 2 unique levels
```

```
##      SlideName ScanName Panel Segment        Area Tags       Nuclei
## PC1         NA       NA    NA      NA  0.59847500   NA 4.874747e-01
## PC2         NA       NA    NA      NA  6.82614020   NA 4.600744e-01
## PC3         NA       NA    NA      NA 29.57196147   NA 3.488641e+01
## PC4         NA       NA    NA      NA  0.01061975   NA 9.332784e-04
## PC5         NA       NA    NA      NA 20.45411416   NA 1.399690e+01
## PC6         NA       NA    NA      NA 13.81563554   NA 1.627512e+01
## PC7         NA       NA    NA      NA  4.39473427   NA 4.362930e+00
## PC8         NA       NA    NA      NA  5.60047503   NA 2.004454e+00
## PC9         NA       NA    NA      NA  3.75045057   NA 6.108039e+00
## PC10        NA       NA    NA      NA  0.70185663   NA 7.564676e+00
##      ROICoordinateX ROICoordinateY ScanDate ScanWidth ScanHeight ScanOffsetX
## PC1    33.634898779     13.4148277       NA        NA         NA          NA
## PC2     6.672070593     15.3585658       NA        NA         NA          NA
## PC3    43.068879579      0.3731212       NA        NA         NA          NA
## PC4     0.143491496      9.7714726       NA        NA         NA          NA
## PC5     2.232601615     22.0490922       NA        NA         NA          NA
## PC6     0.008008443      0.9291404       NA        NA         NA          NA
## PC7     3.981354740      9.9409532       NA        NA         NA          NA
## PC8     3.464166628      1.6396945       NA        NA         NA          NA
## PC9     0.075925706      2.9240858       NA        NA         NA          NA
## PC10    0.312773298      4.8312013       NA        NA         NA          NA
##      ScanOffsetY x_v1_0_MouseNGSWholeTranscriptomeAtlasRNA NovogeneID
## PC1           NA                                        NA        NaN
## PC2           NA                                        NA        NaN
## PC3           NA                                        NA        NaN
## PC4           NA                                        NA        NaN
## PC5           NA                                        NA        NaN
## PC6           NA                                        NA        NaN
## PC7           NA                                        NA        NaN
## PC8           NA                                        NA        NaN
## PC9           NA                                        NA        NaN
## PC10          NA                                        NA        NaN
##            Group Tissue       sample       Sex NegGeoMean_Mm_R_NGS_WTA_v1.0
## PC1  20.96958990     NA 3.842585e+01 20.814885                  86.78473363
## PC2   7.86223074     NA 7.738305e+00  6.967585                   0.05645386
## PC3  66.93903737     NA 3.706854e+01 23.155191                   0.03431177
## PC4   0.42308283     NA 2.608607e+00 13.483706                   5.63871326
## PC5   0.08703407     NA 6.258868e+00  8.139412                   0.12321967
## PC6   0.60871521     NA 1.539325e+00  2.645397                   0.17380728
## PC7   0.24460123     NA 1.154086e+00  2.223768                   1.83059420
## PC8   1.27772426     NA 5.922381e-01  2.996885                   0.06482052
## PC9   0.32568380     NA 3.185034e+00 16.556484                   0.67897798
## PC10  0.44356697     NA 2.550261e-05  1.082171                   1.82395249
##      NegGeoSD_Mm_R_NGS_WTA_v1.0 SampleID Roi Aoi sample_id     lib_size
## PC1                9.372846e+01      NaN  NA  NA        NA 8.288881e+01
## PC2                1.540539e-03      NaN  NA  NA        NA 1.733232e-01
## PC3                5.310867e-02      NaN  NA  NA        NA 2.133276e+00
## PC4                4.596311e-01      NaN  NA  NA        NA 6.001797e+00
## PC5                4.404548e-02      NaN  NA  NA        NA 3.132036e-02
## PC6                7.756995e-01      NaN  NA  NA        NA 2.448183e-01
## PC7                7.235028e-06      NaN  NA  NA        NA 3.940603e+00
## PC8                6.498621e-02      NaN  NA  NA        NA 2.203212e-01
## PC9                3.163140e-02      NaN  NA  NA        NA 1.762032e+00
## PC10               4.710196e-03      NaN  NA  NA        NA 7.060257e-04
##      countOfLowEprGene percentOfLowEprGene
## PC1         83.6490623          83.6490623
## PC2          0.8158409           0.8158409
## PC3          0.5652615           0.5652615
## PC4          2.6265116           2.6265116
## PC5          1.1024522           1.1024522
## PC6          0.2071462           0.2071462
## PC7          5.9192199           5.9192199
## PC8          0.4146984           0.4146984
## PC9          0.6750141           0.6750141
## PC10         0.3602359           0.3602359
```
# PCA on TMM Normalized Data

```r
seDataSet_tmm <- geomxNorm(seDataSet, method = "TMM")
tmmSubset <- seDataSet_tmm[, seDataSet_tmm$Segment == "PanCK+"]

plotRLExpr(seDataSet_tmm, ordannots = "Segment", color = Segment, assay = 3) #logcounts
```

![](PCA_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

```r
set.seed(100)
tmmSubset <- scater::runPCA(tmmSubset, scale = TRUE, exprs_values = "logcounts", ncomponents = 20, BSPARAM=ExactParam(deferred=FALSE, fold=Inf)) #run PCA on log counts

pca_results_tmm <- reducedDim(tmmSubset, "PCA")

plotScreePCA(tmmSubset, precomputed = pca_results_tmm)
```

![](PCA_files/figure-html/unnamed-chunk-5-2.png)<!-- -->

```r
#drawPCA(tmmSubset, precomputed = pca_results, col = Group)

plotPCA(tmmSubset, color_by="Group", shape_by="Sex", ncomponents=5)
```

![](PCA_files/figure-html/unnamed-chunk-5-3.png)<!-- -->

```r
  #plotPCAbiplot(tmmSubset, n_loadings = 10, precomputed = pca_results, col = Group)

#standR::plotMDS(tmmSubset, assay = 3, color = Group)


#investigate gene relation to PCs
pc_loadings_tmm <- as_tibble(attr(pca_results_tmm, "rotation"), rownames = "gene")

#https://tavareshugo.github.io/data-carpentry-rnaseq/03_rnaseq_pca.html
top_genes_tmm <- pc_loadings_tmm %>% 
  # select only the PCs we are interested in
  select(gene, PC1, PC4) %>%
  # convert to a "long" format
  pivot_longer(matches("PC"), names_to = "PC", values_to = "loading") %>% 
  # for each PC
  group_by(PC) %>% 
  # arrange by descending order of loading
  arrange(desc(abs(loading))) %>% 
  # take the 10 top rows
  slice(1:20) %>% 
  # pull the gene column as a vector
  pull(gene) %>% 
  # ensure only unique genes are retained
  unique()

dput(top_genes_tmm)
```

```
## c("Cutal", "Cyp4f14", "Slc3a1", "Bche", "Slc6a8", "4931406C07Rik", 
## "Slc5a1", "Tpm2", "Hpgd", "Fchsd2", "Cndp2", "Ckmt1", "Prss32", 
## "Bmp1", "Slc10a2", "Plscr4", "Slc17a5", "Aoc1", "Cd81", "Max", 
## "Gm21828", "Gm10256", "Gm21783", "Gm20792", "Gm20815", "Eif2s3y", 
## "Kdm5d", "Uty", "Duoxa2", "Duox2", "Ddx3y", "Nos2", "Oas1h", 
## "Pglyrp1", "Clca3b", "Vmn1r8", "Gpr171", "Ccl20", "Btbd35f1", 
## "Spib")
```

```r
top_loadings_tmm <- pc_loadings_tmm %>% 
  filter(gene %in% top_genes_tmm)

pca_readable_tmm <- as_tibble(pca_results_tmm, rownames = "Sample")
pca_readable_tmm <- cbind(pca_readable_tmm, as_tibble(colData(tmmSubset)))

loadScale <- 50
ggplot() +
  geom_segment(data = top_loadings_tmm, aes(x = 0, y = 0, xend = PC1*loadScale, yend = PC4*loadScale), 
               arrow = arrow(length = unit(0.1, "in")),
               color = "brown") +
  geom_text_repel(data = top_loadings_tmm, aes(x = PC1*loadScale, y = PC4*loadScale, label = gene),
            nudge_y = 0.005, size = 3) +
  geom_point(data = pca_readable_tmm, aes(x = PC1, y = PC4, color=Group, shape=Sex, size=log(lib_size))) +
  scale_x_continuous(expand = c(0.02, 0.02)) +
  theme_bw() + 
  #coord_fixed(ratio = 6/27) +
  xlab("PC1 (27%)") + ylab("PC4 (6%)")
```

```
## Warning: ggrepel: 33 unlabeled data points (too many overlaps). Consider
## increasing max.overlaps
```

![](PCA_files/figure-html/unnamed-chunk-5-4.png)<!-- -->

```r
plotExplanatoryVariables(tmmSubset, variables=c("Group", "Sex", "Area", "sample", "lib_size", "Nuclei"))
```

![](PCA_files/figure-html/unnamed-chunk-5-5.png)<!-- -->

```r
plotExplanatoryPCs(tmmSubset, variables=c("Group", "Sex", "Area", "sample", "lib_size", "Nuclei"),npcs_to_plot = 5)
```

![](PCA_files/figure-html/unnamed-chunk-5-6.png)<!-- -->

```r
tmmExplanPCs <- as_tibble(getExplanatoryPCs(tmmSubset, n_dimred = 20, variables = c("Area", "Group", "lib_size", "Nuclei", "percentOfLowEprGene", "sample", "Sex")))
tmmExplanPCs <- tmmExplanPCs %>% add_column(PC = as.numeric(row.names(tmmExplanPCs)))
tmmExplanPCs <- Filter(function(x)!all(is.na(x)), tmmExplanPCs)
colSums(tmmExplanPCs)
```

```
##                Area               Group            lib_size              Nuclei 
##            97.68858            99.93340            95.71770            99.00106 
## percentOfLowEprGene              sample                 Sex                  PC 
##            99.68315            99.97527            99.93950           210.00000
```

```r
explainPlot <- tmmExplanPCs %>% pivot_longer(cols = !PC, names_to = "variable", values_to = "percent")

p1 <- ggplot(data = explainPlot, aes(x = factor(PC), y = percent, fill = variable)) +
  geom_col(color  = "black", position = "fill") + 
  scale_y_continuous() +
  scale_x_discrete() +
  theme_bw() +
  ylab("Proportion of Variance Contained") +
  xlab("Principal Component") +
  theme(legend.position = "none")

p2 <- ggplot(data = explainPlot, aes(x = factor(PC), y = percent, fill = variable)) +
  geom_col(color  = "black") + 
  scale_y_continuous() +
  scale_x_discrete() +
  theme_bw() +
  ylab("Per-Variable Percent Variation") +
  xlab("Principal Component")

ggarrange(p1, p2, common.legend = TRUE)
```

![](PCA_files/figure-html/unnamed-chunk-5-7.png)<!-- -->
