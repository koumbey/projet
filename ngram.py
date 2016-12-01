# -*- coding: utf-8 -*-
"""
Created on Thu Dec 01 10:17:40 2016

@author: Administrator
"""


import nltk
import xlrd
# Load in human readable text from wherever you've saved it
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

buzz_data = loadData("data.xlsx");

N = 25

all_tokens = [token for post in buzz_data for token in post['Tweet content'].lower().split()]
finder = nltk.BigramCollocationFinder.from_words(all_tokens)

finder.apply_freq_filter(2)
finder.apply_word_filter(lambda w: w in nltk.corpus.stopwords.words('english'))
scorer = nltk.metrics.BigramAssocMeasures.jaccard
collocations = finder.nbest(scorer, N)
for collocation in collocations:
    c = ' '.join(collocation)
    print c