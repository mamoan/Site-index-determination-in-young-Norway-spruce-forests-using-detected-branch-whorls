
# This document contains the function made in relation to this paper

library(readxl)
library(tidyverse)

# 1) Find mls filename from plotname

## A function that when given a plot number or a vector of plotnrs, 
## returns the name of the mls file that that plotnr corresponds to. 

#' @param plotnr a character vector of plot numbers 
#' @return A character vector containing the name of the mls files that correspond
#' to that plot number
#' @details 
#' @author Maria Aasnes Moan \email{maria.asnes.moan@nmbu.no}
#' @references 
#' @examples
#' 

mls_filename_from_plotnr = function(plotnr) {
  
  dat_link = read_excel("R:\\Data\\VaalerIIII\\2023\\MLS\\which_plots_measured_when_with_mls.xlsx") %>% 
    filter(Plot %in% plotnr) %>% 
    mutate(filename = paste0(Date, "_", Corresponding_scanner_time)) %>% 
    select("filename") %>% 
    as_vector() 
  
  return(paste0(dat_link, "_9pct_time_scan.laz"))
  
}

#' Examples
#' mls_filename_from_plotnr("2540913") # one plotnr 
#' mls_filename_from_plotnr(c("2540913", "2540912")) # several plotnrs
#' 
#' 


mls_filename_from_plotnr(c("2449402", "2501603", "2501612", "2518102", "2540904"))

mls_filename_from_plotnr("2449402")


# ChatGPT's function to extract date and time vectors

extract_date_time <- function(original_vector) {
  # Split the vector by underscore
  split_vector <- strsplit(original_vector, "_")[[1]]
  
  # Check the length of the split_vector to handle both cases
  if (length(split_vector) == 3) {
    # Case with prefix: Extract the second and third parts
    date_vector <- split_vector[2]
    time_vector <- split_vector[3]
  } else if (length(split_vector) == 2) {
    # Case without prefix: Extract the first and second parts
    date_vector <- split_vector[1]
    time_vector <- split_vector[2]
  } else {
    # In case the format does not match expected patterns
    stop("Unexpected vector format.")
  }
  
  # Return the date and time vectors
  return(list(date_vector = date_vector, time_vector = time_vector))
}

# 2) Find plotname from MLS_filename 

plotnr_from_mls_filename = function(mls_filename) {
  
  date_time = extract_date_time(mls_filename)
  
  date = date_time$date_vector
  
  scn_time = date_time$time_vector
    
  dat_link = read_excel("R:\\Data\\VaalerIIII\\2023\\MLS\\which_plots_measured_when_with_mls.xlsx") %>% 
    filter(Date %in% date & Corresponding_scanner_time %in% scn_time) %>% 
    mutate(filename = Plot) %>% 
    select("filename") %>% 
    as_vector() 
  
  return(as.character(dat_link))
  
}
