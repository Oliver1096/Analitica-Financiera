#install.packages('fpp2')
#install.packages('fpp3', "PerformanceAnalytics", "xts", 'quantmod', "fUnitRoots")
#install.packages('forecast', 'ggplot2', 'tseries', 'lmtest', 'TSA', 'Metrics', 'FitAr')

library(fpp2)
library(fpp3)
library(PerformanceAnalytics)
library(quantmod)
library(fUnitRoots)
library(forecast)
library(ggplot2)
library(lmtest)
library(TSA)
library(Metrics)
#library(FitAr)
options(digits = 3)
options(warn = -1)

#Obtener precios del activo

AMZN = getSymbols("AMZN", from = "2020-08-01", to = "2021-03-31", src = "yahoo", 
                  auto.assign = FALSE)

#Eliminamos valores faltantes
AMZN <- na.omit(AMZN)

AMZN <-AMZN[,4]

#Graficamos
plot(AMZN, ylab="Precios")
length(AMZN)

#Partimos la serie
h <- round(length(AMZN) * 0.07, digits =  0)
h
train <- AMZN[1:(nrow(AMZN) -h),]
test <-AMZN[(nrow(AMZN)-h+1): nrow(AMZN),]

###MODELO ARIMA##

#Validar si la serie es estacionaria
adfTest(train) #si P_value es mayor a 0.05 no se puede rechazar la H nula que es la presencia de una raiz unitaria y seria una serie no estacionaria

#Para solucionarlo, trabajamos con diferencias en lugar de datos en niveles
dtrain<- diff(train)[-1,]
adfTest(dtrain) #como ya es p value menor a 0.05 podemos decir que ya es unitaria
#adf.test(dtrain) #esta es solo una alternativa al comando anterior

#Graficamos
par(mfrow= c(2,1))
plot(train, col = "red")
plot(dtrain, col= "blue")

# Ya estacionaria, podemos definir candidatos de modelo ARMA
#library(ATS)
m <-eacf(dtrain,15,10) #seria un ARMA(7,3) pero si se desea expresar como una ARIMA sería: ARIMA (7,1,3) 1 expresa la differenciacion que se tuvo que apicar a la serie para volverla estacionaria
summary(m)

#Definimos otros modelos mediante la funcion auto arima
m2 <- auto.arima(train, seasonal = T)
summary(m2) #seria un arima (1,0,0)


#MODELACION
mod1 <- Arima(train, order = c(7,1,3), method = "ML")
summary(mod1)
coeftest(mod1)
tsdiag(mod1)

mod2 <- Arima(train, order = c(1,0,0), method = "ML")
summary(mod2)
coeftest(mod2)
tsdiag(mod2)

#Pronosticos
#library(FitAr)
#install
library(tseries)
pron_m1<-forecast(mod1,h)
pron_m2<-forecast(mod2,h)
summary(pron_m1)
summary(pron_m2)
#ambos tienenun AIC muy similar

#Graficos
par(mfrow=c(2,1))
plot(pron_m1, include = 50)
plot(pron_m2, include = 50)

#Otro grafico opcional

traints<-ts(train, start = c(2020,08,01), frequency = 154)
fitted1<-ts(mod1$fitted, start = c(2020,08,01), frequency = 154)
fitted2<-ts(mod2$fitted, start = c(2020,08,01), frequency = 154)
pron1<-ts(pron_m1$mean,start = c(2021,08), frequency = 154)
pron2<-ts(pron_m2$mean, start = c(2021,08), frequency = 154)

autoplot(traints) + 
  autolayer(fitted1, series = "ARIMA (7,1,3)") + 
  autolayer(fitted2, series = "ARIMA (1,0,0)") + 
  autolayer(pron1, series = "Pron ARIMA (7,1,3)") +
  autolayer(pron2, series = "Pron ARIMA (1,0,0)")

#Calculamos el error de pronostico RMSE Y MAPE:
RMSE_arima<-rmse(test, pron_m1$mean)
RMSEar1<-rmse(test,pron_m2$mean)

MAPE_arima<-mape(test, pron_m1$mean)
MAPEar1<- mape(test, pron_m2$mean)

#Mostramos los resultados del modelo
Modelo<-c("ARIMA(7,1,3)", "AR(3)")
RMSE<-c(RMSE_arima, RMSEar1)
MAPE<-c(MAPE_arima, MAPEar1)
res<-data.frame(Modelo, RMSE, MAPE)
print((res))
#REVISAR EL RMSE

#MODELOS SUAVISAMIENTO EXPONENCIAL
#Obtenemos los precios de AMZN
AMZN<- getSymbols("AMZN", from= "2020-08-01", to = "2021-03-31", src = "yahoo", auto.assign = F)
AMZN<- na.omit(AMZN)

#Mantenemos precios de cierre
AMZN <- AMZN[,4]

#graficamos
plot(AMZN, ylab= "Precios")
length(AMZN)

#Dividimos la serie
h<-round(length(AMZN)*0.07, digits = 0)
h
train<-AMZN[1:(nrow(AMZN)-h),]

#graficamos 
plot(train, col = "red")
traints<-ts(train, start = c(2020,08,01), frequency=154)
plot(traints)

#No hay una estacionalidad evidente, por lo que probamos modelos de suavizamiento simples
#Posibles enfoques de suavizamiento

#Primer Modelo
fit1<-ses(traints,h=12)
summary(fit1) #Alpha cercano a 1  
ffit1<-forecast(fit1, h=12)
autoplot(fit1) + autolayer(fitted(fit1))


##Segundo Modelo
#Tendencia Lineal con Holt, podríamos probar aun este aunque no hay tendencia evidente
fit2<-holt(traints, h=12)
summary(fit2)
ffit2<-forecast(fit2, h=12)
autoplot(fit2) + autolayer(fitted(fit2))
