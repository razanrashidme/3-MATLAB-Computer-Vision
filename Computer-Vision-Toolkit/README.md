# MATLAB Computer Vision Toolkit

## Project Overview
This repository contains several computer vision tasks implemented using **MATLAB**.
The project focuses on applying basic image processing concepts and understanding how common computer vision techniques work in practice.

## What the Project Does
The project includes different small applications that process images and extract useful information from them, such as object detection, image analysis, and simple transformations.

## Projects Included

### 1. Coin Detection and Classification
This project processes an image to detect coins and classify them based on size.

* **What it does:**
    * Converts the image to binary form using thresholding.
    * Removes noise to improve detection (Median Filter).
    * Detects individual coins using morphological operations.
    * Measures coin size and classifies them as **Large** or **Small**.
* **Output:**
    * Total number of detected coins.
    * Classification results for each coin.

### 2. Image Processing GUI
A simple interactive GUI built in MATLAB that allows users to apply image processing operations.

* **Features include:**
    * Convert images from RGB to **Grayscale** and **Binary**.
    * Edge detection using the **Canny method**.
    * Display image **histograms**.
    * Image inversion (complement).
    * Reset option to return to the original image.

### 3. Basic Image Processing Algorithms
This part focuses on implementing image processing techniques manually to better understand the logic behind them.

* **Includes:**
    * Intensity thresholding logic.
    * Image flipping and mirroring (Geometric Transformations).

## Tools and Technologies
* **Programming Language:** MATLAB
* **Toolbox Used:** Image Processing Toolbox