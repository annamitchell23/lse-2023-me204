library(tidyverse)
library(xml2)

df <- read_csv("Dec_lsoa_grocery.csv")

selected_cols <- c("area_id",
                   "fat", "saturate", "salt", "protein", "sugar", "protein",
                   "carb", "fibre", "alcohol")
View(df[selected_cols])

#Create root node
tesco_data_xml <- xml_new_root("data", .encoding = "UTF-8")
tesco_data_xml

#The encoding is not compulsory
temp <- xml_new_root("data")
temp

#Extract first row
row1 <- df %>% slice(1)

#Create new XML node
area_node <- xml_new_root("area",
                          area_id = row1 %>% pull(area_id))

area_node

#Add children nodes to to the area node
for(nutrient_name in selected_cols[-1]){
  xml_add_child(area_node, nutrient_name, row1[[nutrient_name]])
}

area_node

# Add area node as a child to root #
xml_add_child(tesco_data_xml, area_node)

#Saving the file
xml2::write_xml(tesco_data_xml, "sample_tesco_data.xml")

#Get area node function #
get_area_node <- function(row) {
  row <- data.frame(row)
  area_node <- xml_new_root("area",
                            area_id = row %>% pull(area_id))
  
  for(nutrient_name in selected_cols[-1]){
    xml_add_child(area_node, nutrient_name, row %>% pull(nutrient_name))
  }
  return(area_node)
}

#Part 3
tesco_data_xml2 <- xml_rew_root("data", .encoding = "UTF-8")
for (i in 1:10){
  tesco_data_xml2 %>% xml_add_child(get_area_node(df[i, ]))
}

write_xml(tesco_data_xml2, "sample_tesco_data2.xml")
  
get_area_node <- function(row){
  area_node <- xml2::xml_new_root("area", area_id = row$area_id)
  
  # Create the 'nutrients' parent node
  nutrients_node <- xml2::xml_add_child(area_node, "nutrients")
  
  for(nutrient_name in selected_cols[-1]){
    xml_add_child(nutrients_node, nutrient_name, row[[nutrient_name]])
  }
  
  return(area_node)
}
tesco_data_xml <- xml_new_root("data", .encoding = "UTF-8")
for (i in 1:10) {
  tesco_data_xml %>% xml_add_child(get_area_node(df[i, ]))
}

write_xml(tesco_data_xml, "sample_tesco_data.xml")
