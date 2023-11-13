#13.11.2023
#author:Yingjia
#R code for data wrangling: pre-process a data set for further analysis
library(dplyr)
example_data <- read.csv('./data/JYTOPKYS3-data.txt', header = T, sep = '\t', stringsAsFactors = F)
#explore the dimension of the data
dim(example_data) #183  60

#explore the structure of the data
summary(example_data)
head(example_data)
str(example_data)
# the data set contains 183 observations and 60 variables
df <- data.frame(deep = example_data %>% mutate(deep = D03+D11+D19+D27+D07+D14+D22+D30+D06+D15+D23+D31, .keep = "none"), stra = example_data %>% mutate(stra = ST01+ST09+ST17+ST25+ST04+ST12+ST20+ST28, .keep = "none"),
                  surf = example_data %>% mutate(surf = SU02+SU10+SU18+SU26+SU05+SU13+SU21+SU29+SU08+SU16+SU24+SU32, .keep = "none"))

new_data <- cbind(example_data[, c("Age","Attitude","Points", "gender" )], df)
new_data_1 <- new_data[which(new_data$Points!=0), ]
dim(new_data_1) #166   7
# the new data set contains 166 observations and 7 variables

#Set the working directory of the R session to the IODS Project folder
setwd("/Users/yingche/Desktop/course/IDOS2023/IODS-project")
write.table(new_data_1, file="./data/learning2014.csv",sep = ',',append = F,row.names = T,col.names = T)

new_data_1 <- read.csv('./data/learning2014.csv', header = T, sep = ',', stringsAsFactors = F)
#explore the structure of the data
str(new_data_1)
head(new_data_1)