import nltk
import pandas as pd
from nltk.tokenize import TweetTokenizer
from nltk.corpus import stopwords

excel = pd.ExcelFile('./tweets_clasificados.xlsx')
df = excel.parse('tweets')
tokenizer = TweetTokenizer(strip_handles=True, reduce_len=True, preserve_case=False)

some_words = ['cada', 'asi', 'años', 'aún', 'aunque', 'pues', 'hace', 'tras']


def word_tokenize(sentence):
    tweet_words = [word for word in tokenizer.tokenize(sentence)
                   if word.isalpha() and (word not in stopwords.words('spanish'))
                   and (word not in some_words) and len(word) > 2]
    return tweet_words


all_words = []
for index, row in df.iterrows():
    cleaned_words = word_tokenize(row['tweet'])
    df.tweet[index] = ' '.join(cleaned_words)
    all_words = all_words + [word for word in cleaned_words]
freq = nltk.FreqDist(all_words)
# tup[0]: word, tup[1]: frequency
all_words = [tup[0] for tup in freq.most_common()][:400]

t = [({word: (word in row['tweet'].split(' ')) for word in all_words}, row['clase']) for i, row in df.iterrows()]

train_set, test_set = t[:4000], t[4000:]
classifier = nltk.NaiveBayesClassifier.train(train_set)
print('Precision: ', nltk.classify.accuracy(classifier, test_set))
classifier.show_most_informative_features()
