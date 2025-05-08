# Slavery Time Series Analysis 📈

## Aim  
The aim of this project is to analyze historical estimates of global slavery using time series methods in R. It focuses on uncovering long-term trends, identifying residual patterns, and modeling short-term dependencies to forecast future values.

## Dataset  
- **Source**: Provided as `slavery.RData`
- **Format**: RData file (data frame)
- **Features**:
  - `year`: Observation year  
  - `num`: Estimated number of slaves  
  - `time`: Time index (created during analysis)

## 🧪 Methodology  

1. **Data Preprocessing**  
   Loaded and explored the dataset. Created a time index and cleaned missing values in AR residuals.

2. **Trend Analysis**  
   Used linear regression to model trends and extracted residuals.

3. **ACF & PACF Diagnostics**  
   Analyzed residual autocorrelation patterns to determine appropriate AR model order.

4. **Model Fitting**  
   Fitted AR(1), AR(2), and AR(3) models using Yule-Walker estimation. Replaced NA values in residuals.

5. **Spectral Analysis**  
   Computed raw and log periodograms using both base R and TSA package, and manually using FFT.

6. **Forecasting**  
   Applied ARIMA models to adjusted series to predict future values. Visualized fitted vs. original data.

## 📊 Results  

- Identified significant autocorrelation in residuals  
- AR(1) and AR(3) models gave better residual behavior  
- Periodograms showed cyclical behavior in the data  
- ARIMA-based predictions extended trend into near future


## 🛠️ Requirements  

- R 4.0+  
- R packages:  
  - `TSA`  
  - `stats`, `graphics`, `grDevices` (base R)

Install missing packages with:

```R
install.packages("TSA")
```

## Documentation
For complete analysis and conclusions, please refer to this **[Documentation](https://github.com/omkarr7/Time-Series-and-Spectral-Analysis/blob/main/201694894_OmkarPawar_MATH5802.pdf)**
