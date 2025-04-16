

library(sf)

philly_income_geo <- get_acs(
  geography = "zcta",
  variables = "B19013_001",
  state = "PA",
  year = 2020,
  geometry = TRUE
)

# Get Philadelphia county boundary
philly_boundary <- counties(state = "PA", county = "Philadelphia", cb = TRUE, class = "sf")

# Spatial filter: ZCTAs that intersect Philly
philly_zctas <- philly_income_geo %>%
  st_filter(philly_boundary)

# View a few
head(philly_zctas)

philly_income_geo
philly_boundary

