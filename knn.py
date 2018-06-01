import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import accuracy_score

# Read csv
df = pd.read_csv('Data_Cortex_Nuclear.csv')
# Set index the column MouseID
df.set_index('MouseID')

# Get the X data encoding the string values as Genotype, Treatment, Behavior
X = df.iloc[:, :-1].apply(LabelEncoder().fit_transform)
x_values = X.values
# Get the output desired
y = df.iloc[:, 81]
y_values = y.values

# Split training and test data
X_train, X_test, y_train, y_test = train_test_split(x_values, y_values, test_size=0.20)

# Create KNN Classifier
knn = KNeighborsClassifier(n_neighbors=5)
# Fit classifier
knn.fit(X_train, y_train)
# Predict and get accuracy score
print('Accuracy score: ', accuracy_score(y_test, knn.predict(X_test)))
