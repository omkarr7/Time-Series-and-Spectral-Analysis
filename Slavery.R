rm(list = ls())
load('path/to/your/file')

# Explore data
str(xf)
X <- xf$num
xf$time <- 1:nrow(xf)

# Plot original data with trend line
par(mfrow = c(1, 1))
plot(xf$year, xf$num, col = 'blue', xlab = 'Year', ylab = 'Estimated Number of Slaves')
lines(xf$year, xf$num, col = 'black', lty = 'dotted')

# Linear model
model <- lm(num ~ year, data = xf)
abline(model, col = 'red')
xf$values <- model$fitted.values

# Residuals
Y <- residuals(model)
plot(xf$year, Y, type = 'l', col = 'blue', xlab = 'Year', ylab = 'Residuals after Removal of Trends')

# ACF and PACF
acf(Y, main = "ACF of Y")
pacf(Y, main = "PACF of Y")

# Fit AR models
ar_1 <- ar(Y, order.max = 1, method = 'yule-walker', aic = FALSE)
ar_2 <- ar(Y, order.max = 2, method = 'yule-walker', aic = FALSE)
ar_3 <- ar(Y, order.max = 3, method = 'yule-walker', aic = FALSE)

# Replace NA residuals with 0
ar_list <- list(ar_1, ar_2, ar_3)
for (i in 1:3) {
  ar_list[[i]]$resid[is.na(ar_list[[i]]$resid)] <- 0
}

ar1_residuals <- ar_list[[1]]$resid
ar2_residuals <- ar_list[[2]]$resid
ar3_residuals <- ar_list[[3]]$resid

# Plot residuals and correlograms
par(mfrow = c(3, 3))
for (res in list(ar1_residuals, ar2_residuals, ar3_residuals)) {
  plot(res, type = 'l', main = paste('Residuals for AR(', which(list(ar1_residuals, ar2_residuals, ar3_residuals) == res), ')'))
  acf(res, main = "ACF")
  acf(res^2, main = "ACF of Squared Residuals")
}

for (res in list(ar1_residuals, ar2_residuals, ar3_residuals)) {
  pacf(res, main = "PACF")
  pacf(res^2, main = "PACF of Squared Residuals")
}

# Assign final residuals
Z <- ar3_residuals

# Periodograms using spec.pgram
par(mfrow = c(3, 1))
spec.pgram(X, taper = 0, log = "no", col = "blue", main = "Periodogram for X")
spec.pgram(Y, taper = 0, log = "no", col = "red", main = "Periodogram for Y")
spec.pgram(Z, taper = 0, log = "no", col = "green", main = "Periodogram for Z")

# Periodograms using TSA
library(TSA)
periodogram(X, log = 'no')
periodogram(Y, log = 'no')
periodogram(Z, log = 'no')

# Manual FFT-based periodogram
dft_list <- lapply(list(X, Y, Z), function(ts) fft(ts) / sqrt(length(ts)))
I_list <- lapply(dft_list, function(dft) Mod(dft)^2)
n <- length(X)

par(mfrow = c(3, 3))
labels <- c("X", "Y", "Z")
for (i in 1:3) {
  plot(get(labels[i]), type = 'l', ylab = labels[i], main = labels[i])
  plot((0:(n - 1)) / n, I_list[[i]], type = "h", xlab = expression(f[j]), ylab = expression(I(f[j])))
  title(main = paste("Raw periodogram of", labels[i]))
  plot((0:(n / 2)) / n, I_list[[i]][1:(n / 2 + 1)], type = "h", log = "y", xlab = expression(f[j]), ylab = expression(log(I(f[j]))))
  title(main = paste("Raw log periodogram of", labels[i]))
}

# ARIMA modeling
arima_final <- arima(Z, order = c(1, 0, 0))
summary(arima_final)

# Fit and predict using AR residuals
fit_models <- list()
predictions <- list()
residual_sets <- list(ar1_residuals, ar2_residuals, ar3_residuals)
orders <- list(c(1,0,0), c(2,0,0), c(3,0,0))
colors <- c("green", "green", "red")

for (i in 1:3) {
  fit_data <- xf$num - residual_sets[[i]]
  fit_models[[i]] <- arima(fit_data, order = orders[[i]])
  predictions[[i]] <- predict(fit_models[[i]], n.ahead = 5)
  
  plot(xf$year, xf$num, type = 'l', main = paste("Forecast using AR(", i, ") residuals"), xlab = "Year", ylab = "Estimated Slaves")
  lines((xf$year[length(xf$year)] - 1):(xf$year[length(xf$year)] + 3), predictions[[i]]$pred, col = colors[[i]])
}
