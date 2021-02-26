pacman::p_load(tidyverse, magrittr, tsibble, zoo, COVID19) 

df <- covid19(c("US"))
df.ts.us <- as_tsibble(df, key=id, index=date)
df.ts.us %<>% mutate(new_cases = difference(confirmed))

ggplot(df.ts.us, aes(date, new_cases)) + geom_hline(yintercept = 75000) + geom_line(aes(y=rollmean(new_cases, 7, na.pad=TRUE))) + labs(y = "New Daily Cases in US\n(7-day rolling average)", x = "Date") + theme_minimal()

df.ts.us %<>% mutate(new_deaths = difference(deaths),
                     CFR        = new_deaths/new_cases)

ggplot(df.ts.us, aes(date, CFR)) + geom_line(aes(y=rollmean(CFR, 7, na.pad=TRUE))) + labs(y = "US Case Fatality Rate\n(7-day rolling average)", x = "Date") + theme_minimal()

df.ok <- covid19(country=c("US"),level=2) %>% filter(key_alpha_2=="OK")
df.ts <- as_tsibble(df.ok, key=id, index=date)
df.ts %<>% mutate(new_cases = difference(confirmed))

ggplot(df.ts, aes(date, new_cases)) + geom_hline(yintercept = 750) + geom_line(aes(y=rollmean(new_cases, 7, na.pad=TRUE))) + labs(y = "New Daily Cases in Oklahoma\n(7-day rolling average)", x = "Date") + theme_minimal()
ggplot(df.ts %>% filter(date>"2020-10-01"), aes(date, new_cases)) + geom_hline(yintercept = 750) + geom_line(aes(y=rollmean(new_cases, 7, na.pad=TRUE))) + labs(y = "New Daily Cases in Oklahoma\n(7-day rolling average)", x = "Date") + theme_minimal()
ggplot(df.ts %>% filter(date>"2020-12-01"), aes(date, new_cases)) + geom_hline(yintercept = 750) + geom_line(aes(y=rollmean(new_cases, 7, na.pad=TRUE))) + labs(y = "New Daily Cases in Oklahoma\n(7-day rolling average)", x = "Date") + theme_minimal()

df.ts %<>% mutate(new_deaths = difference(deaths),
                  CFR        = new_deaths/new_cases)

ggplot(df.ts, aes(date, CFR)) + geom_line(aes(y=rollmean(CFR, 7, na.pad=TRUE))) + labs(y = "Case Fatality Rate in Oklahoma\n(7-day rolling average)", x = "Date") + theme_minimal()

# Cleveland County
df.clev <- covid19(country=c("US"),level=3) %>% filter(administrative_area_level_2=="Oklahoma" & administrative_area_level_3=="Cleveland")
df.ts <- as_tsibble(df.clev, key=id, index=date)
df.ts %<>% mutate(new_cases = difference(confirmed))

ggplot(df.ts, aes(date, new_cases)) + geom_hline(yintercept = 50) + geom_line(aes(y=rollmean(new_cases, 7, na.pad=TRUE))) + labs(y = "New Daily Cases in Cleveland County\n(7-day rolling average)", x = "Date") + theme_minimal()
ggplot(df.ts %>% filter(date>"2020-10-01"), aes(date, new_cases)) + geom_hline(yintercept = 50) + geom_line(aes(y=rollmean(new_cases, 7, na.pad=TRUE))) + labs(y = "New Daily Cases in Cleveland County\n(7-day rolling average)", x = "Date") + theme_minimal()
ggplot(df.ts %>% filter(date>"2020-12-01"), aes(date, new_cases)) + geom_hline(yintercept = 50) + geom_line(aes(y=rollmean(new_cases, 7, na.pad=TRUE))) + labs(y = "New Daily Cases in Cleveland County\n(7-day rolling average)", x = "Date") + theme_minimal()
