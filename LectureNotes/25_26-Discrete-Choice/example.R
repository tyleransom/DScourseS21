
library(tidyverse)
library(magrittr)
library(mlogit)
data(Heating) # load data on residential heating choice in CA
levels(Heating$depvar) <- c("gas","gas","elec","elec","elec")
estim <- glm(depvar ~ income+agehed+rooms+region,
             family=binomial(link='logit'),data=Heating)
print(summary(estim))

# get predictions
Heating %<>% mutate(predLogit = predict(estim, newdata = Heating, type = "response"))
Heating %>% `$`(predLogit) %>% summary %>% print

estim2 <- glm(depvar ~ income+agehed+rooms+region,
              family=binomial(link='probit'),data=Heating)
print(summary(estim2))
Heating %<>% mutate(predProbit = predict(estim2, newdata = Heating, type = "response"))
Heating %>% `$`(predProbit) %>% summary %>% print

# counterfactual policy
estim$coefficients["income"] <- 4*estim$coefficients["income"]
Heating %<>% mutate(predLogitCfl = predict(estim, newdata = Heating, type = "response"))
Heating %>% `$`(predLogitCfl) %>% summary %>% print


# heckman selection
library(sampleSelection)
data('Mroz87')
Mroz87 %<>% mutate(kids = (kids5 + kids618) > 0)
Mroz87 <- Mroz87 %>% mutate(log_wageNA = case_when(wage==0 ~ NA_real_, TRUE ~ log(wage)))
Mroz87 <- Mroz87 %>% mutate(log_wage   = case_when(wage==0 ~ 0, TRUE ~ log(wage)))
# Comparison of linear regression and selection model
outcome1 <- lm(log_wageNA ~ exper, data = Mroz87)
summary(outcome1)
selection1 <- selection(selection = lfp ~ age + I(age^2) + faminc + kids + educ,
                        outcome = log_wage ~ exper, data = Mroz87, method = '2step')
summary(selection1)

