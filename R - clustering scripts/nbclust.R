#setup
if(!require(devtools)) install.packages("devtools")
devtools::install_github("kassambara/factoextra")

pkgs <- c("cluster", "fpc", "NbClust")
install.packages(pkgs)

library(factoextra)
library(cluster)
library(fpc)
library(NbClust)
library(dplyr) # for data cleaning
library(ISLR) # for college dataset
library(Rtsne) # for t-SNE plot
library(ggplot2) # for visualization

set.seed(1680) # for reproducibility


#data

setwd("C:/Users/lukas/PycharmProjects/monimporter")
clusterdata <- read.csv(file="pathsdf0518.csv", header=TRUE, sep=",")

clusterdata[, 2:3]

gower_dist <- daisy(clusterdata[, 2:3],
                    metric = "gower",
                    type = list(logratio = 2))

summary(gower_dist)

gower_mat <- as.matrix(gower_dist)

clusterdata.scaled <- scale(clusterdata[,2:3])

nb <- NbClust(clusterdata.scaled, distance = "euclidean", min.nc = 2,
              max.nc = 20, method = "complete", index ="all")
# Visualize the result
library(factoextra)
fviz_nbclust(nb) + theme_minimal()