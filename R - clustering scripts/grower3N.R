#https://www.r-bloggers.com/clustering-mixed-data-types-in-r/

set.seed(1680) # for reproducibility

library(dplyr) # for data cleaning
library(ISLR) # for college dataset
library(cluster) # for gower similarity and pam
library(Rtsne) # for t-SNE plot
library(ggplot2) # for visualization

# Remove college name before clustering

setwd("C:/Users/lukas/PycharmProjects/monimporter")
clusterdata <- read.csv(file="cluster5.csv", header=TRUE, sep=",")

clusterdata[, 2:18]

gower_dist <- daisy(clusterdata[, 2:18],
                    metric = "gower",
                    type = list(logratio = 3))

summary(gower_dist)

gower_mat <- as.matrix(gower_dist)

#output most similar pair
clusterdata[
  which(gower_mat == min(gower_mat[gower_mat != min(gower_mat)]),
        arr.ind = TRUE)[1, ], ]

# Output most dissimilar pair

clusterdata[
  which(gower_mat == max(gower_mat[gower_mat != max(gower_mat)]),
        arr.ind = TRUE)[1, ], ]

# Calculate silhouette width for many k using PAM

sil_width <- c(NA)

for(i in 2:20){
  
  pam_fit <- pam(gower_dist,
                 diss = TRUE,
                 k = i)
  
  sil_width[i] <- pam_fit$silinfo$avg.width
  
}

# Plot sihouette width (higher is better)

plot(1:20, sil_width,
     xlab = "Number of clusters",
     ylab = "Silhouette Width")
lines(1:20, sil_width)

#Cluster Interpretation
#Via Descriptive Statistics

pam_fit <- pam(gower_dist, diss = TRUE, k = 4)

pam_results <- clusterdata %>%
  dplyr::select(-X) %>%
  mutate(cluster = pam_fit$clustering) %>%
  group_by(cluster) %>%
  do(the_summary = summary(.))

pam_results$the_summary

#visualize it

tsne_obj <- Rtsne(gower_dist, is_distance = TRUE)

tsne_data <- tsne_obj$Y %>%
  data.frame() %>%
  setNames(c("X", "Y")) %>%
  mutate(cluster = factor(pam_fit$clustering),
         name = clusterdata$X)

ggplot(aes(x = X, y = Y), data = tsne_data) +
  geom_point(aes(color = cluster))


pam_fit$clustering

#examples of each cluster 
clusterdata[pam_fit$medoids, ]

clusteroutput <- cbind(clusterdata,pam_fit$clustering)
write.csv(clusteroutput, file = "PAMmix.csv", row.names = TRUE)