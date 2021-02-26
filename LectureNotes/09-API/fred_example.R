library(tidyverse)
library(fredr)

#df <- some_api_function("FRED_series_we_want",
#                        key=Sys.getenv("FRED_API_KEY"))
df <- fredr(
    series_id = "GNPCA",
    observation_start = as.Date("1948-01-01"),
    observation_end = as.Date("2020-01-01")
)
