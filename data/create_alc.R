#20.11.2023
#author:Yingjia
#R code for data wrangling: pre-process a data set for further analysis
setwd("/Users/yingche/Desktop/course/IDOS2023/IODS-project/data/")

d1=read.table("./student-mat.csv",sep=";",header=TRUE, stringsAsFactors = F, check.names = F)
dim(d1) #395 rows and 33 columns
str(d1)
head(d1)

d2=read.table("./student-por.csv",sep=";",header=TRUE, stringsAsFactors = F, check.names = F)
dim(d2) #649 rows and 33 columns
str(d2)
head(d2)

colkeep = colnames(d1)[! colnames(d1) %in% c( "failures", "paid", "absences", "G1", "G2", "G3" )]
d3 = merge(d1,d2,by=colkeep, all = F)
dim(d3) # 370 students, 39 columns
str(d3)
head(d3)

# create a new data frame with only the joined columns
alc <- select(d3, all_of(colkeep))
# for every column name not used for joining...
for(col_name in c( "failures", "paid", "absences", "G1", "G2", "G3" )) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(d3, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}

#glimpse at the joined data set
dim(alc). #370 students and 33 variables
head(alc)

#create two new columns
alc$alc_use = rowMeans(alc[, c('Dalc', 'Walc')])
alc$high_use = ifelse(alc$alc_use>2, TRUE, FALSE) 

#glimpse at the joined and modified data set
dim(alc) #370 students and 35 variables
head(alc)

write.table(alc, file="./student-mat-por.csv",sep = ',',append = F,row.names = F,col.names = T)
