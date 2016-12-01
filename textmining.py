# -*- coding: utf-8 -*-
"""
Created on Fri Nov 25 16:21:51 2016

@author: Administrator
"""

import xlrd
import nltk
from math import log

def loadData(filname):
    excel = xlrd.open_workbook(filname);
    sheet = excel.sheet_by_name("Sheet1");
    N = sheet.nrows;
    contenu = [];
    head = sheet.row_values(0);
    for i in range(1,N):
        line = sheet.row_values(i);
        dic ={};
        for j in range(len(line)):
            dic[head[j]]=line[j]
        contenu.append(dic)
    return contenu;

tweet_data = loadData("data.xlsx");

all_content = " ".join([p['Tweet content'] for p in tweet_data])

youpie = len(all_content)

#print(youpie)

tokens= all_content.split()

text = nltk.Text(tokens)

#Pour visualiser les lignes qui contiennent le mot passé en argument
#text.concordance("open")

text_col=text.collocations()

print(type(text_col))

# corpus = a group of tweet
corpus = {
'a' : "Mr. Green killed Colonel Mustard in the study with the candlestick. \
Mr. Green is not a very nice fellow.",
'b' : "Professor Plumb has a green plant in his study.",
'c' : "Miss Scarlett watered Professor Plumb's green plant while he was away \
from his office last week."
}


# spliting and transform words in lower character

terms = {
'a' : [ i.lower() for i in corpus['a'].split() ],
'b' : [ i.lower() for i in corpus['b'].split() ],
'c' : [ i.lower() for i in corpus['c'].split() ]
}


def tf(term, doc, normalize=True):
    doc = doc.lower().split()
    if normalize:
        return doc.count(term.lower()) / float(len(doc))
    else:
        return doc.count(term.lower()) / 1.0
       
       
QUERY_TERMS =["Mr.","Green","the","plant"];
#==================================================================================
def idf(term, corpus):
    num_texts_with_term = len([True for text in corpus if term.lower()
    in text.lower().split()])
    # tf-idf calc involves multiplying against a tf value less than 0, so it's important
    # to return a value greater than 1 for consistent scoring. (Multiplying two values
    # less than 1 returns a value less than each of them)
    try:
        return 1.0 + log(float(len(corpus)) / num_texts_with_term)
    except ZeroDivisionError:
        return 1.0

#=================================================================================

def tf_idf(term, doc, corpus):
    return tf(term, doc) * idf(term, corpus)
"""

# Score queries by calculating cumulative tf_idf score for each term in query
query_scores = {'a': 0, 'b': 0, 'c': 0}
for term in [t.lower() for t in QUERY_TERMS]:
    for doc in sorted(corpus):
        print 'TF(%s): %s' % (doc, term), tf(term, corpus[doc])
        print 'IDF: %s' % (term, ), idf(term, corpus.values())
        print
    for doc in sorted(corpus):
        score = tf_idf(term, corpus[doc], corpus)
        print 'TF-IDF(%s): %s' % (doc, term), score
        query_scores[doc] += score
        print
print "Overall TF-IDF scores for query '%s'" % (' '.join(QUERY_TERMS), )
for (doc, score) in sorted(query_scores.items()):
    print doc,score;

"""
#==================================================================================
"""buzz_data = loadData("data.xlsx");
QUERY_TERMS = ["home","office","country"]
all_posts = [post['Tweet content'].lower().split() for post in buzz_data]
# Provides tf/idf/tf_idf abstractions
tc = nltk.TextCollection(all_posts)

relevant_posts = []
for idx in range(len(all_posts)):
    score = 0
    for term in [t.lower() for t in QUERY_TERMS]:
        score += tc.tf_idf(term, all_posts[idx])
    if score > 0:
        relevant_posts.append({'score': score})
# Sort by score and display results
relevant_posts = sorted(relevant_posts, key=lambda p: p['score'], reverse=True)
for post in relevant_posts:
    print '\tScore: %s' % (post['score'], )"""

