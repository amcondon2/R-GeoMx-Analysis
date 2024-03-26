---
title: "Gene-Set / Pathway Analysis"
output:
  html_document:
    keep_md: true 
---



Interesting libraries:

<https://bioconductor.org/packages/release/bioc/html/GSVA.html> Going to try first, implements GSEA, ssGSEA, and other methods <https://bioconductor.org/packages/release/bioc/html/singscore.html> newer single sample method by group creating standR

<https://bioconductor.org/packages/release/bioc/html/limma.html> for pathway analysis with voom + camera/fry/roast. Going to try last <https://bioconductor.org/packages/release/bioc/html/SPIA.html> not as popular method, but higher pathway level accounted for

<https://bioconductor.org/packages/release/bioc/html/vissE.html> for result visualization

<https://www.frontiersin.org/journals/physiology/articles/10.3389/fphys.2015.00383/full> review on pathway analysis, probably outdated now

<https://www.gsea-msigdb.org/gsea/msigdb/mouse/genesets.jsp?collection=CP> probably will just want curated pathways

# Import Libraries


```
## Loading required package: MASS
```

```
## 
## Attaching package: 'MASS'
```

```
## The following object is masked from 'package:AnnotationDbi':
## 
##     select
```

```
## The following object is masked from 'package:dplyr':
## 
##     select
```

```
## Loading required package: lattice
```

```
## 
## Loaded mixOmics 6.26.0
## Thank you for using mixOmics!
## Tutorials: http://mixomics.org
## Bookdown vignette: https://mixomicsteam.github.io/Bookdown
## Questions, issues: Follow the prompts at http://mixomics.org/contact-us
## Cite us:  citation('mixOmics')
```

```
## 
## Attaching package: 'mixOmics'
```

```
## The following object is masked from 'package:purrr':
## 
##     map
```

#Load and Prepare Data


