#LIBRERIAS

library(psych)
library(tidyverse)
library(ggplot2)
library(ggpubr)
library(nortest)
library(plotly)
library(htmlwidgets)
library(Hmisc)
library(ggcorrplot)
library(stargazer)

#DATA

da <- DATA
names(da)

IB <- select(da, IB1:IB14)
IB

#DESCRIPTIVOS

desc <- as.data.frame(psych::describe(select(da, IB1:IB14))) %>%
                       round(3) %>%
                       select(-trimmed, -mad, -vars) %>%
                       relocate(min, max, range, .before = mean) %>%
                       relocate(median, .after = mean) %>%
                       relocate(sd, .before = se)
desc

#SHAPIRO-WILK (-50)

shapiro <- function(x){
  shapiro.test(x)
}

shap <- function(x){
  for(i in 1:ncol(x)){
    i <- shapiro(x[[i]])
    
    print(i)
      
  }
}

shap(IB)


#KOLMOGOROV-SMIRNOV (+50)

kolmogorov <- function(x){
  lillie.test(x)
}

KMO <- function(x){
  for(i in 1:ncol(x)){
    i <- kolmogorov(x[[i]])
    
    print(i)
  }
}

KMO(IB)

#BARPLOT
gr <- ggplot(IB, aes(x=IB1))+
  geom_bar(fill="light blue", alpha=0.5)+
  theme_dark()

#DISPERSION PLOT
gr <- ggplot(da, aes(x=SEXO, y=EDAD))+
        geom_jitter()+
        scale_x_log10()
gr

#Interactivo
pp1 <- ggplotly(gr)

saveWidget(as_widget(pp1), "interactivo.html")

#FRECUENCIAS Y NORMALIDAD UNA VARIABLE

ggplot(da, aes(x = IB1)) + 
  geom_histogram(aes(y =..density..),
                 colour = "#7F7F7F",
                 bins = 14,
                 fill = "pink",
                 alpha = 0.3) +
  stat_function(fun = dnorm, args = list(mean = mean(da$IB1), sd = sd(da$IB1)), colour="red") +
  geom_vline(aes(xintercept=mean(IB1)), colour="blue", linetype="dashed", size=1) +
  theme_dark()



#FRECUENCIAS Y NORMALIDAD VARIAS VARIABLES

histograma <- function(x){
print(ggplot(da, aes(x = x)) + 
  geom_histogram(aes(y =..density..),
                 colour = "#7F7F7F", 
                 fill = "pink",
                 alpha = 0.3,
                 bins = 14) +
  stat_function(fun = dnorm, args = list(mean = mean(x), sd = sd(x)), colour="red") +
  geom_vline(aes(xintercept=mean(x)), colour="blue", linetype="dashed", size=1) +
    theme_dark())
}

GRUPO <- function(x){
    for(i in 1:ncol(x)){
  i <- histograma(x[[i]])
  }
}

pdf("normal.pdf")
GRUPO(IB)



#CORRELACIÓN

corr<- rcorr(as.matrix(IB), type = "pearson")
corr

ggcorrplot(corr$r, hc.order = T, type = "lower", lab = T)

stargazer(data.frame(corr$r), summary = F, type = "html", out = "correlacion.hmtl")
