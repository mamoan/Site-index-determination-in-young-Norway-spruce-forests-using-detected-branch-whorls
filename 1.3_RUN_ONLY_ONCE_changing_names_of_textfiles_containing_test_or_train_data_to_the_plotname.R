
### Aim: Changing any textfiles containing test- or trainingdata with a filename that corresponds to the MLS name so that it is instead the plotname

## Packages and functions 

source("S:\\Users\\maria\\functions\\0_functions_used_in_this_paper.R")

## training data
train_path = "S:\\Users\\maria\\Paper_3\\data\\train_trees\\coordinates\\"
train_files = list.files(train_path)
train_files <- grep("2023-", train_files, value = TRUE)

for (i in 1:length(train_files)) {
  train_file = read.table(paste0(train_path, train_files[i]), sep = ",")
  
  train_files[i] = sub("\\.txt$", "", train_files[i])
  
  new_train_name = plotnr_from_mls_filename(train_files[i])
  
  write.table(train_file, paste0(train_path, new_train_name, ".txt"), col.names = F, row.names = F, sep = ",")
  
}


## testing data
test_path = "S:\\Users\\maria\\Paper_3\\data\\test_trees\\coordinates\\"
test_files = list.files(test_path)
test_files <- grep("2023-", test_files, value = TRUE)

for (i in 1:length(test_files)) {
  test_file = read.table(paste0(test_path, test_files[i]), sep = ",")
  
  test_files[i] = sub("\\.txt$", "", test_files[i])
  
  new_test_name = plotnr_from_mls_filename(test_files[i])
  
  test_file$V6 = new_test_name # I replace the MLS name with the plotname
  
  write.table(test_file, paste0(test_path, new_test_name, ".txt"), col.names = F, row.names = F, sep = ",")
  
}