```
## Rows: 8 Columns: 17
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr  (2): Sex, Group
## dbl (15): sample, LT1mean, LT2mean, LT3mean, LT1med, LT2med, LT3med, I1mean,...
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

![](pathways_files/figure-html/unnamed-chunk-2-1.png)<!-- -->![](pathways_files/figure-html/unnamed-chunk-2-2.png)<!-- -->![](pathways_files/figure-html/unnamed-chunk-2-3.png)<!-- -->![](pathways_files/figure-html/unnamed-chunk-2-4.png)<!-- -->

#Load desired Gene Sets from msigdb <https://igordot.github.io/msigdbr/articles/msigdbr-intro.html>


```
## see ?msigdb and browseVignettes('msigdb') for documentation
```

```
## loading from cache
```

```
## 
```

```
## 
```

```
## Warning in getMsigOrganism(gsc, idType): Assuming the organism to be mouse.
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
## [1] "c1" "c3" "c2" "c8" "c6" "c7" "c4" "c5" "h"
```

```
##  [1] "MIR:MIR_LEGACY"  "TFT:TFT_LEGACY"  "CGP"             "TFT:GTRD"       
##  [5] "VAX"             "CP:BIOCARTA"     "CGN"             "GO:BP"          
##  [9] "GO:CC"           "IMMUNESIGDB"     "GO:MF"           "HPO"            
## [13] "MIR:MIRDB"       "CM"              "CP"              "CP:PID"         
## [17] "CP:REACTOME"     "CP:WIKIPATHWAYS" "CP:KEGG"
```

#Do gene set enrichment analysis worried about extent of correct matching by gene name, entrez id and annotation library don't seem to work


```
## No annotation package name available in the input data object.
## Attempting to directly match identifiers in data to gene sets.
## Estimating GSVA scores for 2570 gene sets.
## Estimating ECDFs with Gaussian kernels
## 
  |                                                                            
  |                                                                      |   0%
  |                                                                            
  |                                                                      |   1%
  |                                                                            
  |=                                                                     |   1%
  |                                                                            
  |=                                                                     |   2%
  |                                                                            
  |==                                                                    |   2%
  |                                                                            
  |==                                                                    |   3%
  |                                                                            
  |==                                                                    |   4%
  |                                                                            
  |===                                                                   |   4%
  |                                                                            
  |===                                                                   |   5%
  |                                                                            
  |====                                                                  |   5%
  |                                                                            
  |====                                                                  |   6%
  |                                                                            
  |=====                                                                 |   6%
  |                                                                            
  |=====                                                                 |   7%
  |                                                                            
  |=====                                                                 |   8%
  |                                                                            
  |======                                                                |   8%
  |                                                                            
  |======                                                                |   9%
  |                                                                            
  |=======                                                               |   9%
  |                                                                            
  |=======                                                               |  10%
  |                                                                            
  |=======                                                               |  11%
  |                                                                            
  |========                                                              |  11%
  |                                                                            
  |========                                                              |  12%
  |                                                                            
  |=========                                                             |  12%
  |                                                                            
  |=========                                                             |  13%
  |                                                                            
  |=========                                                             |  14%
  |                                                                            
  |==========                                                            |  14%
  |                                                                            
  |==========                                                            |  15%
  |                                                                            
  |===========                                                           |  15%
  |                                                                            
  |===========                                                           |  16%
  |                                                                            
  |============                                                          |  16%
  |                                                                            
  |============                                                          |  17%
  |                                                                            
  |============                                                          |  18%
  |                                                                            
  |=============                                                         |  18%
  |                                                                            
  |=============                                                         |  19%
  |                                                                            
  |==============                                                        |  19%
  |                                                                            
  |==============                                                        |  20%
  |                                                                            
  |==============                                                        |  21%
  |                                                                            
  |===============                                                       |  21%
  |                                                                            
  |===============                                                       |  22%
  |                                                                            
  |================                                                      |  22%
  |                                                                            
  |================                                                      |  23%
  |                                                                            
  |================                                                      |  24%
  |                                                                            
  |=================                                                     |  24%
  |                                                                            
  |=================                                                     |  25%
  |                                                                            
  |==================                                                    |  25%
  |                                                                            
  |==================                                                    |  26%
  |                                                                            
  |===================                                                   |  26%
  |                                                                            
  |===================                                                   |  27%
  |                                                                            
  |===================                                                   |  28%
  |                                                                            
  |====================                                                  |  28%
  |                                                                            
  |====================                                                  |  29%
  |                                                                            
  |=====================                                                 |  29%
  |                                                                            
  |=====================                                                 |  30%
  |                                                                            
  |=====================                                                 |  31%
  |                                                                            
  |======================                                                |  31%
  |                                                                            
  |======================                                                |  32%
  |                                                                            
  |=======================                                               |  32%
  |                                                                            
  |=======================                                               |  33%
  |                                                                            
  |=======================                                               |  34%
  |                                                                            
  |========================                                              |  34%
  |                                                                            
  |========================                                              |  35%
  |                                                                            
  |=========================                                             |  35%
  |                                                                            
  |=========================                                             |  36%
  |                                                                            
  |==========================                                            |  36%
  |                                                                            
  |==========================                                            |  37%
  |                                                                            
  |==========================                                            |  38%
  |                                                                            
  |===========================                                           |  38%
  |                                                                            
  |===========================                                           |  39%
  |                                                                            
  |============================                                          |  39%
  |                                                                            
  |============================                                          |  40%
  |                                                                            
  |============================                                          |  41%
  |                                                                            
  |=============================                                         |  41%
  |                                                                            
  |=============================                                         |  42%
  |                                                                            
  |==============================                                        |  42%
  |                                                                            
  |==============================                                        |  43%
  |                                                                            
  |==============================                                        |  44%
  |                                                                            
  |===============================                                       |  44%
  |                                                                            
  |===============================                                       |  45%
  |                                                                            
  |================================                                      |  45%
  |                                                                            
  |================================                                      |  46%
  |                                                                            
  |=================================                                     |  46%
  |                                                                            
  |=================================                                     |  47%
  |                                                                            
  |=================================                                     |  48%
  |                                                                            
  |==================================                                    |  48%
  |                                                                            
  |==================================                                    |  49%
  |                                                                            
  |===================================                                   |  49%
  |                                                                            
  |===================================                                   |  50%
  |                                                                            
  |===================================                                   |  51%
  |                                                                            
  |====================================                                  |  51%
  |                                                                            
  |====================================                                  |  52%
  |                                                                            
  |=====================================                                 |  52%
  |                                                                            
  |=====================================                                 |  53%
  |                                                                            
  |=====================================                                 |  54%
  |                                                                            
  |======================================                                |  54%
  |                                                                            
  |======================================                                |  55%
  |                                                                            
  |=======================================                               |  55%
  |                                                                            
  |=======================================                               |  56%
  |                                                                            
  |========================================                              |  56%
  |                                                                            
  |========================================                              |  57%
  |                                                                            
  |========================================                              |  58%
  |                                                                            
  |=========================================                             |  58%
  |                                                                            
  |=========================================                             |  59%
  |                                                                            
  |==========================================                            |  59%
  |                                                                            
  |==========================================                            |  60%
  |                                                                            
  |==========================================                            |  61%
  |                                                                            
  |===========================================                           |  61%
  |                                                                            
  |===========================================                           |  62%
  |                                                                            
  |============================================                          |  62%
  |                                                                            
  |============================================                          |  63%
  |                                                                            
  |============================================                          |  64%
  |                                                                            
  |=============================================                         |  64%
  |                                                                            
  |=============================================                         |  65%
  |                                                                            
  |==============================================                        |  65%
  |                                                                            
  |==============================================                        |  66%
  |                                                                            
  |===============================================                       |  66%
  |                                                                            
  |===============================================                       |  67%
  |                                                                            
  |===============================================                       |  68%
  |                                                                            
  |================================================                      |  68%
  |                                                                            
  |================================================                      |  69%
  |                                                                            
  |=================================================                     |  69%
  |                                                                            
  |=================================================                     |  70%
  |                                                                            
  |=================================================                     |  71%
  |                                                                            
  |==================================================                    |  71%
  |                                                                            
  |==================================================                    |  72%
  |                                                                            
  |===================================================                   |  72%
  |                                                                            
  |===================================================                   |  73%
  |                                                                            
  |===================================================                   |  74%
  |                                                                            
  |====================================================                  |  74%
  |                                                                            
  |====================================================                  |  75%
  |                                                                            
  |=====================================================                 |  75%
  |                                                                            
  |=====================================================                 |  76%
  |                                                                            
  |======================================================                |  76%
  |                                                                            
  |======================================================                |  77%
  |                                                                            
  |======================================================                |  78%
  |                                                                            
  |=======================================================               |  78%
  |                                                                            
  |=======================================================               |  79%
  |                                                                            
  |========================================================              |  79%
  |                                                                            
  |========================================================              |  80%
  |                                                                            
  |========================================================              |  81%
  |                                                                            
  |=========================================================             |  81%
  |                                                                            
  |=========================================================             |  82%
  |                                                                            
  |==========================================================            |  82%
  |                                                                            
  |==========================================================            |  83%
  |                                                                            
  |==========================================================            |  84%
  |                                                                            
  |===========================================================           |  84%
  |                                                                            
  |===========================================================           |  85%
  |                                                                            
  |============================================================          |  85%
  |                                                                            
  |============================================================          |  86%
  |                                                                            
  |=============================================================         |  86%
  |                                                                            
  |=============================================================         |  87%
  |                                                                            
  |=============================================================         |  88%
  |                                                                            
  |==============================================================        |  88%
  |                                                                            
  |==============================================================        |  89%
  |                                                                            
  |===============================================================       |  89%
  |                                                                            
  |===============================================================       |  90%
  |                                                                            
  |===============================================================       |  91%
  |                                                                            
  |================================================================      |  91%
  |                                                                            
  |================================================================      |  92%
  |                                                                            
  |=================================================================     |  92%
  |                                                                            
  |=================================================================     |  93%
  |                                                                            
  |=================================================================     |  94%
  |                                                                            
  |==================================================================    |  94%
  |                                                                            
  |==================================================================    |  95%
  |                                                                            
  |===================================================================   |  95%
  |                                                                            
  |===================================================================   |  96%
  |                                                                            
  |====================================================================  |  96%
  |                                                                            
  |====================================================================  |  97%
  |                                                                            
  |====================================================================  |  98%
  |                                                                            
  |===================================================================== |  98%
  |                                                                            
  |===================================================================== |  99%
  |                                                                            
  |======================================================================|  99%
  |                                                                            
  |======================================================================| 100%
