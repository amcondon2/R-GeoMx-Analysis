install.packages("devtools")

if (!requireNamespace("BiocManager", quietly=TRUE))
  install.packages("BiocManager")

BiocManager::install("NanoStringNCTools")

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("GeomxTools")
BiocManager::install("GeoMxWorkflows")

