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
