# Slavery Time Series Analysis

This project investigates historical estimates of slavery using time series techniques in R. It performs trend analysis, AR model fitting, and frequency-domain analysis through periodograms and spectral analysis.

## Contents

- **slavery_analysis.R**: Main analysis script
- **slavery.RData**: Dataset containing yearly estimates of slavery
- **README.md**: Project overview

## Key Features

- Visualizes trends in historical slavery data
- Fits a linear regression to capture long-term trends
- Computes residuals and analyzes autocorrelation (ACF/PACF)
- Fits AR(1), AR(2), and AR(3) models using Yule-Walker method
- Performs spectral analysis using:
  - Periodogram (base R and TSA package)
  - Manual FFT-based spectral density estimation
- Forecasts future values using ARIMA models

## Requirements

- R (version 4.0+ recommended)
- R packages:
  - `TSA`
  - `stats`
  - `graphics`
  - `grDevices`

You can install the `TSA` package with:

```R
install.packages("TSA")
