#!/bin/bash
# NVIDIA Jetson TX2
# Install TensorFlow dependencies
# Install Java
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install openjdk-8-jdk -y
# Install other dependencies
sudo apt-get install zip unzip autoconf automake libtool curl zlib1g-dev maven -y
# Install Python 3.x
sudo apt-get install python3-numpy swig python3-dev python3-pip python3-wheel python3-h5py -y 

pip3 install keras_application keras_prepocessing
