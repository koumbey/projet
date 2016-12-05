# -*- coding: utf-8 -*-
"""
Created on Mon Dec 05 09:25:19 2016

@author: Administrator
"""

import xlrd;

import nltk;

# chargement des données =====================================================

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
    
#=============================================================================
