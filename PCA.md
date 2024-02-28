---
title: "R Notebook"
output:
  html_document:
    keep_md: true    
---




# Import Libraries

```
## Loading required package: Biobase
```

```
## Loading required package: BiocGenerics
```

```
## 
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
## 
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
## 
##     anyDuplicated, aperm, append, as.data.frame, basename, cbind,
##     colnames, dirname, do.call, duplicated, eval, evalq, Filter, Find,
##     get, grep, grepl, intersect, is.unsorted, lapply, Map, mapply,
##     match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     Position, rank, rbind, Reduce, rownames, sapply, setdiff, sort,
##     table, tapply, union, unique, unsplit, which.max, which.min
```

```
## Welcome to Bioconductor
## 
##     Vignettes contain introductory material; view with
##     'browseVignettes()'. To cite Bioconductor, see
##     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

```
## Loading required package: S4Vectors
```

```
## Loading required package: stats4
```

```
## 
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:utils':
## 
##     findMatches
```

```
## The following objects are masked from 'package:base':
## 
##     expand.grid, I, unname
```

```
## Loading required package: ggplot2
```

```
## Registered S3 method overwritten by 'GGally':
##   method from   
##   +.gg   ggplot2
```

```
## Loading required package: SingleCellExperiment
```

```
## Loading required package: SummarizedExperiment
```

```
## Loading required package: MatrixGenerics
```

```
## Loading required package: matrixStats
```

```
## 
## Attaching package: 'matrixStats'
```

```
## The following objects are masked from 'package:Biobase':
## 
##     anyMissing, rowMedians
```

```
## 
## Attaching package: 'MatrixGenerics'
```

```
## The following objects are masked from 'package:matrixStats':
## 
##     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
##     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
##     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
##     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
##     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
##     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
##     colWeightedMeans, colWeightedMedians, colWeightedSds,
##     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
##     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
##     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
##     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
##     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
##     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
##     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
##     rowWeightedSds, rowWeightedVars
```

```
## The following object is masked from 'package:Biobase':
## 
##     rowMedians
```

```
## Loading required package: GenomicRanges
```

```
## Loading required package: IRanges
```

```
## 
## Attaching package: 'IRanges'
```

```
## The following object is masked from 'package:grDevices':
## 
##     windows
```

```
## Loading required package: GenomeInfoDb
```

```
## 
## Attaching package: 'SingleCellExperiment'
```

```
## The following object is masked from 'package:NanoStringNCTools':
## 
##     weights<-
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:GenomicRanges':
## 
##     intersect, setdiff, union
```

```
## The following object is masked from 'package:GenomeInfoDb':
## 
##     intersect
```

```
## The following objects are masked from 'package:IRanges':
## 
##     collapse, desc, intersect, setdiff, slice, union
```

```
## The following object is masked from 'package:matrixStats':
## 
##     count
```

```
## The following object is masked from 'package:NanoStringNCTools':
## 
##     groups
```

```
## The following objects are masked from 'package:S4Vectors':
## 
##     first, intersect, rename, setdiff, setequal, union
```

```
## The following object is masked from 'package:Biobase':
## 
##     combine
```

```
## The following objects are masked from 'package:BiocGenerics':
## 
##     combine, intersect, setdiff, union
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```
## Warning: package 'tidyverse' was built under R version 4.3.2
```

```
## Warning: package 'lubridate' was built under R version 4.3.2
```

```
## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
## ✔ forcats   1.0.0     ✔ stringr   1.5.0
## ✔ lubridate 1.9.3     ✔ tibble    3.2.1
## ✔ purrr     1.0.2     ✔ tidyr     1.3.0
## ✔ readr     2.1.4
```

