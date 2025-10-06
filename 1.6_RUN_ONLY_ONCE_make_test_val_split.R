

library(lidR)
library(fs)

# Aim. I will make a validation and testing split from my original testing data. I need some validation data in order to see if the model works before using up all my testing data.
# I will take out 30% as the validation dataset. I will take out 30% of the plots which have been automatically segmented and 30% of the plots which have been manually segmented. Further I need to make sure that all trees from one plot is only in either the test or the validation dataset.
# Output: The files in the folder R:\\Data\\VaalerIIII\\2023\\MLS\\test_train_segmented\\val\\. As the command file_move() was used, the files were moved
# from R:\Data\VaalerIIII\2023\MLS\test_train_segmented\test_segmentation to R:\Data\VaalerIIII\2023\MLS\test_train_segmented\val, i.e., the files in the val-folder
# no longer exist in the test_segmentation-folder. 

set.seed(1004)

val = list.files("R:\\Data\\VaalerIIII\\2023\\MLS\\test_train_segmented\\test_segmentation\\")

plot_names = gsub("_", "", val)  # Remove all underscores
plot_names = gsub("r", "", plot_names)  # Remove 'r'
plot_names = gsub("m", "", plot_names)  # Remove m
plot_names <- sub("(.*)\\d(?=\\.las$|\\.laz$)", "\\1", plot_names, perl = TRUE) # remove the last digit 
plot_names = gsub(".las|.laz", "", plot_names) # remove file extension
plot_names = unique(plot_names) # only unique plots

n_plots = round(length(plot_names)*0.3, 0) # These are the number of plots I need for the test/val split


# Getting 30% of the plots with manual segmentation
manual_filenames <- grep("_.*m\\.(las|laz)$", val, value = TRUE)

plot_names_manual = gsub("_", "", manual_filenames)  # Remove all underscores
plot_names_manual = gsub("r", "", plot_names_manual)  # Remove 'r'
plot_names_manual = gsub("m", "", plot_names_manual)  # Remove m
plot_names_manual <- sub("(.*)\\d(?=\\.las$|\\.laz$)", "\\1", plot_names_manual, perl = TRUE) # remove the last digit 
plot_names_manual = gsub(".las|.laz", "", plot_names_manual)
plot_names_manual = unique(plot_names_manual)
plot_names_manual = sample(plot_names_manual, round(length(plot_names_manual)*0.3, 0))

n_plots1 = n_plots - length(plot_names_manual) # These are how many plots there are left to get into the val folder 

# Create a pattern to match filenames starting with any of the digits
pattern <- paste0("^(", paste(plot_names_manual, collapse = "|"), ")")
# Use grep to filter filenames that match the pattern
val1 <- grep(pattern, val, value = TRUE) # Current val files 


# Getting the rest of the validation plots from files which are not manually segmented
aut_filenames <- grep("_.*[^m]\\.(las|laz)$", val, value = TRUE)

plot_names_aut = gsub("_", "", aut_filenames)  # Remove all underscores
plot_names_aut = gsub("r", "", plot_names_aut)  # Remove 'r'
plot_names_aut = gsub("m", "", plot_names_aut)  # Remove m
plot_names_aut <- sub("(.*)\\d(?=\\.las$|\\.laz$)", "\\1", plot_names_aut, perl = TRUE) # remove the last digit 
plot_names_aut = gsub(".las|.laz", "", plot_names_aut)
plot_names_aut = unique(plot_names_aut)
plot_names_aut = plot_names_aut[!(plot_names_aut %in% plot_names_manual)] # Remove plots already chosen for the validation dataset 
plot_names_aut = sample(plot_names_aut, round(length(plot_names_aut)*0.3, 0)) # sample 

n_plots2 = n_plots1 - length(plot_names_aut) # These are how many plots there are left to get into the val folder 

# Create a pattern to match filenames starting with any of the digits
pattern <- paste0("^(", paste(plot_names_aut, collapse = "|"), ")")
# Use grep to filter filenames that match the pattern
val2 <- grep(pattern, val, value = TRUE) # Current val files 


val3 = c(val1, val2)

round(length(val)*0.3, 0) # There should only be 42 plots to have a 70/30 split 
val3 = val3[1:42] # Yes, and here there are still two trees per plot. 

val4 = gsub("_", "", val3)  # Remove all underscores
val4 = gsub("r", "", val4)  # Remove 'r'
val4 = gsub("m", "", val4)  # Remove m

val4_test <- sub("(.*)\\d(?=\\.las$|\\.laz$)", "\\1", val4, perl = TRUE) # remove the last digit 
sort(val4_test) # Yes, for the vast majority there are two trees per plot. 


# Get the full filename of the validation files

val_files = paste0("R:\\Data\\VaalerIIII\\2023\\MLS\\test_train_segmented\\test_segmentation\\", val3)

# Make the validation folder
dir_create("R:\\Data\\VaalerIIII\\2023\\MLS\\test_train_segmented\\val")

# Move validation files here

for(i in 1:length(val_files)) {
  
  file_move(val_files[i], paste0("R:\\Data\\VaalerIIII\\2023\\MLS\\test_train_segmented\\val\\", val4[i]))
  
}

