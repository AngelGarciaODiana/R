library(lavaan)
library(tidyverse)
library(xlsx)

Model.esp <- '
X1
X2
M1
M2
Cor
Cov
Total:=xn+xn(mn+mn)
Prop:=(mn+mn)/total'

Model.est<- sem(Model.esp, data = espa, estimator = "WLSMV")
print(parameterestimates(Model.est) %>%
        filter(op!="~~") %>%
        select(label, est, se, z, pvalue, ci.lower, ci.upper), digits = 3)

summary(Model.est, fit.measures = TRUE, standardized = TRUE, modindices = TRUE, rsq= TRUE)

param <- parameterestimates(Model.est)
write_excel_csv(param, file = "param.csv", append = FALSE)

param.boot <- parameterEstimates(Model.est,
                                 boot.ci.type = "bca.simple",
                                 level = .95, ci = TRUE,
                                 standardized = TRUE)

write_excel_csv(param.boot, file = "param-boot.csv", append = FALSE)


#GRAFRICO 1
semPlot::semPaths(Model.est, "std", layout="tree2", rotation = 2, 
                  residuals=FALSE, nCharNodes = 0, edge.label.cex =1, 
                  legend=FALSE, style = "lisrel", sizeLat=5, sizeMan = 5)

#GRAFICO 2
semPaths(Model.est, "model", "std", layout = 'spring',
         label.cex=1, edge.label.cex=0.5, fade=FALSE)


