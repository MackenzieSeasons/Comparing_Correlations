library(tidyverse)

bfi <- read_csv("bfi.csv")
#reads the data

#glimpsed the data below

library(apaTables)
apa.cor.table(bfi)
#viewed the correlation table
#cor between A1 and C1 is .03, cor between E1 and O1 is -.10

#now we'll compare the correlations (non overlapping)
library(cocor)
cocor(~A1+C1|E1+O1, data=as.data.frame(bfi))
#correlation between A1 and C1 was .0276, and between E1 and O1 was -.1002
#Zou's CI was .075 to .180
# we would write this as deltar = .13, 95% CI [.07, .18]
#could also include p value if you want

#now we'll do an overlapping correlation between A1 and C1, and A1 and E1
cocor(~A1+C1|A1+E1, data=as.data.frame(bfi))
# delta r = -.08, 95% CI [-.13, -.03], p = .004

#we can also compare correlations across independent data sets
#create separate data sets for men and women
bfi_men <- bfi %>% filter(gender==1) %>% select(-gender)
bfi_women <- bfi %>% filter(gender==2) %>% select(-gender)

#checking out the correlations for men
apa.cor.table(bfi_men)
apa.cor.table(bfi_women)

#now we actually do the comparison
bfi_men_dataframe <- as.data.frame(bfi_men)
bfi_women_dataframe <- as.data.frame(bfi_women)
cocor(~A1+E1|A1+E1, data=list(bfi_men_dataframe, bfi_women_dataframe))
# delta r = .08, 95% CI [-.002, .15]

