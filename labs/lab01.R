df <- read.csv("Dec_lsoa_grocery.csv")

#### STEP 1

selected_cols <- c("area_id",
                   "fat", "saturate", "salt", "protein", "sugar",
                   "protein", "carb", "fibre", "alcohol",
                   "population", "male",  "female",
                   "age_0_17",  "age_18_64", "age_65.",  "avg_age",
                   "area_sq_km",  "people_per_sq_km"
)
df <- df[selected_cols]

#### STEP 2

# Find regions with the highest average alcohol consumption
highest_alcohol_regions <- df[order(df$alcohol, decreasing = TRUE), ]
highest_alcohol_regions <- head(highest_alcohol_regions, 3)

# Find regions with the lowest average alcohol consumption
lowest_alcohol_regions <- df[order(df$alcohol), ]
lowest_alcohol_regions <- head(lowest_alcohol_regions, 3)

# Extract region names for highest and lowest alcohol consumption
highest_alcohol_names <- highest_alcohol_regions$area_id
lowest_alcohol_names <- lowest_alcohol_regions$area_id

# Find regions with the highest average sugar consumption
highest_sugar_regions <- df[order(df$sugar, decreasing = TRUE), ]
highest_sugar_regions <- head(highest_sugar_regions, 3)

# Find regions with the lowest average sugar consumption
lowest_sugar_regions <- df[order(df$sugar), ]
lowest_sugar_regions <- head(lowest_sugar_regions, 3)

# Extract region names for highest and lowest sugar consumption
highest_sugar_names <- highest_sugar_regions$area_id
lowest_sugar_names <- lowest_sugar_regions$area_id

# Print the results
cat("Regions with highest average alcohol consumption:", "\n", 
    highest_alcohol_names, "\n\n")

cat("Regions with lowest average alcohol consumption:", "\n", 
    lowest_alcohol_names, "\n\n")

cat("Regions with highest average sugar consumption:", "\n", 
    highest_sugar_names, "\n\n")

cat("Regions with lowest average sugar consumption:", "\n", 
    lowest_sugar_names, "\n")

#### STEP 3

pop_stats <- data.frame(mean_pop = mean(df$population),
                        std_pop = sd(df$population))
print(pop_stats)

#### STEP 4

# Choose two nutrients
nutrient1 <- df$alcohol
nutrient2 <- df$sugar

# Create scatterplot
plot(nutrient1, nutrient2, main = "Scatterplot of Nutrient1 vs Nutrient2",
     xlab = "Alcohol", ylab = "Sugar", pch = 16)
