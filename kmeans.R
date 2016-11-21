#O banco de dados utilizado foi construído por Tayrine Dias, a partir de informações 
#obtidas das bases públicas da MUNIC 2014, CENSO 2010 e DATASUS.
#O banco contém 26 variáveis.

#O primeiro passo é ler o banco de dados, importando-o como dataframe
bdmunic2<-read.csv2('C:/Users/tayri_000/Documents/Mestrado/MINERACAO DE DADOS/Trabalho/BASEDEDADOSCSV3.csv', header=TRUE, sep=';',dec=',')

#O segundo passo é importar a biblioteca necessária para a visualização dos dados
library(ggplot2)

#O terceiro passo é explorar os dados do banco
ggplot(bdmunic2, aes(PORCDOMICILIOSRURAIS, TAXAMORTES, color = A1024COD)) + geom_point()
ggplot(bdmunic2, aes(PORCANALFABETISMO, TAXAMORTES, color = A1024COD)) + geom_point()
ggplot(bdmunic2, aes(RENDMEDIOPERCAPITA, TAXAMORTES, color = A1024COD)) + geom_point()
ggplot(bdmunic2, aes(INDICEINSTITUCIONAL, TAXAMORTES, color = A1024COD)) + geom_point()
ggplot(bdmunic2, aes(A1022, TAXAMORTES, color = A1024COD)) + geom_point()

#O quarto passo é estabelecer um seed, para garantir a replicabilidade dos dados
set.seed(20)

#O quinto passo é executar a clusterização pelo algoritmo k-means.
bdmunic2Cluster <- kmeans(bdmunic2[c(23:26)], 5, iter.max=450, nstart = 20)
bdmunic2Cluster

#O sexto passo é observar como os clusteres se distribuem pelas regiões e UFs do país, e salvar estas tabelas
tabela1<-table(bdmunic2Cluster$cluster, bdmunic2$A1024COD)
tabela2<-table(bdmunic2Cluster$cluster, bdmunic2$A1022)
write.csv2(tabela2, 'C:/Users/tayri_000/Documents/Mestrado/MINERACAO DE DADOS/Trabalho/tabelaestado.csv')
write.csv2(tabela1, 'C:/Users/tayri_000/Documents/Mestrado/MINERACAO DE DADOS/Trabalho/tabelaregiao.csv')

#O último passo é exibir os clusteres por variáveis de nosso interesse
#Porcentagem de analfabetismo
bdmunic2Cluster$cluster <- as.factor(bdmunic2Cluster$cluster)
ggplot(bdmunic2, aes(PORCANALFABETISMO, TAXAMORTES, color = bdmunic2Cluster$cluster)) + geom_point()
#Porcentagem de domicílios rurais
ggplot(bdmunic2, aes(PORCDOMICILIOSRURAIS, TAXAMORTES, color = bdmunic2Cluster$cluster)) + geom_point()
#Rendimento mensal per capita
ggplot(bdmunic2, aes(RENDMEDIOPERCAPITA, TAXAMORTES, color = bdmunic2Cluster$cluster)) + geom_point()
#Índice institucional (soma das variáveis A107-A730)
ggplot(bdmunic2, aes(INDICEINSTITUCIONAL, TAXAMORTES, color = bdmunic2Cluster$cluster)) + geom_point()
#Por região
ggplot(bdmunic2, aes(A1024COD, TAXAMORTES, color = bdmunic2Cluster$cluster)) + geom_point()
#Mortes por cluster
ggplot(bdmunic2, aes(bdmunic2Cluster$cluster, TAXAMORTES, color = A1024COD)) + geom_point()
