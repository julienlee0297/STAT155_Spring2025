library(tidyverse)

# Read in both data sets
income_summary <- read.csv("~/Documents/stat155/Project 1/data/processdata/weighted_agi.csv")
fips_tally <- read.csv("~/Documents/stat155/Project 1/data/processdata/fips_tally.csv")

# Ensure FIPS codes are numeric for matching
fips_tally <- fips_tally %>%
  rename(COUNTYFIPS = fipsCountyCode, Year = fyDeclared)

# Merge by COUNTYFIPS and Year
mergeddata <- left_join(income_summary, fips_tally, by = c("COUNTYFIPS", "Year"))
mergeddata <- mergeddata %>%
  arrange(Year)


# Save to new CSV
write.csv(mergeddata, "~/Documents/stat155/Project 1/data/processdata/mergeddata.csv", row.names = FALSE)

