import pandas as pd
from sklearn.model_selection import RepeatedKFold
from sklearn.preprocessing import LabelEncoder
from sklearn.neighbors import KNeighborsClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.metrics import accuracy_score

# Read csv
df = pd.read_csv('pregunta-4-seguros.csv')
# Set index the column MouseID
df.set_index('ID')

# Get the X data encoding the string values as Genotype, Treatment, Behavior
X = df.iloc[:, :-1].apply(LabelEncoder().fit_transform)
x_values = X.values
# Get the output desired
y = df.iloc[:, 8]
y_values = y.values

# Create KNN Classifier
n_fold = 10
knn = KNeighborsClassifier(n_neighbors=5)
bayes = GaussianNB()

kf = RepeatedKFold(n_splits=n_fold, n_repeats=n_fold)
knn_accuracy_score = 0
bayes_accuracy_score = 0


for train, test in kf.split(x_values):
    X_train, X_test, y_train, y_test = x_values[train], x_values[test], y_values[train], y_values[test]
    # Fit KNN
    knn.fit(X_train, y_train)
    # Predict and get accuracy score
    knn_accuracy_score = knn_accuracy_score + accuracy_score(y_test, knn.predict(X_test))
    # Fit Bayes
    bayes.fit(X_train, y_train)
    # Predict and get accuracy score
    bayes_accuracy_score = bayes_accuracy_score + accuracy_score(y_test, bayes.predict(X_test))

print("KNN Accuracy Score(10-fold): ", knn_accuracy_score / (n_fold*n_fold))
print("Bayes Accuracy Score(10-fold): ", bayes_accuracy_score / (n_fold*n_fold))
