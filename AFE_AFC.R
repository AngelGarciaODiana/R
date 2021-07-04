library(haven)
library(psych)
library(tidyverse)
library(Hmisc)
library(GPArotation)
library(skimr)
library(DataExplorer)

#DATA
DATA <- read_sav("DATA.sav")
da <- DATA
names(da)

IC <- na.omit(select(da, IC1:IC22))

IB <- na.omit(select(da, IB1:IB14)+1)
head(IB)

ISW <- na.omit(select(da, ISW1:ISW5))


#VERIFICAMOS CALIDAD
sum(is.na(IB))

library(naniar)
vis_miss(IB)
gg_miss_upset(IB)

library(epiDisplay)
tab1(t(IB), sort.group = "decreasing", cum.percent = TRUE)

IB %>%
  skim()

#EDA (EXPLORATORY DATA ANALYSIS)
ISW %>% create_report(output_file = "calidad",
                        output_dir = "C:/users/angel/desktop/",
                        report_title = "EDA_Report")


#ANÁLISIS FACTORIAL EXPLORATORIO
#Primero debemos tener una preconcepción teórica de lo que deseamos hallar.
#Para la metodología de Rspuesta al ítem, hay muchas formas de identificar factores.
#Entre estos procesos tenemos el PCA (Principal Component Analysis),
#EFA (Exploratory Factor Analysis), CFA (Confirmatory Factor Analysis) y
#Cluster Analysis.

#El Análisis Factorial Exploratorio nos ayuda a identificar factores o dimensiones
#pertenecientes a un conjunto de datos, ordenándolos de acuerdo a su carga factorial
#común, extraida de los diferentes métodos existentes en sus estimadores "ML", "MLR",
#"DWLS", "WLS", "WLSMV".
#Esta puede hacerse a través de diferentes métodos, siendo el más común para
#psicología el método de rotación (ortogonal y oblicua).
#Tener en cuenta lo siguiente:
#(a) los valores de las comunalidades 
#(proceder con el AFE si estos valores son altos);
#(b) el grado de determinación de los factores 
#(número de variables que comprende cada factor; 
#idealmente 3 o 4 variables por factor, aunque en la práctica 
#incluso 2 variables podrían ser suficientes para la identificación 
#e interpretación de un factor determinado);
#(c) la magnitud de las cargas factoriales considerando factores 
#relacionados con el contexto del estudio y la disciplina en la que 
#se trabaja (saturaciones por encima del .40 o .50 pueden ser satisfactorias 
#en la investigación empírica de la ASL);(d) el hecho de que, en ciertas 
#circunstancias, un aumento del tamaño de la muestra pueda compensar 
#cargas factoriales bajas o un número limitado de variables (Velicer & Fava, 1998);
#(e) el grado de coincidencia de las estructuras factoriales derivadas 
#de la aplicación de diferentes métodos del AFE (ACP y AFC).


#COMENZAREMOS ARMANDO UNA FUNCIÓN PARA HALLAR LOS NÚMEROS DE FACTORES RECOMENDADOS
#A TRAVÉS DEL MÉTODO DE PCA.
#ESTO HACERLO A TRAVÉS DE UNA FUNCIÓN:
NFACT <- nfactors(ISW, rotate = "oblimin", fm = "wls", n=8, use = "pairwise", cor = "pearson")
NFACT
summary(NFACT)

#PLANTEAMOS ENTONCES LA FUNCIÓN DE EFA EN EL PAQUETE PSYCH:
afe <- psych::fa(ISW, nfactors = 1, rotate = "oblimin", fm = "wls")
print(afe, digits = 2, cut = 0.3, sort = TRUE)

# COMUNALIDADES
COM <- round(data.frame(afe$communality), 2)

#KMO
corr <- rcorr(as.matrix(IC), type = "pearson")
MSA <- (psych::KMO(corr$r))
KMO <- round(data.frame(MSA[["MSAi"]]), 2)


#Barlett
options(scipen=999)
options(scipen=0)
psych::cortest.bartlett(corr$r, n = 826, diag=TRUE)


#AFC
library("lavaan")
library("semTools")
library("tidyverse")

#Virguliña (~) = altGr+*

Modelo <- "F1=~IC1+IC2+IC3+IC4+IC5+IC6+IC7+IC8+IC9+IC10
           F2=~IC11+IC12+IC13+IC14+IC15+IC16+IC17+IC18+IC19+IC20+IC21+IC22
           IC4~~IC5
           IC1~~IC2"

Modelo <- "F1=~ISW1+ISW2+ISW3+ISW4+ISW5"

fit <- cfa(model = Modelo, data = DATA, estimator="WLSMV", mimic= "Mplus", ordered = TRUE)
summary(fit, fit.measures = TRUE, standardized=T, r=TRUE)

modindices(fit, sort. = TRUE, maximum.number = 15) %>%
  mutate_if(is.numeric, round, digits=3) %>%
  rename(x=lhs, "->"=op, y=rhs)

standardizedSolution(fit) %>%
  filter(op == "=~") %>%
  relocate(ci.lower, ci.upper, .after = est.std) %>%
  dplyr::mutate(
    pvalue = scales::pvalue(pvalue, accuracy = .001,
                            prefix = c("< ", " ", "> ")),
    pvalue = stringr::str_replace(pvalue, "0.", ".")) %>%
  rename(Factor=lhs, Item=rhs) %>%
  select(-op)

round(semTools::reliability(fit), 3)

#PLOT
pdf("AFC_COV_PE.pdf")
semPlot::semPaths(fit, whatLabels = "std",
                                label.cex  = 0.9, label.prop = 0.8,
                                edge.label.cex = 0.8,
                                nCharEdges = 3, nCharNodes = 0,
                                sizeLat = 10, sizeLat2 = 5,
                                sizeMan = 6, sizeMan2 = 2.2,
                                rotation = 2, intercepts = FALSE,
                                thresholds = FALSE, groups = "latents",
                                pastel = T, exoVar = FALSE, edge.color = "black",
                                curvature = 3, curve =1.1,
                                manifests = rev(fit@pta[["vnames"]][["ov"]][[1]]),
                                latents = rev(fit@pta[["vnames"]][["lv"]][[1]]),
                                mar = c(1, 15, 3.5, 15), layout = "tree2")


