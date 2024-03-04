---
title: "(s)PLS(-DA) on combined regions"
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
## Attaching package: 'pls'
```

```
## The following object is masked from 'package:stats':
## 
##     loadings
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
## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
## ✔ forcats   1.0.0     ✔ stringr   1.5.1
## ✔ lubridate 1.9.3     ✔ tibble    3.2.1
## ✔ purrr     1.0.2     ✔ tidyr     1.3.0
## ✔ readr     2.1.5     
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
## Loading required package: MASS
## 
## 
## Attaching package: 'MASS'
## 
## 
## The following object is masked from 'package:dplyr':
## 
##     select
## 
## 
## Loading required package: lattice
## 
## 
## Loaded mixOmics 6.26.0
## Thank you for using mixOmics!
## Tutorials: http://mixomics.org
## Bookdown vignette: https://mixomicsteam.github.io/Bookdown
## Questions, issues: Follow the prompts at http://mixomics.org/contact-us
## Cite us:  citation('mixOmics')
## 
## 
## 
## Attaching package: 'mixOmics'
## 
## 
## The following object is masked from 'package:purrr':
## 
##     map
```

#Load Data

```
## Rows: 8 Columns: 16
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr  (1): Sex
## dbl (15): sample, LT1mean, LT2mean, LT3mean, LT1med, LT2med, LT3med, I1mean,...
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

## Normalize data
![](plsCombinedSamples_files/figure-html/unnamed-chunk-3-1.png)<!-- -->![](plsCombinedSamples_files/figure-html/unnamed-chunk-3-2.png)<!-- -->![](plsCombinedSamples_files/figure-html/unnamed-chunk-3-3.png)<!-- -->![](plsCombinedSamples_files/figure-html/unnamed-chunk-3-4.png)<!-- -->![](plsCombinedSamples_files/figure-html/unnamed-chunk-3-5.png)<!-- -->

#Do sPLS with FLIm features on summed data


#Analysis on sPLS result

```
## $X
##     comp1     comp2 
## 0.2027704 0.1430426 
## 
## $Y
##      comp1      comp2 
## 0.98254764 0.02583306
```

```
##               comp1      comp2
## Endog    51.6900828 51.0646221
## Clip1    44.7372636 44.1959548
## Tnnc2    42.5611761 42.0461777
## Odf3b    39.6589221 39.1790919
## Rnf141   33.4983755 33.0930393
## Lancl2   33.2987503 32.8958389
## Hdac9    31.7989396 31.4142799
## Ctdsp2   30.9205608 30.5464334
## Shisal2a 30.6946965 30.3234094
## Wdr45    29.4871415 29.1303460
## Gal3st1  28.5500188 28.2045865
## Mcl1     24.6869511 24.3882490
## Il1rl2   20.8146679 20.5629192
## S100a14  20.7889700 20.5375275
## Zbtb5    20.4215327 20.1744322
## Cited2   18.6946860 18.4685324
## Gpat3    18.3719124 18.1497446
## Hpgd     17.2472756 17.0386915
## Prl2a1   16.1821432 15.9863418
## Rbm45    16.0581523 15.8640305
## Nr1h3    15.6484677 15.4594729
## Rims2    12.8584849 12.7030447
## Sardh    12.1579959 12.0110572
## Slc10a2  11.7242548 11.5824067
## Ctdsp1   10.9466725 10.8144035
## Guca2a   10.5029655 10.3763777
## Tnfsfm13 10.4906766 10.3640064
## Vim       9.7987300  9.6803865
## Cyp4f14   9.1718317  9.0610209
## Tmc2      8.0744235  7.9767214
## Zfp367    7.8867748  7.7913535
## Atp6ap2   7.2590446  7.1723256
## Olfr1214  6.8821702  6.7991063
## Ankrd13b  6.7369808  6.6559267
## Cc2d1a    6.4895783  6.4114784
## Bche      6.4552139  6.3778826
## Ldb3      5.9169528  5.8454842
## Gnpnat1   4.7560402  4.6991192
## Ankrd12   4.4908977  4.4374538
## Apbb1ip   3.1135710  3.0758981
## Themis3   2.5195465  2.4891199
## Trim24    1.9485114  1.9283087
## Pih1d1    1.8021638  1.7803949
## Tmem161a  1.8012434  1.7794500
## Atxn7     1.7571511  1.7374185
## Rbm5      1.5919628  1.5737865
## St6gal2   1.3642969  1.3478816
## Kdm4a     0.3673456  0.3649566
## Acadm     0.3408039  0.3372673
## Lxn       0.1532902  0.1516928
```

