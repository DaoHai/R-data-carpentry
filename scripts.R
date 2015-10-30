download.file("http://files.figshare.com/2236372/combined.csv",
              "~/Desktop/R-data-carpentry/portal_data_joined.csv")

surveys <- read.csv('data/portal_data_joined.csv') #read the data file into data frame

head(surveys)
tail(surveys)

#factor data type illustration

sex <- factor(c("male", "female", "male", "female"))
nlevels(sex)

food <- factor(c("low", "high", "medium", "high", "low", "medium", "high"))
levels(food)
food <- factor(food, levels=c("low", "medium", "high"), ordered=TRUE)
levels(food)

?factor
is.ordered(food)
min(food)

f <- factor(c(1, 5, 10, 2))
str(f)
as.numeric(as.character(f))

#good practice to deal with factor label
as.numeric(levels(f))[f]

#function table() practice
exprmt <- factor(c("treat1", "treat2", "treat1", "treat3", "treat1",
                   "control", "treat1", "treat2", "treat3"), levels=c("treat1","treat2", "treat3","control"))
table(exprmt)
barplot(table(exprmt))

library()
