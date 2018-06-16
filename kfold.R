library(readr)
library(class)
library(caret)

# Read CSV 
data <- read_csv("/home/junior/projects/bi/pregunta-4-seguros.csv")

# Ignore ID
data <- data[, -1]
data$Casado = as.integer(as.factor(data$Casado))
data$`Tienes Hijos` = as.integer(as.factor(data$`Tienes Hijos`))
data$Trabaja = as.integer(as.factor(data$Trabaja))
data$`Tipo vivienda` = as.integer(as.factor(data$`Tipo vivienda`))
data$`Hace deporte` = as.integer(as.factor(data$`Hace deporte`))
data$Ofrecer = as.integer(as.factor(data$Ofrecer))

flds <- createFolds(data$Ofrecer, k = 10, list = TRUE, returnTrain = FALSE)

trControl <- trainControl(method  = "repeatedcv",
                          number  = 10,
                          repeats = 10)

fit <- train(Ofrecer ~.,
             method     = "knn",
             tuneGrid   = expand.grid(k = 1:10),
             trControl  = trControl,
             na.action  = na.omit,
             data       = data)

print(fit)