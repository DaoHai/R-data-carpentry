install.packages("RSQLite")
library(RSQLite)

#database connection
mydb <- "dbavecR.sqlite"
conn <- dbConnect(drv = SQLite(), dbname= mydb)

#Scriptted Querry
dbGetQuery(conn, "SELECT type, tbl_name  FROM sqlite_master")

dbListTables(conn)
dbListFields(conn, "surveys")
dbGetQuery(conn, "SELECT count(*) FROM surveys")

q <- 'SELECT DISTINCT year, species_id FROM surveys'
result <-  dbGetQuery(conn, q)
head(result)

q <- 'SELECT COUNT(*), ROUND(SUM(WEIGHT)) FROM surveys'
result <-  dbGetQuery(conn, q)
result

#concatenate query, access to a column on a table by dot, alias a table by a shortcut
q <- "SELECT d.plot_type , c.genus, count(*) 
FROM
(SELECT a.genus, b.plot_id 
FROM species a 
JOIN surveys b
ON a.species_id = b.species_id) c 
JOIN plots d
ON c.plot_id = d.plot_id
GROUP BY d.plot_type,c.genus"

result <- dbGetQuery(conn,q)
head(result)

#Advanced Querry with Scripts
yearRange <- dbGetQuery(conn,"SELECT min(year),max(year) FROM surveys")
years <- seq(yearRange[,1],yearRange[,2],by=2)

q <- paste("
SELECT a.year,b.taxa,count(*) as count
FROM surveys a
JOIN species b
ON a.species_id = b.species_id
AND b.taxa = 'Rodent'
AND a.year in (",
           paste(years,collapse=",")
           ,")
GROUP BY a.year, b.taxa",
           sep = "" )
rCount <- dbGetQuery(conn,q)
head(rCount)


#---------Create the database from R---------------------
species <- read.csv("species.csv")
surveys <- read.csv("surveys.csv")
plots <- read.csv("plots.csv")

#Open up a connection and name a database
myDB <- "portalR.db"
myConn <- dbConnect(drv = SQLite(), dbname= myDB)
#dbListTables(myConn)

#Add table to a database
dbWriteTable(myConn,"species",species)
dbListTables(myConn)
dbGetQuery(myConn,"SELECT * from species limit 10")

