set.seed(1680) # for reproducibility

library(dplyr) # for data cleaning
library(ISLR) # for college dataset
library(cluster) # for gower similarity and pam
library(Rtsne) # for t-SNE plot
library(ggplot2) # for visualization
library(klaR)

setwd("C:/Users/lukas/PycharmProjects/monimporter")
clusterdata <- read.csv(file="clusterdfr.csv", header=TRUE, sep=",")

str(clusterdata)


head(clusterdata, n=10)


cluster.results <- kmodes(clusterdata[,2:16], 6, iter.max = 10, weighted = FALSE)
plot(clusterdata[,2:16],col= cluster.results$cluster)#

cluster.results

cluster.output <- cbind(clusterdata,cluster.results$cluster)
write.csv(cluster.output, file = "kmodes clusters6.csv", row.names = TRUE)