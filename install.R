#install.packages("installr")
#library(installr)
#updateR()

install.packages("devtools")

if (!requireNamespace("BiocManager", quietly=TRUE))
  install.packages("BiocManager")

install.packages("librarian")
library(librarian)

librarian::shelf(RColorBrewer,knitr,dplyr,ggforce,stringr,ggplot2,scales,reshape2,cowplot,umap,Rtsne,plotly,tictoc,tidyverse,ggalluvial,scater)

librarian::shelf(NanoStringNCTools,GeomxTools,GeoMxWorkflows,GeoDiff,Biobase,SpatialExperiment,standR,limma,edgeR,msigdb,GSEABase)