```

```
## $X
##     comp1     comp2 
## 0.2329402 0.2684317 
## 
## $Y
##      comp1      comp2 
## 0.98254786 0.04572769
```

```
##                                                                                          comp1
## REACTOME_GENERATION_OF_SECOND_MESSENGER_MOLECULES                                  14.49862154
## WP_FAMILIAL_HYPERLIPIDEMIA_TYPE_3                                                  14.29589486
## WP_NCRNAS_INVOLVED_IN_STAT3_SIGNALING_IN_HEPATOCELLULAR_CARCINOMA                  14.09095876
## REACTOME_VITAMIN_B2_RIBOFLAVIN_METABOLISM                                          13.56458067
## REACTOME_SIGNALING_BY_NTRK2_TRKB                                                   12.64779603
## WP_CANCER_IMMUNOTHERAPY_BY_CTLA4_BLOCKADE                                          12.36622300
## KEGG_FOCAL_ADHESION                                                                10.65585403
## REACTOME_FOXO_MEDIATED_TRANSCRIPTION_OF_CELL_DEATH_GENES                           10.54267505
## REACTOME_RHOD_GTPASE_CYCLE                                                         10.07510718
## REACTOME_FGFR2_MUTANT_RECEPTOR_ACTIVATION                                           8.92363930
## WP_P53_TRANSCRIPTIONAL_GENE_NETWORK                                                 8.88771647
## WP_SARSCOV2_INNATE_IMMUNITY_EVASION_AND_CELLSPECIFIC_IMMUNE_RESPONSE                8.79025033
## REACTOME_MEIOSIS                                                                    8.28827418
## WP_FOCAL_ADHESION                                                                   8.23132886
## REACTOME_PHASE_4_RESTING_MEMBRANE_POTENTIAL                                         8.22878100
## WP_PHOSPHOINOSITIDES_METABOLISM                                                     8.13274268
## REACTOME_SEMA4D_INDUCED_CELL_MIGRATION_AND_GROWTH_CONE_COLLAPSE                     7.96760851
## WP_REGULATORY_CIRCUITS_OF_THE_STAT3_SIGNALING_PATHWAY                               7.63824086
## REACTOME_ERYTHROCYTES_TAKE_UP_OXYGEN_AND_RELEASE_CARBON_DIOXIDE                     7.30738541
## REACTOME_SHC1_EVENTS_IN_ERBB2_SIGNALING                                             6.93562223
## WP_TCELL_ACTIVATION_SARSCOV2                                                        6.69513985
## REACTOME_ACTIVATED_NTRK2_SIGNALS_THROUGH_FRS2_AND_FRS3                              6.65456325
## WP_NETWORK_MAP_OF_SARSCOV2_SIGNALING_PATHWAY                                        6.63351039
## WP_NOTCH_SIGNALING_PATHWAY                                                          6.30480018
## REACTOME_HYDROLYSIS_OF_LPC                                                          5.92203508
## REACTOME_DEFECTIVE_LFNG_CAUSES_SCDO3                                                5.65882613
## REACTOME_SEMA4D_IN_SEMAPHORIN_SIGNALING                                             5.33450421
## REACTOME_GP1B_IX_V_ACTIVATION_SIGNALLING                                            5.17552368
## REACTOME_CA2_PATHWAY                                                                4.29078149
## REACTOME_SEMAPHORIN_INTERACTIONS                                                    3.99880766
## REACTOME_DOPAMINE_CLEARANCE_FROM_THE_SYNAPTIC_CLEFT                                 3.24952245
## REACTOME_ELECTRIC_TRANSMISSION_ACROSS_GAP_JUNCTIONS                                 3.22620894
## REACTOME_MEIOTIC_RECOMBINATION                                                      2.82679236
## REACTOME_CATION_COUPLED_CHLORIDE_COTRANSPORTERS                                     2.71788713
## REACTOME_SARS_COV_2_TARGETS_PDZ_PROTEINS_IN_CELL_CELL_JUNCTION                      2.58274974
## WP_HOSTPATHOGEN_INTERACTION_OF_HUMAN_CORONAVIRUSES_AUTOPHAGY                        2.38702092
## REACTOME_RHOJ_GTPASE_CYCLE                                                          2.19704051
## REACTOME_2_LTR_CIRCLE_FORMATION                                                     1.94314971
## REACTOME_ERYTHROCYTES_TAKE_UP_CARBON_DIOXIDE_AND_RELEASE_OXYGEN                     1.90786797
## REACTOME_NCAM_SIGNALING_FOR_NEURITE_OUT_GROWTH                                      1.90038707
## REACTOME_ACTIVATED_NTRK2_SIGNALS_THROUGH_FYN                                        1.62294078
## WP_OSX_AND_MIRNAS_IN_TOOTH_DEVELOPMENT                                              1.44569294
## REACTOME_SIGNALING_BY_PDGFRA_TRANSMEMBRANE_JUXTAMEMBRANE_AND_KINASE_DOMAIN_MUTANTS  1.39985118
## WP_SARS_CORONAVIRUS_AND_INNATE_IMMUNITY                                             1.26879041
## REACTOME_METABOLISM_OF_PORPHYRINS                                                   0.81720900
## REACTOME_GABA_SYNTHESIS_RELEASE_REUPTAKE_AND_DEGRADATION                            0.67624588
## REACTOME_AMYLOID_FIBER_FORMATION                                                    0.57762648
## KEGG_CHEMOKINE_SIGNALING_PATHWAY                                                    0.42436752
## KEGG_REGULATION_OF_AUTOPHAGY                                                        0.38310458
## WP_AUTOPHAGY                                                                        0.05116708
##                                                                                          comp2
## REACTOME_GENERATION_OF_SECOND_MESSENGER_MOLECULES                                  14.27152418
## WP_FAMILIAL_HYPERLIPIDEMIA_TYPE_3                                                  14.07249229
## WP_NCRNAS_INVOLVED_IN_STAT3_SIGNALING_IN_HEPATOCELLULAR_CARCINOMA                  13.87025284
## REACTOME_VITAMIN_B2_RIBOFLAVIN_METABOLISM                                          13.35220015
## REACTOME_SIGNALING_BY_NTRK2_TRKB                                                   12.44972599
## WP_CANCER_IMMUNOTHERAPY_BY_CTLA4_BLOCKADE                                          12.17252357
## KEGG_FOCAL_ADHESION                                                                10.48895408
## REACTOME_FOXO_MEDIATED_TRANSCRIPTION_OF_CELL_DEATH_GENES                           10.37758369
## REACTOME_RHOD_GTPASE_CYCLE                                                          9.91745729
## REACTOME_FGFR2_MUTANT_RECEPTOR_ACTIVATION                                           8.78446999
## WP_P53_TRANSCRIPTIONAL_GENE_NETWORK                                                 8.74867865
## WP_SARSCOV2_INNATE_IMMUNITY_EVASION_AND_CELLSPECIFIC_IMMUNE_RESPONSE                8.65290882
## REACTOME_MEIOSIS                                                                    8.15865667
## WP_FOCAL_ADHESION                                                                   8.10254646
## REACTOME_PHASE_4_RESTING_MEMBRANE_POTENTIAL                                         8.10001209
## WP_PHOSPHOINOSITIDES_METABOLISM                                                     8.00550845
## REACTOME_SEMA4D_INDUCED_CELL_MIGRATION_AND_GROWTH_CONE_COLLAPSE                     7.84282138
## WP_REGULATORY_CIRCUITS_OF_THE_STAT3_SIGNALING_PATHWAY                               7.51896668
## REACTOME_ERYTHROCYTES_TAKE_UP_OXYGEN_AND_RELEASE_CARBON_DIOXIDE                     7.19343416
## REACTOME_SHC1_EVENTS_IN_ERBB2_SIGNALING                                             6.82716653
## WP_TCELL_ACTIVATION_SARSCOV2                                                        6.59086703
## REACTOME_ACTIVATED_NTRK2_SIGNALS_THROUGH_FRS2_AND_FRS3                              6.55033032
## WP_NETWORK_MAP_OF_SARSCOV2_SIGNALING_PATHWAY                                        6.52994188
## WP_NOTCH_SIGNALING_PATHWAY                                                          6.20652236
## REACTOME_HYDROLYSIS_OF_LPC                                                          5.82927486
## REACTOME_DEFECTIVE_LFNG_CAUSES_SCDO3                                                5.57036728
## REACTOME_SEMA4D_IN_SEMAPHORIN_SIGNALING                                             5.25102845
## REACTOME_GP1B_IX_V_ACTIVATION_SIGNALLING                                            5.09457912
## REACTOME_CA2_PATHWAY                                                                4.22497754
## REACTOME_SEMAPHORIN_INTERACTIONS                                                    3.93621705
## REACTOME_DOPAMINE_CLEARANCE_FROM_THE_SYNAPTIC_CLEFT                                 3.19992026
## REACTOME_ELECTRIC_TRANSMISSION_ACROSS_GAP_JUNCTIONS                                 3.18318305
## REACTOME_MEIOTIC_RECOMBINATION                                                      2.78363458
## REACTOME_CATION_COUPLED_CHLORIDE_COTRANSPORTERS                                     2.67539362
## REACTOME_SARS_COV_2_TARGETS_PDZ_PROTEINS_IN_CELL_CELL_JUNCTION                      2.54255842
## WP_HOSTPATHOGEN_INTERACTION_OF_HUMAN_CORONAVIRUSES_AUTOPHAGY                        2.35204027
## REACTOME_RHOJ_GTPASE_CYCLE                                                          2.16569742
## REACTOME_2_LTR_CIRCLE_FORMATION                                                     1.91431102
## REACTOME_ERYTHROCYTES_TAKE_UP_CARBON_DIOXIDE_AND_RELEASE_OXYGEN                     1.89093282
## REACTOME_NCAM_SIGNALING_FOR_NEURITE_OUT_GROWTH                                      1.88704883
## REACTOME_ACTIVATED_NTRK2_SIGNALS_THROUGH_FYN                                        1.59752797
## WP_OSX_AND_MIRNAS_IN_TOOTH_DEVELOPMENT                                              1.42370663
## REACTOME_SIGNALING_BY_PDGFRA_TRANSMEMBRANE_JUXTAMEMBRANE_AND_KINASE_DOMAIN_MUTANTS  1.37804239
## WP_SARS_CORONAVIRUS_AND_INNATE_IMMUNITY                                             1.25187039
## REACTOME_METABOLISM_OF_PORPHYRINS                                                   0.80678812
## REACTOME_GABA_SYNTHESIS_RELEASE_REUPTAKE_AND_DEGRADATION                            0.66587546
## REACTOME_AMYLOID_FIBER_FORMATION                                                    0.56860089
## KEGG_CHEMOKINE_SIGNALING_PATHWAY                                                    0.43215946
## KEGG_REGULATION_OF_AUTOPHAGY                                                        0.38683648
## WP_AUTOPHAGY                                                                        0.05479825
```

![](pathways_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

```
## 
## Call:
## lm(formula = LT2mean ~ REACTOME_VITAMIN_B2_RIBOFLAVIN_METABOLISM, 
##     data = toPlot)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.19082 -0.02514  0.01038  0.05496  0.13652 
## 
## Coefficients:
##                                           Estimate Std. Error t value Pr(>|t|)
## (Intercept)                                3.12526    0.03879  80.562 2.46e-10
## REACTOME_VITAMIN_B2_RIBOFLAVIN_METABOLISM -0.56665    0.11145  -5.084  0.00226
##                                              
## (Intercept)                               ***
## REACTOME_VITAMIN_B2_RIBOFLAVIN_METABOLISM ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.1087 on 6 degrees of freedom
## Multiple R-squared:  0.8116,	Adjusted R-squared:  0.7802 
## F-statistic: 25.85 on 1 and 6 DF,  p-value: 0.002256
```
