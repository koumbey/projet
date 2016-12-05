<TeXmacs|1.99.4>

<style|<tuple|generic|french>>

<\body>
  <doc-data|<doc-title|Projet : Google Buzz: tf-idf, cosinus similarity,
  collocations>|<doc-author|>>

  <new-page>

  <\table-of-contents|toc>
    <vspace*|1fn><with|font-series|bold|math-font-series|bold|Introduction>
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-1><vspace|0.5fn>

    <vspace*|1fn><with|font-series|bold|math-font-series|bold|1<space|2spc>Tests
    du code python contenu dans le chapitre>
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-2><vspace|0.5fn>

    <with|par-left|1tab|1.1<space|2spc>Extraction des donn�es
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-3>>

    <with|par-left|1tab|1.2<space|2spc>Exploration rapide des donn�es
    textuelles avec nltk <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-4>>

    <with|par-left|1tab|1.3<space|2spc>Tf - Idf
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-5>>

    <with|par-left|1tab|1.4<space|2spc>La similarit� en cosinus
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-6>>

    <vspace*|1fn><with|font-series|bold|math-font-series|bold|2<space|2spc>Am�liorations
    apport�es> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-7><vspace|0.5fn>

    <vspace*|1fn><with|font-series|bold|math-font-series|bold|3<space|2spc>Int�r�ts
    de l'�tude > <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-8><vspace|0.5fn>

    <vspace*|1fn><with|font-series|bold|math-font-series|bold|Conclusion>
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-9><vspace|0.5fn>
  </table-of-contents>

  <page-break*>

  <section*|Introduction>

  Ce document pr�sente le projet que nous avons effectu� sur le Google Buzz,
  en utilisant les diff�rents outils tf-idf, cosinus similarity et
  collocations.

  Ce projet s'est inscrit dans le projet en python que nous devions r�aliser
  sous la direction de Jean Philippe Attal � l'EISTI.

  Ce rapport s'attardera sur toutes les diff�rentes ex�cutions que nous avons
  pu r�aliser durant le projet. Nous aborderons tout d'abord les tests du
  code python qui est contenu dans le chapitre que nous avions s�lectionn�,
  puis les am�liorations apport�es � ces codes avant d'expliquer les int�r�ts
  de l'�tude.

  <new-page*>

  <section|Tests du code python contenu dans le chapitre>

  <subsection|Extraction des donn�es>

  <\python-code>
    import os

    import sys

    import buzz

    from BeautifulSoup import BeautifulStoneSoup

    from nltk import clean_html

    import json

    USER = "timoreilly";

    MAX_RESULTS = 100

    # Helper function for removing html and converting escaped entities.

    # Returns UTF-8

    def cleanHtml(html):

    \ \ \ \ return BeautifulStoneSoup(clean_html(html),

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 

    convertEntities=BeautifulStoneSoup.HTML_ENTITIES).contents[0]

    client = buzz.Client()

    posts_data = client.posts(type_id='@public',

    user_id=USER,

    max_results=MAX_RESULTS).data

    posts = []

    for p in posts_data:

    \ \ \ \ # Fetching lots of comments for lots of posts could take a little

    \ \ \ \ # bit of time. Thread pool code from
    mailboxes__CouchDBBulkReader.py could

    \ \ \ \ # be adapted for use here.

    \ \ \ \ comments = [{'name': c.actor.name, 'content':
    cleanHtml(c.content)} for c \ \ \ \ \ in p.comments().data]

    \ \ \ \ link = p.uri

    \ \ \ \ post = {

    \ \ \ \ 'title': cleanHtml(p.title),

    \ \ \ \ 'content': cleanHtml(p.content),

    \ \ \ \ 'comments': comments,

    \ \ \ \ 'link': link,

    \ \ \ \ }

    \ \ \ \ posts.append(post)

    # Store out to a local file as json data if you prefer

    if not os.path.isdir('out'):

    \ \ \ \ os.mkdir('out')

    filename = os.path.join('out', USER + '.buzz')

    f = open(filename, 'w')

    f.write(json.dumps(posts))

    f.close()

    print \<gtr\>\<gtr\> sys.stderr, "Data written to", f.name

    # Or store it somewhere like CouchDB like so...

    # server = couchdb.Server('http://localhost:5984')

    # DB = 'buzz-' + USER

    # db = server.create(DB)

    # db.update(posts, all_or_nothing=True)
  </python-code>

  Ce code permet de recup�rer les donn�es depuis google base en se servant
  d'une API (Buzz-Python-Client). Une fois qu'on les a r�cup�r�es, on les
  transforme en format Json pour les sauvegarder dans un fichier ou dans une
  base de donn�es coucheDB.\ 

  Ces donn�es sont sp�cialement constitu�es des tweets de certains
  internautes.\ 

  Le programme que l'on avait de base ne marchait pas. Car le lien fourni
  dans le chapitre n'existait plus, nous avons recherch� sur internet pour
  r�cup�rer un dataset pour la suite du projet.

  <subsection|Exploration rapide des donn�es textuelles avec nltk>

  Le nltk est un package python pour le traitement automatique des langues
  naturelles. Nous avons tout d'abord effectu� des commandes pour mieux nous
  y familiariser.\ 

  <\python-code>
    import xlrd

    import nltk

    from math import log

    \;

    def loadData(filname):

    \ \ \ \ excel = xlrd.open_workbook(filname);

    \ \ \ \ sheet = excel.sheet_by_name("Sheet1");

    \ \ \ \ N = sheet.nrows;

    \ \ \ \ contenu = [];

    \ \ \ \ head = sheet.row_values(0);

    \ \ \ \ for i in range(1,N):

    \ \ \ \ \ \ \ \ line = sheet.row_values(i);

    \ \ \ \ \ \ \ \ dic ={};

    \ \ \ \ \ \ \ \ for j in range(len(line)):

    \ \ \ \ \ \ \ \ \ \ \ \ dic[head[j]]=line[j]

    \ \ \ \ \ \ \ \ contenu.append(dic)

    \ \ \ \ return contenu;

    \;

    tweet_data = loadData("data.xlsx");

    \;

    all_content = " ".join([p['Tweet content'] for p in tweet_data])

    \;
  </python-code>

  Nous avons test� 3 m�thodes:

  <space|2em>- concordance

  <space|2em>- vocab

  <space|2em>- collocations

  Ces m�thodes suffisent pour cette exploration rapide.\ 

  Pour la concordance, cela permet de lister les documents qui contiennent le
  mot pass� en argument.

  Pour le vocab, la fonction cr�e un objet qui h�rite d'un dictionnaire o�
  les cl�s sont les mots et les valeurs, leur fr�quence.

  Pour la collocation, ou m�me la co-ocurrence, est la fr�quence d'un n-uplet
  de mot.

  <subsection|Tf - Idf>

  Tf signifie Term Frequency en anglais, c'est-�-dire la fr�quence d'un mot
  dans un document (tweet).

  Idf signifie Inverse Document Frequency en anglais, c'est-�-dire l'inverse
  de la fr�quence d'un mot dans le corpus.

  Tf - Idf est simplement le produit des 2.

  <\python-code>
    # fonction qui calcule le TF

    def tf(term, doc, normalize=True):

    \ \ \ \ doc = doc.lower().split()

    \ \ \ \ if normalize:

    \ \ \ \ \ \ \ return doc.count(term.lower()) / float(len(doc))

    \ \ \ \ else:

    \ \ \ \ \ \ \ return doc.count(term.lower()) / 1.0

    \ \ \ \ \ \ \ 

    # fonction qui calcule le IDF

    def idf(term, corpus):

    \ \ \ \ num_texts_with_term = len([True for text in corpus if
    term.lower()

    \ \ \ \ in text.lower().split()])

    \ \ \ \ try:

    \ \ \ \ \ \ \ \ return 1.0 + log(float(len(corpus)) /
    num_texts_with_term)

    \ \ \ \ except ZeroDivisionError:

    \ \ \ \ \ \ \ \ return 1.0\ 

    \ 

    \ # fonction qui calcul le TF-IDF

    \ def tf_idf(term, doc, corpus):

    \ \ \ \ return tf(term, doc) * idf(term, corpus)
  </python-code>

  <subsection|La similarit� en cosinus>

  La similarti� en cosinus est le fait de v�rifier si 2 documents sont
  similaires.\ 

  <\python-code>
    all_posts = [post['Tweet content'].lower().split() for post in buzz_data]

    # Provides tf/idf/tf_idf abstractions for scoring

    tc = nltk.TextCollection(all_posts)

    # Compute a term-document matrix such that td_matrix[doc_title][term]

    # returns a tf-idf score for the term in the document

    td_matrix = {}

    for idx in range(len(all_posts)):

    \ \ \ \ post = all_posts[idx]

    \ \ \ \ fdist = nltk.FreqDist(post)

    \ \ \ \ doc_title = buzz_data[idx]['User Name']

    \ \ \ \ link = buzz_data[idx]['Tweet Id']

    \ \ \ \ td_matrix[(doc_title, link)] = {}

    \ \ \ \ for term in fdist.iterkeys():

    \ \ \ \ \ \ \ \ td_matrix[(doc_title, link)][term] = tc.tf_idf(term,
    post)

    \ \ \ \ # Build vectors such that term scores are in the same
    positions...

    \;

    distances = {}

    for (title1, link1) in td_matrix.keys():

    \ \ \ \ distances[(title1, link1)] = {}

    \ \ \ \ (max_score, most_similar) = (0.0, (None, None))

    \ \ \ \ for (title2, link2) in td_matrix.keys():

    \ \ \ \ \ \ \ \ # Take care not to mutate the original data structures

    \ \ \ \ \ \ \ \ # since we're in a loop and need the originals multiple
    times

    \ \ \ \ \ \ \ \ terms1 = td_matrix[(title1, link1)].copy()

    \ \ \ \ \ \ \ \ terms2 = td_matrix[(title2, link2)].copy()

    \ \ \ \ \ \ \ \ # Fill in "gaps" in each map so vectors of the same
    length can be computed

    \ \ \ \ for term1 in terms1:

    \ \ \ \ \ \ \ \ if term1 not in terms2:

    \ \ \ \ \ \ \ \ \ \ \ \ terms2[term1] = 0

    \ \ \ \ for term2 in terms2:

    \ \ \ \ \ \ \ \ if term2 not in terms1:

    \ \ \ \ \ \ \ \ \ \ \ \ terms1[term2] = 0

    \ \ \ \ # Create vectors from term maps

    \ \ \ \ v1 = [score for (term, score) in sorted(terms1.items())]

    \ \ \ \ v2 = [score for (term, score) in sorted(terms2.items())]

    \ \ \ \ # Compute similarity among documents

    \ \ \ \ distances[(title1, link1)][(title2, link2)] = \\

    \ \ \ \ nltk.cluster.util.cosine_distance(v1, v2)

    \ \ \ \ if link1 == link2:

    \ \ \ \ \ \ \ \ continue

    \ \ \ \ if distances[(title1, link1)][(title2, link2)] \<gtr\> max_score:

    \ \ \ \ \ \ \ \ (max_score, most_similar) = (distances[(title1,
    link1)][(title2,link2)], (title2, link2))

    \ \ \ \ print( '''Most similar to %s (%s)\\t%s (%s) \\tscore %s ''' %
    (title1, link1,most_similar[0], most_similar[1], max_score))
  </python-code>

  <new-page>

  <section|Am�liorations apport�es>

  Rien

  <new-page>

  <section|Int�r�ts de l'�tude >

  Le principal int�r�t de notre �tude est de savoir de fa�on rapide et
  pr�cise les int�r�ts des utilisateurs afin de leur proposer des services
  ad�quats et personnalis�s. Nous vendrons donc ces programmes aux
  entreprises commer�antes qui auront plus facilement des clients.\ 

  Nous pouvons aussi proposer nos services � des entreprises qui cherchent �
  mettre des publicit�s personalis�es sur de nombreux sites.

  \;

  <new-page>

  <section*|Conclusion>

  Ce projet nous a permis de manipuler des donn�es via l'outil de
  programmation python, ce qui �tait int�ressant.

  Du point de vue technique, nous avons pu apprendre � manipuler des nouveaux
  outils en python. Si nous n'avions pas les outils pour avancer, nous nous
  sommes renseign�s sur internet pour trouver des informations qui nous
  manquaient.

  Par rapport au travail d'�quipe, sachant que ce n'est pas la premi�re fois
  que nous travaillons ensemble, nous avons compris comment mieux travailler,
  ce qui nous a permis d'�tre tr�s productif et rapide pour ce projet.

  \;

  \;

  \;

  \;

  \;

  \;
</body>

<\references>
  <\collection>
    <associate|auto-1|<tuple|?|3>>
    <associate|auto-2|<tuple|1|4>>
    <associate|auto-3|<tuple|1.1|4>>
    <associate|auto-4|<tuple|1.2|5>>
    <associate|auto-5|<tuple|1.3|5>>
    <associate|auto-6|<tuple|1.4|6>>
    <associate|auto-7|<tuple|2|8>>
    <associate|auto-8|<tuple|3|9>>
    <associate|auto-9|<tuple|3|10>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Introduction>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Tests
      du code python contenu dans le chapitre>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2><vspace|0.5fn>

      <with|par-left|<quote|1tab>|1.1<space|2spc>Extraction des donn�es
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3>>

      <with|par-left|<quote|1tab>|1.2<space|2spc>Exploration rapide des
      donn�es textuelles avec nltk <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4>>

      <with|par-left|<quote|1tab>|1.3<space|2spc>Tf - Idf
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5>>

      <with|par-left|<quote|1tab>|1.4<space|2spc>La similarit� en cosinus
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-6>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>Am�liorations
      apport�es> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-7><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|3<space|2spc>Int�r�ts
      de l'�tude > <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-8><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Conclusion>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-9><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>