#### STEP 1
install.packages("tidyverse")
library(dplyr) # alternatively, library(tidyverse)
library(readr)

df <- read_csv("Dec_lsoa_grocery.csv")

selected_cols <- c("area_id",
                   "fat", "saturate", "salt", "protein", "sugar",
                   "protein", "carb", "fibre", "alcohol",
                   "population", "male",  "female",
                   "age_0_17",  "age_18_64", "age_65+",  "avg_age",
                   "area_sq_km",  "people_per_sq_km"
)

df <- df %>% select(all_of(selected_cols))

#### STEP 2

highest_alcohol_regions <- df %>%
  arrange(desc(alcohol)) %>%
  head(3)

lowest_alcohol_regions <- df %>%
  arrange(alcohol) %>%
  head(3)

highest_alcohol_names <- highest_alcohol_regions$area_id
lowest_alcohol_names <- lowest_alcohol_regions$area_id

highest_sugar_regions <- df %>%
  arrange(desc(sugar)) %>%
  head(3)

lowest_sugar_regions <- df %>%
  arrange(sugar) %>%
  head(3)

highest_sugar_names <- highest_sugar_regions$area_id
lowest_sugar_names <- lowest_sugar_regions$area_id

cat("Regions with highest average alcohol consumption:", "\n", 
    highest_alcohol_names, "\n\n")

cat("Regions with lowest average alcohol consumption:", "\n", 
    lowest_alcohol_names, "\n\n")

cat("Regions with highest average sugar consumption:", "\n", 
    highest_sugar_names, "\n\n")

cat("Regions with lowest average sugar consumption:", "\n", 
    lowest_sugar_names, "\n")

#### STEP 3

pop_stats <- df %>% 
  summarise(mean_pop = mean(population), sd_pop=sd(population))

print(pop_stats)

#### STEP 4

library(ggplot2) # if you haven't loaded tidyverse

# Choose two nutrients
nutrient1 <- df$alcohol
nutrient2 <- df$sugar

# Create scatterplot
ggplot(data = df, aes(x = nutrient1, y = nutrient2)) +
  geom_point() +
  labs(title = "Scatterplot of Alcohol vs Sugar",
       x = "Alcohol", y = "Sugar")
