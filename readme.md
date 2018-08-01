# Thesis Data 0.0.1

(c) by Lukas Pollmann

This Repository is part of my master thesis

# In the local version the other repos are also part of the disk

Thesis data is a data set created for my master thesis on the 
classification of openAPI specification JSON Files. 

You will find all relevant files of my design research process

:no_entry: The code for the PoC of the classifier can be found in this [repository](https://github.com/pmanlukas/colab)

:no_entry: The code for the linear SVM based classifier for benchmarking can be found in this [repository](https://github.com/pmanlukas/colabSVM)

:no_entry: The code for an example implementation of the classifier as api can be found in this [repository](https://github.com/pmanlukas/classifierAPI)

:no_entry: The code for the static web page for the dataset can be found in this [repository](https://github.com/pmanlukas/datasetWeb)


## Here a short discription on the Notebooks:


- Analyse Cluster (Diff): notebooks that analyze the results of the clustering
- classes verification: notebook showing the underlying samples of the clusters resulting from the clustering
- Data exploration - paths: notebook analyzing the path objects of each sample and creating dataframes for clustering
- clustering: notebook clustering the data set samples regarding structure and its content
- combine dataframes: notebook showing results of the clustering in R and comparing the results of each approach
- Data exploration - completness: notebook analyzing the completeness of fields of the samples
- cortical api tests: notebook playing around with the cortical API
- dataset labels creation and export: notebook consolidating the results of clustering in classes and uploading the resulting data sets to blobs
- category playground: notebook to examine the categories of the dataset
- versions: notebook to check and compare versions of the samples in the dataset
- variance_cluster: notebook to check the variance between the different versions of the data set samples and differences in the clusters
- download specs: notebook used to download the raw data for the dataset
- get_data_apiguru: notebook used to explore and interact with the api guru database api

## Here a short discription on the folders:
- .idea: folder of Pycharm (only binaries, will be deleted)
- R - scripts clustering: folder will contain all R scripts and files used in project
- clustering results: folder containing all files and results of clustering approaches
- notebooks html: the html version of the used Jupyter Notebooks
- obj: folder containing all pickle objects used in the design process
- specs: folder containing all data regarding the specifications
- visualization: folder containing other visualizations
- enviroment: folder containing the used anaconda enviroment as yaml file

### The other files are currently still in active usage. Over time they are consolidated in existing or new folders!
