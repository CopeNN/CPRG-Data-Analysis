### Noel Cope
### April 21, 2023
### Description: Split AQAD NEI data into individual files by SPPD group.

#Import library to read in excel files
library(readxl)

#Read in 2020 NEI data from AQAD
NEI <- "emis_sum_fac_2020NEI_v2_April 19 2023.xlsx"
NEI <- read_excel(NEI)
NEI <- as.data.frame(NEI)

#Read in sectors_toNAICS data from access database
sectors <- "sectors_toNAICS.xlsx"
sectors <- read_excel(sectors)
sectors <- as.data.frame(sectors)

#Read in qry_rulesBySector data from access database
groups <- "sectors_toNAICS.xlsx"
groups <- read_excel(groups)
groups <- as.data.frame(groups)





