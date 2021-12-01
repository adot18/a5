#!/usr/bin/env bash

# AUTHOR:  Jennifer Benbow
# DATE:    2021-11-30
# USAGE:   bash text_binary_classify.sh <absolute_path_to_weka_java> <path_to_directory_with_classes_and_files_to_train_upon>
# EXAMPLE: bash text_binary_classify.sh /home/benbow/a5/weka-3-8-5/weka.jar /home/benbow/a5/REVIEWS

# setting CLASSPATH based on user provided argument 1
export CLASSPATH=$CLASSPATH:$1

# converting to .arff
java weka.core.converters.TextDirectoryLoader -dir $2 > output.arff

# converting to word vector
java -Xmx2048m weka.filters.unsupervised.attribute.StringToWordVector  -i output.arff -o output-training.arff -M 2

# run classifier
java -Xmx2048m  weka.classifiers.meta.ClassificationViaRegression -W weka.classifiers.trees.M5P -num-decimal-places 4  -t output-training.arff -d output-training.model -c 1

