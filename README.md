# Analítica Financiera

## Componentes de una serie financiera

Las series financieras se encuentran compuestas de 2 componentes: uno **sistemático** y uno **no sistemático**.

**Componente sistemático**

* Nivel: Valor medio de la serie.
* Tendencia: cambio en la serie de un periodo a otro.
* Estacionalidad: patrón ciclico de la serie.

**Componente no sistemático**

* Ruido: variación aleatoria que resulta de la diferencia entre un valor estimado y el observado.


**Existen dos metodos para estudiar las series de tiempo**: Los basados en modelos y los basados en datos.

1. **Métodos basados en modelos**

- Emplean modelos estadísticos, matemáticos u otros para aproximarse a los datos de la serie.
- Los datos de la serie de parten en entrenamiento y prueba, donde los entrenamientos se utilizan para estimar parámetros. Por su parte, los parámetros estimados, sirven para estimar pronósticos. 
  
2. **Métodos basados en datos**
- Metodos que permiten que los algoritmos aprendan de los patrones de los datos.
- Incluyen métodos de suavizamiento.

METODOS DE SUAVIZAMIENTO


  
## Comportamiento y pronóstico

* Método Holt Winters
* ARIMA
* Arboles de deicisión
* Análisis de Espectro Singular


Para elegir el mejor modelo que sirva para describir y pronosticar, se suelen utilizar méticas de desempeño para determinarlo:

* Métricas dentro de la muestra
* Métricas de Pronóstico
* Revisión de los residuales


## Métricas de desempeño de Modelos

*Usualmente en modelos supervisados como los de regresión ARIMA, redes neuronales, de suavizamiento exponencial y otros, los datos para el análisis se parten en una sección de entrenamiento o training y en otro de prueba o test, para derivar métricas de error “dentro y fuera de la muestra” o “training and testing”, respectivamente a los datos.*

Tenemos por otro lado las métricas de error en el pronóstico. Para ello, definamos primero qué es el error. El error del pronóstico es la diferencia entre el valor pronosticado a 
$t + h$ menos el valor real en ese punto (este último, que representa el conjunto de datos reservados para la prueba); quedando:

<p align="center">$e_t = real_i - Observando_i$</p>

Entonces, si, por ejemplo, el modelo genera pronósticos que tienden a sub estimar el resultado, los errores serán positivos y, por el contrario, si el modelo tiende a sobre pronosticar el valor, el error será negativo. 

Existen muchas métricas de error del pronóstico, pero básicamente se clasifican en aquellas que cuantifican el sesgo y la precisión del pronóstico. El sesgo representa el error promedio histórico o el qué tanto el pronóstico de la serie se aleja del valor real (ej. sobre-pronostica, sub-pronostica o pronostica en el promedio de los datos). Este es simplemente el promedio de los errores:

<p align="center">$sesgo = \frac{1}{n} \sum_{t=1}^{n} e_t$</p>

Donde $n$ es el número de periodos a analizar el sesgo del error, ya sea sobre el pronóstico, sobre los datos históricos o la serie completa.
La precisión mide el qué tan separados o qué tanto margen hay entre los valores del pronóstico a los valores reales; este da una idea de la magnitud del error, pero no de su dirección general, como el sesgo. 

Veamos todos estos a continuación.


### Criterio AIC

Conocido como Criterio de información de Akaike (AIC). Este se desarrolló tomando como base la teoría de la información y, por consiguiente, sirve para medir la cantidad de información que el investigador perderá si emplea un modelo en particular. De ahí, que el criterio AIC mide qué tan “bien” se ajusta el modelo para un conjunto de datos mediante máxima verosimilitud. La ecuación con la que se calcula el AIC es: 

La teoría de la información es una rama de las matemáticas, que busca cuantificar o medir la información. 

<p align="center">$AIC = 2k - 2ln(L)$</p>

Donde $k$ el número de parámetros estimados o predictores y $L$ es la función de máxima verosimilitud para el modelo estimado.  Así, el mejor modelo es el que tiene menor valor de AIC.

### Criterio BIC

El Criterio de Información Bayesiano (BIC) o también conocido como el criterio de Schwartz, se basa en una medida de evaluación del modelo en términos de sus probabilidades posteriores y, a su vez, está relacionado con el criterio AIC, porque también se ajusta con la función de máxima verosimilitud. Cuando se estima un modelo, puede que el funcionamiento de las probabilidades aumente; por tanto, lo que mide este criterio es qué tan diferentes son las probabilidades; ahora, al igual que ocurre con el criterio AIC, los valores pequeños de BIC corresponden a un *training error* bajo; es decir, que el mejor modelo será aquél con menor BIC. La fórmula para calcular el BIC es:

<p align="center">$BIC = - 2ln(L) + kln(n)$</p>

