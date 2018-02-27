from Bio import Entrez
Entrez.email = "yfh1202@sinica.edu.tw"     # Always tell NCBI who you are
handle = Entrez.esearch(db="pubmed", term="PIK3CA")
record = Entrez.read(handle)
list = record["IdList"]
print len(list)
for index in range(0, len(list)):
    listId = list[index]
    handle = Entrez.efetch(db="pubmed", id=listId, retmode='xml', rettype='abstract')
    record = Entrez.read(handle)
    print
    print [index]
    print listId
    for article in record['PubmedArticle']:
     articleTitle = article['MedlineCitation']['Article']['ArticleTitle']
     articleAbstract = article['MedlineCitation']['Article']['Abstract']
     print articleTitle
     print articleAbstract