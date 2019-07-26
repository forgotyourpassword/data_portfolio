library(tidyverse)

# read data
budget_2011 <- read_csv("./input/source/chicago_budget/Budget_-_2011_Budget_Ordinance_-_Positions_and_Salaries.csv") %>% mutate(YEAR = 2011)
budget_2012 <- read_csv("./input/source/chicago_budget/Budget_-_2012_Budget_Ordinance_-_Positions_and_Salaries.csv") %>% mutate(YEAR = 2012)
budget_2013 <- read_csv("./input/source/chicago_budget/Budget_-_2013_Budget_Ordinance_-_Positions_and_Salaries.csv") %>% mutate(YEAR = 2013)
budget_2014 <- read_csv("./input/source/chicago_budget/Budget_-_2014_Budget_Ordinance_-_Positions_and_Salaries.csv") %>% mutate(YEAR = 2014)
budget_2015 <- read_csv("./input/source/chicago_budget/Budget_-_2015_Budget_Ordinance_-_Positions_and_Salaries.csv") %>% mutate(YEAR = 2015)
budget_2016 <- read_csv("./input/source/chicago_budget/Budget_-_2016_Budget_Ordinance_-_Positions_and_Salaries.csv") %>% mutate(YEAR = 2016)
budget_2017 <- read_csv("./input/source/chicago_budget/Budget_-_2017_Budget_Ordinance_-_Positions_and_Salaries.csv") %>% mutate(YEAR = 2017)
budget_2018 <- read_csv("./input/source/chicago_budget/Budget_-_2018_Budget_Ordinance_-_Positions_and_Salaries.csv") %>% mutate(YEAR = 2018)
budget_2019 <- read_csv("./input/source/chicago_budget/Budget_-_2019_Budget_Ordinance_-_Positions_and_Salaries.csv") %>% mutate(YEAR = 2019)

# add columns to years where they're missing
  #2011
  budget_2011$`BARGAINING UNIT` <- NA
  names(budget_2011)[names(budget_2011)=="DEPARTMENT NAME"] <- "DEPARTMENT DESCRIPTION"
  names(budget_2011)[names(budget_2011)=="DIVISION NAME"] <- "DIVISION DESCRIPTION"
  names(budget_2011)[names(budget_2011)=="FUND NAME"] <- "FUND DESCRIPTION"
  names(budget_2011)[names(budget_2011)=="SECTION NAME"] <- "SECTION DESCRIPTION"
  names(budget_2011)[names(budget_2011)=="SCHEDULE"] <- "SCHEDULE / GRADE"
  names(budget_2011)[names(budget_2011)=="TOTAL BUDGETED UNITS"] <- "TOTAL BUDGETED UNIT"
  names(budget_2011)[names(budget_2011)=="SUBSECTION CODE"] <- "SUB-SECTION CODE"
  names(budget_2011)[names(budget_2011)=="SUBSECTION NAME"] <- "SUB-SECTION DESCRIPTION"
  budget_2011 <- within(budget_2011,rm("DEPARTMENT"))
  
  #2012
  names(budget_2012)[names(budget_2012)=="DEPARTMENT NUMBER"] <- "DEPARTMENT CODE"
  names(budget_2012)[names(budget_2012)=="SCHEDULE/GRADE"] <- "SCHEDULE / GRADE"
  
  #2011-2013
  budget_2011$`ORGANIZATION DESCRIPTION` <- NA
  budget_2012$`ORGANIZATION DESCRIPTION` <- NA
  budget_2013$`ORGANIZATION DESCRIPTION` <- NA

# bind together
budget <- rbind(budget_2011,budget_2012,budget_2013,budget_2014,budget_2015,budget_2016,budget_2017,budget_2018,budget_2019)

# make department names consistent
  ## load the mapping table
  DepartmentNameMap <- read.csv("./input/source/chicago_budget/Department Mapping Table.csv",stringsAsFactors = F)

  ## use the mapping table to replace the production data
    for (row in 1:NROW(DepartmentNameMap)) {
      from <- DepartmentNameMap[row,1]
      to <- DepartmentNameMap[row,2]
      budget$`DEPARTMENT DESCRIPTION` <- str_replace(budget$`DEPARTMENT DESCRIPTION`,from,to)
    }

# write the output file
write_rds(budget,"./input/source/chicago_budget/Chicago Budget.Rds")
