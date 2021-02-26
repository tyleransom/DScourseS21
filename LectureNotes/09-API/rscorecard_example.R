library(tidyverse)
library(rscorecard)

sc_key(Sys.getenv("USGOV_API_KEY"))

# download some data
df <- sc_init() %>% 
    sc_filter(region == 2, ccbasic == c(21,22,23), locale == 41:43) %>% 
    sc_select(unitid, instnm, stabbr, ugds) %>% 
    sc_year("latest") %>% 
    sc_get()
