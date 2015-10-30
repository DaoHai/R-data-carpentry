#Visualization Scripts

#install.packages("ggplot2")
library(ggplot2)
library(magrittr)
library(dplyr)

#load the data from website 
surveys_raw <- read.csv("http://files.figshare.com/1919744/surveys.csv")

#clean the data
surveys_complete <- surveys_raw %>% filter(species_id !="") #pipeline must be loaded with library dplyr
#nrow(surveys_complete)
#nrow(surveys_raw)

#remove empty weight et empty
surveys_complete <- surveys_raw %>% filter(species_id !="") %>% #pipe should be the end of line rather than beginning of new line
                                filter(!is.na(weight)) %>% 
                                filter(!is.na(hindfoot_length))
nrow(surveys_complete)

#Remove species with low counts
#Count number of records per species
species_count <- surveys_complete %>%
                group_by(species_id) %>%
                tally
head(species_count)
help(tally)

frequent_species <- species_count %>%
                    filter(n>=10) %>% 
  select(species_id)

frequent_species
nrow(frequent_species)

surveys_complete <- surveys_complete %>%
  filter(species_id %in% frequent_species$species_id)

plot(x=surveys_complete$weight, y=surveys_complete$hindfoot_length #basic R plotting capabilities
     
  #Plotting with ggplot2
  
  ggplot(data=surveys_complete, aes(x=weight, y=hindfoot_length))+geom_point()

        