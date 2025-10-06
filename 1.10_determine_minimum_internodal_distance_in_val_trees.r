
## This is a hyperparameter decided from the val trees. It is the minimum distance between whorls that
## is allowed in the prediction. This minimum internodal distance is the 5th percentile of the predicted
## internodal distances. 

library(tidyverse)

field_dat = readRDS("S:\\Users\\maria\\Paper_3\\data\\fielddata\\fielddata.rds") %>% 
  mutate(plot_and_tree = str_replace(plot_and_tree, "_", ""))


val_trees = list.files("C:\\Users\\mamoan\\OneDrive - Norwegian University of Life Sciences\\PHD\\Paper_3_young_stands\\data\\val")
val_trees = str_replace(val_trees, ".las|.laz", "")


field_dat1 = field_dat %>% 
  filter(plot_and_tree %in% val_trees) %>% 
  group_by(plot_and_tree) %>% 
  mutate(minimum_int_distance = Lengde_m - lag(Lengde_m)) %>% 
  ungroup() %>% 
  select(c("minimum_int_distance")) %>% 
  na.omit() %>%
  as_vector() %>% 
  sort()

min(field_dat1)
field_dat1[round(length(field_dat1)*0.05, 0)]

test = c(1, 3, 3, 4, 5, 6, 7, 9)
test - lag(test) # The lag approach recommended by Chat seems to work. 