```
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ lubridate::%within%() masks IRanges::%within%()
## ✖ dplyr::collapse()     masks IRanges::collapse()
## ✖ dplyr::combine()      masks Biobase::combine(), BiocGenerics::combine()
## ✖ dplyr::count()        masks matrixStats::count()
## ✖ dplyr::desc()         masks IRanges::desc()
## ✖ tidyr::expand()       masks S4Vectors::expand()
## ✖ dplyr::filter()       masks stats::filter()
## ✖ dplyr::first()        masks S4Vectors::first()
## ✖ dplyr::groups()       masks NanoStringNCTools::groups()
## ✖ dplyr::lag()          masks stats::lag()
## ✖ ggplot2::Position()   masks BiocGenerics::Position(), base::Position()
## ✖ purrr::reduce()       masks GenomicRanges::reduce(), IRanges::reduce()
## ✖ dplyr::rename()       masks S4Vectors::rename()
## ✖ lubridate::second()   masks S4Vectors::second()
## ✖ lubridate::second<-() masks S4Vectors::second<-()
## ✖ dplyr::slice()        masks IRanges::slice()
## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
## Loading required package: scuttle
## 
## 
## Attaching package: 'scater'
## 
## 
## The following object is masked from 'package:standR':
## 
##     plotMDS
```

#Load Data


#QC

```
## [1] 19963    72
```

```
## [1] 19961    72
```

```
##  [1] "PKCFileName"       "PKCModule"         "PKCFileVersion"   
##  [4] "PKCFileDate"       "AnalyteType"       "MinArea"          
##  [7] "MinNuclei"         "shiftedByOne"      "sequencingMetrics"
## [10] "lcpm_threshold"    "genes_rm_rawCount" "genes_rm_logCPM"
```

