#08.12.2023
#author:Yingjia
#R code for data wrangling, assignment 6

library(dplyr)
library(tidyr)

#load data sets
bprs <- read.table('https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt', header = T)
rats <- read.table('https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt', header = T)

names(bprs)
names(rats)

str(bprs)
str(rats)

summary(bprs)
summary(rats)


#Convert the categorical variables of both data sets to factors
bprs$treatment <- as.factor(bprs$treatment)
bprs$subject <- as.factor(bprs$subject)


rats$ID <- as.factor(rats$ID)
rats$Group <- as.factor(rats$Group)

#BPRS data set
#Convert to long form
bprsl <-  pivot_longer(bprs, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
  arrange(weeks) #order by weeks variable

#Add a week variable
bprsl <-  bprsl %>% mutate(week = as.integer(substr(weeks,5,5)))

#RATS data set
#Convert to long form
ratsl <-  pivot_longer(rats, cols = -c(ID, Group),
                       names_to = "wds", values_to = "rats") %>%
  arrange(wds) #order by weeks variable

ratsl <- ratsl %>% mutate(Time = as.integer(substr(wds, 3,3)))

glimpse(bprsl)
glimpse(ratsl)

str(bprsl)
str(ratsl)

names(bprsl)
names(ratsl)


write.table(bprsl, file = './data/BPRSL.txt', sep = '\t', append = F, row.names = F, col.names = T )
write.table(ratsl, file = './data/ratsl.txt', sep = '\t', append = F, row.names = F, col.names = T )
