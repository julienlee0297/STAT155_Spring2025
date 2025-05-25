## Filter for disasters in CA from 2012-2022, save to new csv

library(tidyverse)

# Read the data
df <- read.csv("~/Documents/stat155/Project1/data/rawdata/DisasterDeclarationsSummaries.csv")

# Clean and filter
disasterprocess <- df %>%
  filter(state == "CA", fyDeclared >= 2012, fyDeclared <= 2022) %>%
  arrange(as.Date(incidentBeginDate))

# Save to new CSV
write.csv(disasterprocess, "~/Documents/stat155/Project1/data/processdata/disasterprocess.csv", row.names = FALSE)

# Count how many times each fipsCountyCode shows up per year, include designatedArea
fips_tally <- disasterprocess %>%
  group_by(fyDeclared, fipsCountyCode, designatedArea) %>%
  summarise(
    count = n(),
    .groups = "drop"
  ) %>%
  arrange(fyDeclared, desc(count))

write.csv(fips_tally, "~/Documents/stat155/Project1/data/processdata/fips_tally.csv", row.names = FALSE)
