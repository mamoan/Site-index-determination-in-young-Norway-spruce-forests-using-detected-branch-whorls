# Aim: simplify the naming of the files containing point clouds of val and test trees. 


# Val files 

# List all files in the directory
files <- list.files("C:\\Users\\mamoan\\OneDrive - Norwegian University of Life Sciences\\PHD\\Paper_3_young_stands\\data\\val")

# Generate new file names by removing '_' and 'r'
new_files <- gsub("_", "", files)  # Remove all underscores
new_files <- gsub("r", "", new_files)  # Remove 'r'

# Rename the files
success <- mapply(file.rename, from = paste0("C:\\Users\\mamoan\\OneDrive - Norwegian University of Life Sciences\\PHD\\Paper_3_young_stands\\data\\val\\", files), to = paste0("C:\\Users\\mamoan\\OneDrive - Norwegian University of Life Sciences\\PHD\\Paper_3_young_stands\\data\\val\\", new_files))

# Check which files were successfully renamed
print(success)



# Test files 

# List all files in the directory
files <- list.files("C:\\Users\\mamoan\\OneDrive - Norwegian University of Life Sciences\\PHD\\Paper_3_young_stands\\data\\test")

# Generate new file names by removing '_' and 'r'
new_files <- gsub("_", "", files)  # Remove all underscores
new_files <- gsub("r", "", new_files)  # Remove 'r'
new_files <- gsub("m", "", new_files)  # Remove 'm'

# Rename the files
success <- mapply(file.rename, from = paste0("C:\\Users\\mamoan\\OneDrive - Norwegian University of Life Sciences\\PHD\\Paper_3_young_stands\\data\\test\\", files), to = paste0("C:\\Users\\mamoan\\OneDrive - Norwegian University of Life Sciences\\PHD\\Paper_3_young_stands\\data\\test\\", new_files))

# Check which files were successfully renamed
print(success)



##### Checking that no files from val are duplicated in test ######### 
files_val <- list.files("C:\\Users\\mamoan\\OneDrive - Norwegian University of Life Sciences\\PHD\\Paper_3_young_stands\\data\\val")
files_test <- list.files("C:\\Users\\mamoan\\OneDrive - Norwegian University of Life Sciences\\PHD\\Paper_3_young_stands\\data\\test")

any(duplicated(files_val, files_test)) # looks good

##### checking that only pairs of plots are included in the test dataset #########
files_test 

# Use sub function to remove the last digit and the extension
cleaned_files <- sub("(.*)\\d\\.(las|laz)$", "\\1", files_test)
cleaned_files = as.numeric(cleaned_files)
sort(cleaned_files)

# Print the cleaned files
print(cleaned_files)