![](plsCombinedSamples_files/figure-html/unnamed-chunk-5-1.png)<!-- -->![](plsCombinedSamples_files/figure-html/unnamed-chunk-5-2.png)<!-- -->

#Do sPLS-DA on treatment group with summed data

```
## $X
##     comp1     comp2 
## 0.2303811 0.1664115 
## 
## $Y
##       comp1       comp2 
## 1.000000000 0.002319491
```

![](plsCombinedSamples_files/figure-html/unnamed-chunk-6-1.png)<!-- -->![](plsCombinedSamples_files/figure-html/unnamed-chunk-6-2.png)<!-- -->

```
##  [1] "Pdia3"         "Rrbp1"         "1700037H04Rik" "4931406C07Rik"
##  [5] "Krtcap2"       "Flacc1"        "Bola2"         "Bmp1"         
##  [9] "Lmnb1"         "Relb"          "Niban2"        "Cyp4f14"      
## [13] "Lxn"           "Acbd6"         "Fads3"         "Hdac1"        
## [17] "Nlrx1"         "Eola1"         "Deaf1"         "Por"          
## [21] "Slc37a4"       "Mcl1"          "Mgll"          "Oxct1"        
## [25] "Faim2"         "Cldn4"         "Tgfbi"         "Manf"         
## [29] "G6pc3"         "Ifitm2"        "Arhgef2"       "Cadps2"       
## [33] "Slc6a8"        "Calr"          "Zc3h12d"       "Rnf141"       
## [37] "Gm45915"       "Bche"          "1810065E05Rik" "Frat1"        
## [41] "Galnt4"        "Ftl1"          "Cndp2"         "Dctpp1"       
## [45] "Tpm2"          "Trim34a"       "Cracd"         "Ptk6"         
## [49] "Carhsp1"       "Acsf2"
```

![](plsCombinedSamples_files/figure-html/unnamed-chunk-6-3.png)<!-- -->

```
##                     comp1       comp2
## Pdia3         43.38321215 43.33817285
## Rrbp1         41.42859544 41.38558516
## 1700037H04Rik 38.39015770 38.35030187
## 4931406C07Rik 37.55608336 37.51709430
## Krtcap2       34.19608320 34.16058237
## Flacc1        33.73219670 33.69717756
## Bola2         33.51731226 33.48251604
## Bmp1          31.98127237 31.94807051
## Lmnb1         28.53797869 28.50835144
## Relb          27.64894654 27.62024291
## Niban2        27.10021203 27.07207715
## Cyp4f14       24.02989357 24.00494664
## Lxn           22.10933867 22.08638688
## Acbd6         21.23903825 21.21698882
## Fads3         21.17629807 21.15432112
## Hdac1         20.86237179 20.84071889
## Nlrx1         20.16823926 20.14730134
## Eola1         19.10642693 19.08660309
## Deaf1         18.72514572 18.70570715
## Por           18.62445439 18.60512801
## Slc37a4       18.04146505 18.02274291
## Mcl1          17.77450803 17.75607622
## Mgll          17.63766710 17.61935613
## Oxct1         16.32795985 16.31100855
## Faim2         16.01468194 15.99806668
## Cldn4         14.76627355 14.75094651
## Tgfbi         13.64876824 13.63459845
## Manf          12.26811776 12.25538700
## G6pc3         10.12677427 10.11627664
## Ifitm2         9.23826313  9.22870066
## Arhgef2        8.41184423  8.40311220
## Cadps2         8.10927299  8.10085422
## Slc6a8         8.07016014  8.06179561
## Calr           7.95016664  7.94193162
## Zc3h12d        7.65028126  7.64234008
## Rnf141         6.95601856  6.94881686
## Gm45915        6.95543905  6.94826359
## Bche           6.46331133  6.45660131
## 1810065E05Rik  6.36040320  6.35380047
## Frat1          5.82684564  5.82079636
## Galnt4         5.41496721  5.40936870
## Ftl1           4.36002580  4.35553750
## Cndp2          4.09781541  4.09356121
## Dctpp1         3.79503518  3.79110813
## Tpm2           2.16693512  2.16468546
## Trim34a        1.53620497  1.53461186
## Cracd          0.93846145  0.93748967
## Ptk6           0.90719766  0.90648368
## Carhsp1        0.52856252  0.52803346
## Acsf2          0.03754029  0.03760327
```

#Do sPLS-DA on sex group with summed data

```
## $X
##     comp1     comp2 
## 0.1514018 0.2028053 
## 
## $Y
##       comp1       comp2 
## 1.000000000 0.004256925
```

