# -*- coding: utf-8 -*-
"""
Created on Fri Nov 25 16:21:51 2016

@author: Administrator
"""

import xlrd
import nltk

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

print(youpie)

tokens= all_content.split()

text = nltk.Text(tokens)

#Pour visualiser les lignes qui contiennent le mot passé en argument
text.concordance("open")

