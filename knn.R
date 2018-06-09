library(readr)
library(class)
library(e1071)

# Function to show results
show_results <- function(preds, test_data, algorithm) {
  error = 0
  for (class in unique(preds)) {
    n_preds_class_x = length(which(preds == class))
    n_data_class_x = length(which(test_data$class == class))
    error_class = abs(n_preds_class_x - n_data_class_x)
    error = error + error_class
    print(paste("(", algorithm, ") Errores en ", classes[as.integer(class)], ": ", error_class))
  }
  
  total = length(preds)
  print(paste("Cantidad de registros de entrenamiento: ", total))
  print(paste("Precision (", algorithm,")", (total - error)/total*100))
}

# Read CSV 
# data <- read_csv("/home/junior/projects/bi/Data_Cortex_Nuclear.csv")
data <- read_csv("C:/Users/preda/Documents/Data_Cortex_Nuclear.csv")
# Ignore ID
data <- data[, -1]
# Set numeric values to string values
data$Genotype = as.integer(as.factor(data$Genotype))
data$Treatment = as.integer(as.factor(data$Treatment))
data$Behavior = as.integer(as.factor(data$Behavior))
classes = as.factor(data$class)
data$class = as.integer(classes)
classes = unique(as.character(classes))

# Set the mean value to blank cells 
data$ELK_N[which(is.na(data$ELK_N))] <- mean(data$ELK_N, na.rm = TRUE)
data$MEK_N[which(is.na(data$MEK_N))] <- mean(data$MEK_N, na.rm = TRUE)
data$DYRK1A_N[which(is.na(data$DYRK1A_N))] <- mean(data$DYRK1A_N, na.rm = TRUE)
data$ITSN1_N[which(is.na(data$ITSN1_N))] <- mean(data$ITSN1_N, na.rm = TRUE)
data$BDNF_N[which(is.na(data$BDNF_N))] <- mean(data$BDNF_N, na.rm = TRUE)
data$NR1_N[which(is.na(data$NR1_N))] <- mean(data$NR1_N, na.rm = TRUE)
data$NR2A_N[which(is.na(data$NR2A_N))] <- mean(data$NR2A_N, na.rm = TRUE)
data$pAKT_N[which(is.na(data$pAKT_N))] <- mean(data$pAKT_N, na.rm = TRUE)
data$pBRAF_N[which(is.na(data$pBRAF_N))] <- mean(data$pBRAF_N, na.rm = TRUE)
data$pCAMKII_N[which(is.na(data$pCAMKII_N))] <- mean(data$pCAMKII_N, na.rm = TRUE)
data$pCREB_N[which(is.na(data$pCREB_N))] <- mean(data$pCREB_N, na.rm = TRUE)
data$pELK_N[which(is.na(data$pELK_N))] <- mean(data$pELK_N, na.rm = TRUE)
data$pERK_N[which(is.na(data$pERK_N))] <- mean(data$pERK_N, na.rm = TRUE)
data$pJNK_N[which(is.na(data$pJNK_N))] <- mean(data$pJNK_N, na.rm = TRUE)
data$PKCA_N[which(is.na(data$PKCA_N))] <- mean(data$PKCA_N, na.rm = TRUE)
data$pMEK_N[which(is.na(data$pMEK_N))] <- mean(data$pMEK_N, na.rm = TRUE)
data$pNR1_N[which(is.na(data$pNR1_N))] <- mean(data$pNR1_N, na.rm = TRUE)
data$pNR2A_N[which(is.na(data$pNR2A_N))] <- mean(data$pNR2A_N, na.rm = TRUE)
data$pNR2B_N[which(is.na(data$pNR2B_N))] <- mean(data$pNR2B_N, na.rm = TRUE)
data$pPKCAB_N[which(is.na(data$pPKCAB_N))] <- mean(data$pPKCAB_N, na.rm = TRUE)
data$pRSK_N[which(is.na(data$pRSK_N))] <- mean(data$pRSK_N, na.rm = TRUE)
data$AKT_N[which(is.na(data$AKT_N))] <- mean(data$AKT_N, na.rm = TRUE)
data$BRAF_N[which(is.na(data$BRAF_N))] <- mean(data$BRAF_N, na.rm = TRUE)
data$CAMKII_N[which(is.na(data$CAMKII_N))] <- mean(data$CAMKII_N, na.rm = TRUE)
data$CREB_N[which(is.na(data$CREB_N))] <- mean(data$CREB_N, na.rm = TRUE)
data$BAD_N[which(is.na(data$BAD_N))] <- mean(data$BAD_N, na.rm = TRUE)
data$BCL2_N[which(is.na(data$BCL2_N))] <- mean(data$BCL2_N, na.rm = TRUE)
data$pCFOS_N[which(is.na(data$pCFOS_N))] <- mean(data$pCFOS_N, na.rm = TRUE)
data$H3AcK18_N[which(is.na(data$H3AcK18_N))] <- mean(data$H3AcK18_N, na.rm = TRUE)
data$H3MeK4_N[which(is.na(data$H3MeK4_N))] <- mean(data$H3MeK4_N, na.rm = TRUE)
data$EGR1_N[which(is.na(data$EGR1_N))] <- mean(data$EGR1_N, na.rm = TRUE)
data$TIAM1_N[which(is.na(data$TIAM1_N))] <- mean(data$TIAM1_N, na.rm = TRUE)
data$RAPTOR_N[which(is.na(data$RAPTOR_N))] <- mean(data$RAPTOR_N, na.rm = TRUE)
data$pNUMB_N[which(is.na(data$pNUMB_N))] <- mean(data$pNUMB_N, na.rm = TRUE)
data$NR2B_N[which(is.na(data$NR2B_N))] <- mean(data$NR2B_N, na.rm = TRUE)
data$AMPKA_N[which(is.na(data$AMPKA_N))] <- mean(data$AMPKA_N, na.rm = TRUE)
data$DSCR1_N[which(is.na(data$DSCR1_N))] <- mean(data$DSCR1_N, na.rm = TRUE)
data$RAPTOR_N[which(is.na(data$RAPTOR_N))] <- mean(data$RAPTOR_N, na.rm = TRUE)
data$Bcatenin_N[which(is.na(data$Bcatenin_N))] <- mean(data$Bcatenin_N, na.rm = TRUE)
data$ERK_N[which(is.na(data$ERK_N))] <- mean(data$ERK_N, na.rm = TRUE)
data$GSK3B_N[which(is.na(data$GSK3B_N))] <- mean(data$GSK3B_N, na.rm = TRUE)
data$JNK_N[which(is.na(data$JNK_N))] <- mean(data$JNK_N, na.rm = TRUE)
data$MEK_N[which(is.na(data$MEK_N))] <- mean(data$MEK_N, na.rm = TRUE)
data$TRKA_N[which(is.na(data$TRKA_N))] <- mean(data$TRKA_N, na.rm = TRUE)
data$RSK_N[which(is.na(data$RSK_N))] <- mean(data$RSK_N, na.rm = TRUE)
data$APP_N[which(is.na(data$APP_N))] <- mean(data$APP_N, na.rm = TRUE)
data$SOD1_N[which(is.na(data$SOD1_N))] <- mean(data$SOD1_N, na.rm = TRUE)
data$MTOR_N[which(is.na(data$MTOR_N))] <- mean(data$MTOR_N, na.rm = TRUE)
data$P38_N[which(is.na(data$P38_N))] <- mean(data$P38_N, na.rm = TRUE)
data$pMTOR_N[which(is.na(data$pMTOR_N))] <- mean(data$pMTOR_N, na.rm = TRUE)
data$pP70S6_N[which(is.na(data$pP70S6_N))] <- mean(data$pP70S6_N, na.rm = TRUE)

# Shuffle data
data = data[sample(nrow(data), nrow(data)), ]
train_data <- data[1:950, ]
test_data <- data[951:1080, ]

# KNN
preds_knn_model <- knn(train = train_data, test = test_data, cl = train_data$class, k = 32)
print(table(preds_knn_model, test_data$class))
show_results(preds = preds_knn_model, test_data = test_data, algorithm = "KNN")

# Bayes
bayes_model <- naiveBayes(as.factor(class) ~ ., data = train_data)
preds <- predict(bayes_model, test_data)
print(table(preds, test_data$class))
show_results(preds = preds, test_data = test_data, algorithm = "Bayes")