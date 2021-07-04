################################################################################
#                                                                              #
#                     DECIPTIVOS DE METODOLOGÍA GENERAL                        #
#                                                                              #
################################################################################

#Media Aritmetica
x <- c(12,25,30,12,26,17,23,10,35,20,10,42,23,18) #vector numerico

sum(x)
length(x)
sum(x)/length(x) # la edad promedio es de 25 a?os

mean(x) # una funcion donde obtenemos la media mas rapido

#Mediana
median(x) # percentil 50, o su mediana es de 23

#varianza 
var(x)

#desviacion estandar
sd(x)
# dentro del rando de 12-31 se encuentra el 65% de la data

#coeficiente de variacion CV
round(100*sd(x)/mean(x), 2)

#aplicarlo a auna base de datos de iris
install.packages("tidyverse")

library(tidyverse)
data <- iris

view(iris)
head(iris)
names(iris)

#media de la longitud y anchura de los sepalos y petalos de las rosas por tipo 
#de especie
tapply(data$Sepal.Length, INDEX = data$Species, FUN=mean)
tapply(data$Petal.Length, INDEX = data$Species, FUN=mean)
tapply(data$Petal.Width, INDEX = data$Species, FUN=mean)

################################################################################
#                                                                              #
#              DECIPTIVOS DE METODOLOGÍA DE RESPUESTA AL ÍTEM                  #
#                                                                              #
################################################################################

#DECLARAR IPAK
ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

#CARGAR IPAK
package <- c("parameters","apa","haven","ggplot2","ggpubr","gridExtra","apaTables", "reshape", "GPArotation", "mvtnorm", "psych", "psychometric", "lavaan", "nFactors", "semPlot", "MVN", "semTools")
ipak(package)

#PACMAN
pacman::p_load(tidyverse, lavaan, semPlot)
library(pacman)

#LIBRERIAS
library(psych)
library(dplyr)

da <- DATA
names(da)

# METODO 1
#Policórica
General <- data.frame(select(da, IB1, IB2, IB3, IB4, IB5, IB6, IB7, IB8, IB9, IB10,
                             IB11, IB12, IB13, IB14))

General <- data.frame(select(da, IB1:IB14))

describe(General)

#Tetracórica
General_tetra <- polychoric(General)
describe(General_tetra)

#Confaibilidad básica de los descriptivos TETRACORICOS
alphagen1<-psych::alpha(General, check.keys = TRUE)

alphagen1

#Confaibilidad básica de los descriptivos POLICORICOS
alphagen2<- psych::alpha(General_poly$rho, check.keys = TRUE)
alphagen2


# METODO 2
Desc2 <- psych::describe(select(da, IB1:IB14))

Desc2

write.csv(Desc2, file="Descriptivos.csv")

# METODO 3
#DESCRIBIMOS Y ANALIZAMOS UNA DE LAS VARIABLES
Desc3 <- as.data.frame(psych::describe(select(da, IB1:IB14))) %>%
  round(3) %>%
  select(-trimmed, -mad, -vars) %>%
  relocate(min, max, range, .before = mean) %>%
  relocate(median, .after = mean) %>%
  relocate(sd, .before = se)

ex <- as.matrix(Desc3)

write.csv(Desc3, file="Descriptivos.csv")

library(stargazer)

stargazer(ex, type = "html", out = "Desc3.html")


