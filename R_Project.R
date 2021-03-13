install.packages("readxl")
install.packages("arules")
install.packages("arulesViz")
library("readxl")
online <- read_excel("Online Retail.xlsx")
online<- subset(online,!is.na(online$Description))
head(online)
str(online)
library(dplyr)
grouped_data<-online %>% group_by(InvoiceNo,InvoiceDate) %>% summarise(Description = paste(unique(Description), collapse = ','))
grouped_data$InvoiceNo=NULL
grouped_data$InvoiceDate=NULL
distinct(online,Description)
grouped_data%>% mutate(Description = as.factor(Description))
View(grouped_data)
library('arulesViz')
write.csv(grouped_data,"transactions.csv", quote = FALSE, row.names = FALSE)
tr <- read.transactions('transactions.csv', format = 'basket', sep=',')
apriori(tr,parameter=list(support=0.011,confidence=0.9))->rule1
inspect(head(rule1,5))
plot(rule1,method = 'grouped')


