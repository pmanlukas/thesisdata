#https://www.r-bloggers.com/clustering-mixed-data-types-in-r/

set.seed(1680) # for reproducibility

library(factoextra)
library(dplyr) # for data cleaning
library(ISLR) # for college dataset
library(cluster) # for gower similarity and pam
library(Rtsne) # for t-SNE plot
library(ggplot2) # for visualization

# Remove college name before clustering

setwd("C:/Users/lukas/PycharmProjects/monimporter")
clusterdata <- read.csv(file="pathsdf_diff.csv", header=TRUE, sep=",")

clusterdata[, 2:3]

gower_dist <- daisy(clusterdata[, 2:3],
                    metric = "gower",
                    type = list(logratio = 2))

summary(gower_dist)

gower_mat <- as.matrix(gower_dist)

#output most similar pair
most_similar <- clusterdata[
  which(gower_mat == min(gower_mat[gower_mat != min(gower_mat)]),
        arr.ind = TRUE)[1, ], ]
most_similar
# Output most dissimilar pair

least_similar <- clusterdata[
  which(gower_mat == max(gower_mat[gower_mat != max(gower_mat)]),
        arr.ind = TRUE)[1, ], ]
least_similar
similarity <- rbind(most_similar, least_similar)

write.csv(similarity, file = "Pathsimilar_diff.csv", row.names = TRUE)

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

###########
#Other evaluation of optimal value for k
#we use factoextra package and apply it on the gower_distance as matrix

# Elbow method
fviz_nbclust(gower_mat, pam, k.max = 20, method = "wss") +
  geom_vline(xintercept = 4, linetype = 2)+
  labs(subtitle = "Elbow method")

# Silhouette method
fviz_nbclust(gower_mat, pam, k.max = 20, method = "silhouette")+
  labs(subtitle = "Silhouette method")

# Gap statistic
# nboot = 50 to keep the function speedy. 
# recommended value: nboot= 500 for your analysis.
# Use verbose = FALSE to hide computing progression.
set.seed(123)
fviz_nbclust(gower_mat, pam, k.max = 20, method = "gap_stat", nboot = 5)+
  labs(subtitle = "Gap statistic method")

#
library(mclust)
# Run the function to see how many clusters
# it finds to be optimal, set it to search for
# at least 1 model and up 20.
d_clust <- Mclust(gower_mat, G=1:20)
m.best <- dim(d_clust$z)[2]
cat("model-based optimal number of clusters:", m.best, "\n")
# 4 clusters
plot(d_clust)


# we could also do:
library(fpc)
asw <- numeric(20)
for (k in 2:20)
  asw[[k]] <- pam(gower_mat, k) $ silinfo $ avg.width
k.best <- which.max(asw)
cat("silhouette-optimal number of clusters:", k.best, "\n")

#############
#Cluster Interpretation
#Via Descriptive Statistics

pam_fit <- pam(gower_dist, diss = TRUE, k = 18)

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
write.csv(clusteroutput, file = "PAMpath_diff.csv", row.names = TRUE)