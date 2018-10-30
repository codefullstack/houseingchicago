library(RSocrata)
library(dplyr)

#import data
data <- read.socrata("https://data.cityofchicago.org/resource/uahe-iimk.csv") %>% 
  as_tibble()  #makes data easier to read 
class(data)
?as_tibble

#Explore data
View(data)
summary(data)
glimpse(data)
str(data) #basic R function
??select #look up function in the different packages

select(data, community_area_number)

#How many properties in each area

properties_area <- data %>% 
  group_by(community_area_number) %>% 
  tally() 

area_key <- data %>%
  group_by(community_area_number) %>% 
  slice(1) %>% 
  select(community_area, community_area_number)
  

left_join(area_key, properties_area) %>% 
  select(community_area, community_area_number, properties =n) %>% 
  arrange(desc(properties))

#Do the same but for units

unit_data <- data %>% 
  group_by(community_area_number) %>% 
  summarise(total_units = sum(units))


