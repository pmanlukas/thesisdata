install.packages("klaR")
library(klaR)
setwd("C:/Users/lukas/PycharmProjects/monimporter")
clusterdata <- read.csv(file="clusterdfr.csv", header=TRUE, sep=",")

str(clusterdata)


head(clusterdata, n=10)


data.to.cluster <- read.csv(file="clusterdfr.csv", header=TRUE, sep=",")
cluster.results <- kmodes(data.to.cluster[,2:16], 6, iter.max = 10, weighted = FALSE)
plot(data.to.cluster[,2:15],col= cluster.results$cluster)#

cluster.results

cluster.output <- cbind(data.to.cluster,cluster.results$cluster)
write.csv(cluster.output, file = "kmodes clusters3.csv", row.names = TRUE)