![](plsCombinedSamples_files/figure-html/unnamed-chunk-7-1.png)<!-- -->![](plsCombinedSamples_files/figure-html/unnamed-chunk-7-2.png)<!-- -->

```
##  [1] "Ddx3y"         "Kdm5d"         "Eif2s3y"       "Gm21783"      
##  [5] "Gm20792"       "Gm20815"       "Tmem28"        "Uty"          
##  [9] "Gm10256"       "Egfl6"         "Gm21828"       "Xlr4a"        
## [13] "Rhox2a"        "Gm7073"        "Frmd3"         "Mbtd1"        
## [17] "Prdx1"         "Nid1"          "Il13"          "Cacnb3"       
## [21] "Mageb4"        "Rhox3g"        "5031439G07Rik" "Tprg"         
## [25] "Csf3"          "Magea8"        "Btbd35f1"      "Ezhip"        
## [29] "Sars"          "H4c8"          "Gm36049"       "Bri3"         
## [33] "Gm9112"        "Frmd7"         "Ptpn3"         "Igsf1"        
## [37] "Prrc2b"        "Gtf3c5"        "Gm40755"       "Gm16405"      
## [41] "Ndufaf1"       "Cep170"        "Paxx"          "Zc3h14"       
## [45] "Tuba1a"        "Rida"          "Pak1ip1"       "Olfr272"      
## [49] "Stard8"        "Tbc1d31"
```

![](plsCombinedSamples_files/figure-html/unnamed-chunk-7-3.png)<!-- -->

```
##                    comp1      comp2
## Ddx3y         39.8509113 39.7768020
## Kdm5d         37.3903277 37.3207942
## Eif2s3y       37.2593568 37.1900668
## Gm21783       37.1894149 37.1202561
## Gm20792       36.0356875 35.9686736
## Gm20815       35.1554350 35.0900591
## Tmem28        33.8207321 33.7578391
## Uty           33.3553282 33.2932993
## Gm10256       31.2877053 31.2295220
## Egfl6         29.0600378 29.0060045
## Gm21828       28.9164244 28.8626499
## Xlr4a         26.8925127 26.8425065
## Rhox2a        25.3114716 25.2644008
## Gm7073        19.8041764 19.7673478
## Frmd3         19.6041471 19.5676928
## Mbtd1         19.6034142 19.5669591
## Prdx1         19.3844183 19.3483813
## Nid1          18.7644301 18.7295478
## Il13          18.2972905 18.2632815
## Cacnb3        16.9710683 16.9395497
## Mageb4        16.7547925 16.7236420
## Rhox3g        15.9493036 15.9196662
## 5031439G07Rik 15.8403419 15.8108902
## Tprg          15.3247284 15.2962532
## Csf3          15.2163913 15.1881132
## Magea8        14.4109370 14.3841375
## Btbd35f1      14.2075331 14.1811119
## Ezhip         13.9685086 13.9425511
## Sars          13.3006118 13.2759092
## H4c8          11.9861565 11.9639342
## Gm36049       11.9569508 11.9347286
## Bri3          10.2285570 10.2095958
## Gm9112         9.7801047  9.7619187
## Frmd7          8.7936445  8.7773176
## Ptpn3          8.3802247  8.3646772
## Igsf1          7.3848193  7.3711216
## Prrc2b         6.9046273  6.8917876
## Gtf3c5         5.8919657  5.8810707
## Gm40755        4.5635130  4.5551423
## Gm16405        3.8206912  3.8135906
## Ndufaf1        3.6823361  3.6754908
## Cep170         3.0004288  2.9951529
## Paxx           2.8209780  2.8157561
## Zc3h14         2.4295455  2.4251047
## Tuba1a         0.9635373  0.9626599
## Rida           0.8513416  0.8498042
## Pak1ip1        0.8174369  0.8161629
## Olfr272        0.3855016  0.3853952
## Stard8         0.1869868  0.1866726
## Tbc1d31        0.1577435  0.1675715
```

![](plsCombinedSamples_files/figure-html/unnamed-chunk-8-1.png)<!-- -->![](plsCombinedSamples_files/figure-html/unnamed-chunk-8-2.png)<!-- -->![](plsCombinedSamples_files/figure-html/unnamed-chunk-8-3.png)<!-- -->![](plsCombinedSamples_files/figure-html/unnamed-chunk-8-4.png)<!-- -->![](plsCombinedSamples_files/figure-html/unnamed-chunk-8-5.png)<!-- -->