Donde:
$k$ es el número de parámetros estimados o predictores, $L$ es la función de máxima verosimilitud para el modelo estimado y $n$ el número de datos. Adicionalmente, cuando se pronostica una serie se emplean métricas, tales como la raíz del error cuadrático medio (RMSE por sus siglas en ingles), o el error porcentual absoluto medio (MAPE por sus siglas en ingles), que son instrumentos útiles cuando de determinar el mejor modelo se trata.

### RMSE

La raíz del error cuadrático medio (RMSE), también denominada Raíz de la Desviación Cuadrática Media, ayuda a pronosticar el promedio del pronóstico, comparando el valor pronosticado o predicho con el valor real u observado. Esta métrica ha sido muy empleada como métrica estadística estándar para evaluar el desempeño de los modelos, dando un sentido tanto para sesgo como para precisión. Es una de las métricas más empleadas, a pesar de que es muy sensible a valores pronosticados extremos que dan errores mayores (ejemplo, si tenemos un solo valor de error muy alto), penalizará significativamente la métrica, por lo que valores bajos de error, aseguran pronósticos con sesgos bajos. Como se ha comentado, este criterio de selección es pertinente cuando se usa aprendizaje automático supervisado. Para entender mejor la operatividad del RMSE, se va a calcular el error cuadrático medio usando una regresión lineal, sin perjuicio de que pueda ser empleado en otros modelos de pronósticos. Como se muestra en la figura 1, los puntos azules corresponden a los valores reales y la línea roja a los valores arrojados por el modelo de regresión lineal, por lo tanto, el error se grafica con las líneas anaranjadas. 

Luego, se eleva al cuadrado para que la medida siempre sea positiva y además sea derivable. Así, la expresión sería la siguiente: 

<p align="center">$Error Cuadratico = (real_i - Observado_i)^2$</p>

Finalmente, se suman todos los errores, el resultado se divide en la cantidad de observaciones y luego se saca la raíz. En general, el RMSE se calcula de la siguiente manera: 

<p align="center">$RMSE = \sqrt{\sum_{i=0}^{n} \frac{(real_i - Observado_i)^2}{n}}$</p>

**La interpretación del RMSE señala que valores más pequeños del error indican un mejor ajuste. Por ejemplo, un valor del RMSE de 1000 es preferible a uno de 1500 y significa que el modelo presenta un error de 1000 unidades.**

### MAPE

El error porcentual absoluto medio o MAPE mide la cantidad de error absoluto en términos porcentuales. Es una de las métricas más empleadas para cuantificar el error del pronóstico y específicamente para medir la precisión. Es una medida ampliamente usada debido a su fácil interpretación, por ejemplo, si el MAPE es de 4 significa que el pronóstico tiene un error del 4%. Este criterio se utiliza para comparar diversos modelos pronosticados. Al igual que el RMSE, el error se calcula como la diferencia entre el valor real versus el pronosticado, la única diferencia es que el error no se eleva al cuadrado, sino que se deja en valor absoluto para que la medida sea positiva. 

<p align="center">$Error absoluto = |real_i - observado_i|$</p>

Luego, se divide por los valores reales para dejarlo en términos porcentuales y, finalmente, se divide por el número de observaciones. Así, la expresión para calcular el MAPE es la siguiente: 

$MAPE = \frac{\sum_{i=1}^{n} \frac{|real_i - Pronostico_i|}{real_i}}{n}$

La interpretación del MAPE coincide con la del RMSE; es decir, que valores más pequeños del error indican un mejor ajuste. Para comprender los conceptos, se ilustrarán los criterios mediante un ejemplo, donde se tiene una serie de datos de la cantidad de pasajeros que se transportan en avión. Primero, se realiza un ajuste y pronóstico mediante el método de Suavizado Exponencial Simple cuya función es “ses() en R”.

Luego, se pronostican mediante el método de suavizado exponencial cuya función es “ets() en R” y el resultado de los errores es el siguiente: 

Por lo tanto, el mejor modelo entre el SES y el ETS es el suavizado exponencial, ya que el criterio Akaike es de 1395 comparado contra 1733 del suavizado exponencial simple. Además, el criterio BIC es de 1448 versus 1742. Finalmente, con respecto a los criterios de pronóstico, el método de suavizado exponencial presenta un mejor ajuste ya que tanto el MAPE como el RMSE son menores. Así que el modelo tenga un MAPE de 2.85 significa que el error del modelo es del 2.85% y el RMSE sea de 10.74 significa que el error es de 10.74 pasajeros. 

Como puede verse, los anteriores criterios son útiles para seleccionar el modelo que mejor se ajuste a los datos y, a su vez, la escogencia de cada criterio dependerá del tipo de interpretación que se busque. 
