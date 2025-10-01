#Modelo ANN para pronóstico

## Red neuronal tipo Feed Forward

library(forecast)
library(ggplot2)
library(quantmod)

#Obtenemos precios de AMZN
AMZN <- getSymbols("AMZN", from= "2020-08-01", to= "2021-03-31", src="yahoo", auto.assign = F)
#Omitimos valores faltantes
AMZN <- na.omit(AMZN)
#mantenemos columnas con precios de cierre columna 4
AMZN <- AMZN[,4]
#Graficamos
plot(AMZN, ylab= "Precios")
length(AMZN)
#Partimos serie y tomamos el 7% para la prueba
h <- round(length(AMZN)*0.07, digits = 0)
h
train <- AMZN[1:(nrow(AMZN)-h),]
#######################################################
## A partir de los mismos datso graficamos la serie
plot(train, col="red")
autoplot(train)

##Comenzamos a generar los modelos
##Generamos la funcion de pronostico, En datos de precios se deben trandformar los datos en lambda
#para tratar que los residuos sean cercanos a homocedasticos
nn1<- nnetar(train, lambda = T)
nn1 #lo que vemos son 12 resagos en la primera capa con 6 nodos en la capa oculta

autoplot(forecast(nn1,PI=T, h=12)) #grafica hasta el 12 pronostico
autoplot(forecast(nn1,PI=T, h=12), include = 50) #tenemos la oportunidad de incluir los ultimos 50 valore de la serie y asi poder ver con mejor detalle el pronostico
fnn1<-forecast(nn1,h=12) #Generamos el objeto forecast para poder comparar con los errores

#AR nivel, recordemos que en la primera parte, teniamos un modelo ARMA con la parte AR(7)
#que podemos incluir:

nn2<-nnetar(train, p=7, lambda = T) #7 resagos 
nn2
autoplot(forecast(nn2,PI= T, h=12))
fnn2<-forecast(nn2,h=12)

##Calculo de las metricas de error de pronostico
library(Metrics)
RMSE_nnetar<- rmse(test, fnn1$mean)
MAPE_nnetar<- mape(test, fnn1$mean)
RMSE_nnetar2<- rmse(test, fnn2$mean)
MAPE_nnetar2<- mape(test, fnn2$mean)

##Imprimimos los resultados
Modelo<-c("ARIMA(7,1,3", "AR(3", "ses", "holt", "Hw", "ets", "nnetar_z", "nnetar_ar7")
RMSE<-c(RMSE_arima, RMSEar1, RMSEses, RMSEholt, RMSE_Hw)
#Min6:30