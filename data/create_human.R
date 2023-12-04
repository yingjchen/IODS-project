#R code for data wrangling for assignment 5

library(readr)
library(dplyr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

str(hd)
summary(hd)
dim(hd) #195 observations and 8 variables


str(gii)
summary(gii)
dim(gii) #195 observations and 10 variables

colnames(gii)
colnames(hd)

#rename the variables with (shorter) descriptive names
colnames(gii) <- c("GII Rank", "Country", "GII","Mat.Mor","Ado.Birth","Parli","Edu2.F","Edu2.M","Labo.F","Labo.M")
colnames(hd) <- c("HDI Rank", "Country", "HDI","Life.Exp","Edu.Exp","Mean.Edu","GNI","Gni-HDI.Rank")


gii$Edu2.ratio <- gii$Edu2.F / gii$Edu2.M
gii$Labo.ratio <- gii$Labo.F / gii$Labo.M

human <- inner_join(gii, hd, by = "Country")

write.table(human, file="./data/human.csv",sep = ',',append = F,row.names = F,col.names = T)


#chapter 5:  Dimensionality reduction techniques
library(dplyr)
library(readr)


#load data
human <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human1.csv")
#human <- read.csv('./data/human.csv', header = T, sep = ',', stringsAsFactors = F)


#explore the structure and the dimensions
dim(human) #195 observations and 19 variables
str(human)
colnames(human)


#keep needed variables
human <- human %>% select(c( "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F" ))


#Remove all rows with missing values 
human_ <- human[complete.cases(human), ]


#Remove the observations which relate to regions instead of countries.
human_ <- human_[1:155, ]
dim(human_) #[1] 155   9

#save data
write.table(human_, file="./data/human.csv",sep = ',',append = F,row.names = F,col.names = T)
