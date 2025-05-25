## Filter for counties in CA and save to new csv for each file, append to new csv
library(tidyverse)

# Get file paths
file_names <- list.files("~/Documents/stat155/Project1/data/rawdata/Raw_AGI_by_State", pattern = "\\.csv$", full.names = TRUE)

# Corresponding years (adjust if needed)
years <- 2012:2022

# Folder to save stripped files
output_dir <- "~/Documents/stat155/Project1/data/processdata/incomeprocess"

# Create the folder if it doesn't exist
dir.create(output_dir, showWarnings = FALSE)

# Process and save
income_list <- map2(file_names, years, ~{
  df <- read.csv(.x)
  df_filtered <- df[df[[1]] == 6, ]  # Filter rows where first column == 6
  df_filtered <- df_filtered %>% mutate(Year = .y)
  
  # Create a new file name
  out_filename <- paste0(output_dir, "/income_", .y, ".csv")
  
  # Save the filtered file
  write.csv(df_filtered, out_filename, row.names = FALSE)
  
  return(df_filtered)
})

# Combine and save the full dataset
income_all <- bind_rows(income_list) %>%
  select(Year, everything())




# Filter out COUNTYFIPS == 0 and select only needed columns
income_all <- income_all %>%
  filter(COUNTYFIPS != 0) %>%
  select(Year, STATEFIPS, STATE, COUNTYFIPS, COUNTYNAME, agi_stub, N1)


write.csv(income_all, "~/Documents/stat155/Project1/data/processdata/incomeprocess/income_all.csv", row.names = FALSE)




# Group by Year and COUNTYNAME, then find weighted agi
income_summary <- income_all %>%
  group_by(Year, STATEFIPS, STATE, COUNTYFIPS, COUNTYNAME) %>%
  summarize(
    weighted_agi_stub = sum(agi_stub * N1) / sum(N1),
    .groups = "drop"  # Ungroup after summarizing
  )

# Strip to Year, COUNTYNAME, and weighted_agi_stub, then order by Year
income_summary <- income_summary %>%
  select(Year, COUNTYFIPS, COUNTYNAME, weighted_agi_stub) %>%
  arrange(COUNTYNAME, Year)

# Save to CSV
write.csv(income_summary, "~/Documents/stat155/Project1/data/processdata/weighted_agi.csv", row.names = FALSE)



