#Funções para limpar a tela e as variáveis
rm(list=ls())
cat("\014")   # ctrl+L to the console
graphics.off()
#install.packages("MVA")
library("MVA")
#install.packages("scatterplot3d")
library("scatterplot3d")

#Importar os dados
table_dados <- read.csv(file = "dados.csv", na.strings=c(""), header = TRUE)
table_bolsas <- read.csv(file = "bolsas.csv", na.strings=c(""), header = TRUE)

#Boxplot tipos de bolsa por lobby index
plot(table_dados$tipo_bolsa, table_dados$lobby_index)

#Boxplot tipos de bolsa por h index
plot(table_dados$tipo_bolsa, table_dados$h_index)

#Histogramas todos
hist(table_dados$lobby_index, breaks=40)
hist(table_dados$h_index, breaks=40)

#Histogramas quem tem bolsa
hist(table_bolsas$lobby_index, breaks=40)
hist(table_bolsas$h_index, breaks=40)

#Histogramas bolsa PQ-2
table_pq2 <- table_dados[table_dados$tipo_bolsa == 'PQ-2', ]
hist(table_pq2$lobby_index, breaks=40)
hist(table_pq2$h_index, breaks=40)

#Histogramas bolsa PQ-1D
table_pq1d <- table_dados[table_dados$tipo_bolsa == 'PQ-1D', ]
hist(table_pq1d$lobby_index, breaks=40)
hist(table_pq1d$h_index, breaks=40)

#Histogramas bolsa PQ-1C
table_pq1c <- table_dados[table_dados$tipo_bolsa == 'PQ-1C', ]
hist(table_pq1c$lobby_index, breaks=40)
hist(table_pq1c$h_index, breaks=40)

#Histogramas bolsa PQ-1B
table_pq1b <- table_dados[table_dados$tipo_bolsa == 'PQ-1B', ]
hist(table_pq1b$lobby_index, breaks=40)
hist(table_pq1b$h_index, breaks=40)

#Histogramas bolsa PQ-1A
table_pq1a <- table_dados[table_dados$tipo_bolsa == 'PQ-1A', ]
hist(table_pq1a$lobby_index, breaks=40)
hist(table_pq1a$h_index, breaks=40)