![](PCA_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

```
## `geom_smooth()` using formula = 'y ~ x'
```

![](PCA_files/figure-html/unnamed-chunk-3-2.png)<!-- -->

```
## `geom_smooth()` using formula = 'y ~ x'
```

![](PCA_files/figure-html/unnamed-chunk-3-3.png)<!-- -->![](PCA_files/figure-html/unnamed-chunk-3-4.png)<!-- -->![](PCA_files/figure-html/unnamed-chunk-3-5.png)<!-- -->

#PCA on PanCK+ Raw Data

```
## Warning in (function (A, nv = 5, nu = nv, maxit = 1000, work = nv + 7, reorth =
## TRUE, : You're computing too large a percentage of total singular values, use a
## standard svd instead.
```

![](PCA_files/figure-html/unnamed-chunk-4-1.png)<!-- -->![](PCA_files/figure-html/unnamed-chunk-4-2.png)<!-- -->

```
## c("Cyp2d34", "Cyp4f14", "Cyp2d26", "Saa1", "Edn3", "Slc34a2", 
## "Calcb", "Ace2", "Enpep", "Spink1", "Ifit1bl1", "Ada", "Anpep", 
## "Ces2a", "Cyp2c55", "Ly6m", "Ddx3y", "Gal3st2", "Lypd8l", "Efna3"
## )
```

```
## Warning: ggrepel: 9 unlabeled data points (too many overlaps). Consider
## increasing max.overlaps
```

![](PCA_files/figure-html/unnamed-chunk-4-3.png)<!-- -->![](PCA_files/figure-html/unnamed-chunk-4-4.png)<!-- -->![](PCA_files/figure-html/unnamed-chunk-4-5.png)<!-- -->

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
![](PCA_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

```
## Warning in (function (A, nv = 5, nu = nv, maxit = 1000, work = nv + 7, reorth =
## TRUE, : You're computing too large a percentage of total singular values, use a
## standard svd instead.
```

![](PCA_files/figure-html/unnamed-chunk-5-2.png)<!-- -->![](PCA_files/figure-html/unnamed-chunk-5-3.png)<!-- -->

```
## c("Cutal", "Cyp4f14", "Slc3a1", "Bche", "Slc6a8", "4931406C07Rik", 
## "Slc5a1", "Tpm2", "Hpgd", "Fchsd2", "Cndp2", "Ckmt1", "Prss32", 
## "Bmp1", "Slc10a2", "Plscr4", "Slc17a5", "Aoc1", "Cd81", "Max", 
## "Gm21828", "Gm10256", "Gm21783", "Gm20792", "Gm20815", "Eif2s3y", 
## "Kdm5d", "Uty", "Duoxa2", "Duox2", "Ddx3y", "Nos2", "Oas1h", 
## "Pglyrp1", "Clca3b", "Vmn1r8", "Gpr171", "Ccl20", "Btbd35f1", 
## "Spib")
```

```
## Warning: ggrepel: 33 unlabeled data points (too many overlaps). Consider
## increasing max.overlaps
```

![](PCA_files/figure-html/unnamed-chunk-5-4.png)<!-- -->![](PCA_files/figure-html/unnamed-chunk-5-5.png)<!-- -->![](PCA_files/figure-html/unnamed-chunk-5-6.png)<!-- -->

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
## PC1         NA       NA    NA      NA  5.72499965   NA 1.170924e+01
## PC2         NA       NA    NA      NA 17.47592178   NA 6.118319e+00
## PC3         NA       NA    NA      NA  9.78743513   NA 1.303156e+01
## PC4         NA       NA    NA      NA  6.42412285   NA 2.922024e+00
## PC5         NA       NA    NA      NA 10.08396494   NA 6.613699e+00
## PC6         NA       NA    NA      NA  8.48938438   NA 1.392809e+01
## PC7         NA       NA    NA      NA  0.03643065   NA 5.080234e-01
## PC8         NA       NA    NA      NA  2.81276904   NA 6.693833e-01
## PC9         NA       NA    NA      NA  0.21564901   NA 4.375084e+00
## PC10        NA       NA    NA      NA  0.05044235   NA 3.457056e-04
##      ROICoordinateX ROICoordinateY ScanDate ScanWidth ScanHeight ScanOffsetX
## PC1      80.4365058      7.5908439       NA        NA         NA          NA
## PC2       0.2709889     20.8108109       NA        NA         NA          NA
## PC3       5.0065213     10.8941656       NA        NA         NA          NA
## PC4       3.2055419      8.3511513       NA        NA         NA          NA
## PC5       0.2514453     13.8066222       NA        NA         NA          NA
## PC6       0.1578925      0.1029235       NA        NA         NA          NA
## PC7       0.2644886      6.5198760       NA        NA         NA          NA
## PC8       4.2294218      7.9070174       NA        NA         NA          NA
## PC9       1.0666264     10.2215438       NA        NA         NA          NA
## PC10      0.2730055      0.1652952       NA        NA         NA          NA
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
##            Group Tissue       sample        Sex NegGeoMean_Mm_R_NGS_WTA_v1.0
## PC1  83.33020443     NA 7.793936e+01  0.2285452                 3.190774e+01
## PC2   0.34496415     NA 5.840465e-02  3.2508571                 1.800033e+00
## PC3  13.26839214     NA 5.452099e+00 19.3687927                 7.739412e+00
## PC4   0.23217557     NA 1.166754e+01 51.9800148                 2.254456e+01
## PC5   0.37616630     NA 1.755930e-01  4.3221883                 3.701421e+00
## PC6   0.62863107     NA 1.222953e-01  3.6003745                 2.020464e-04
## PC7   0.86613630     NA 2.302482e+00  0.4201289                 3.049878e-02
## PC8   0.28733785     NA 3.310599e-05  4.9010439                 1.388749e-03
## PC9   0.18050725     NA 3.792806e-01  1.8134592                 4.806804e+00
## PC10  0.05051092     NA 6.357688e-02  4.8212362                 3.043605e-02
##      NegGeoSD_Mm_R_NGS_WTA_v1.0 SampleID Roi Aoi sample_id     lib_size
## PC1                 47.24299599      NaN  NA  NA        NA 22.937311454
## PC2                  2.28320760      NaN  NA  NA        NA  0.096356434
## PC3                 14.29687598      NaN  NA  NA        NA 11.173092007
## PC4                 13.96612585      NaN  NA  NA        NA 22.368907386
## PC5                  5.80661118      NaN  NA  NA        NA  3.793080093
## PC6                  0.01711848      NaN  NA  NA        NA  1.508269623
## PC7                  0.02121553      NaN  NA  NA        NA  0.061714297
## PC8                  0.03779514      NaN  NA  NA        NA  0.840394444
## PC9                  0.26468350      NaN  NA  NA        NA  1.849449120
## PC10                 0.10360677      NaN  NA  NA        NA  0.003411947
##      countOfLowEprGene percentOfLowEprGene
## PC1        50.60024715         50.60024715
## PC2         0.16527636          0.16527636
## PC3        31.12325213         31.12325213
## PC4         3.47218949          3.47218949
## PC5         8.15518418          8.15518418
## PC6         2.27480018          2.27480018
## PC7         0.26693320          0.26693320
## PC8         0.67777917          0.67777917
## PC9         0.07771698          0.07771698
## PC10        0.86828812          0.86828812
```

