### Noel Cope
### April 21, 2023
### Description: Split AQAD NEI data into individual files by SPPD group.

#Import library to read in excel files
library(readxl)
library(dplyr)
library(readr)

#Read in 2020 NEI data from AQAD
NEI <- "emis_sum_fac_2020NEI_v2_April 19 2023.xlsx"
NEI <- read_excel(NEI)
NEI <- as.data.frame(NEI)

#Read in sectors_toNAICS_ToSPPDGroup data from access database
sectors_SPPDgrp <- "sectors_ToNAICS_ToSPPDGroup.xlsx"
sectors_SPPDgrp <- read_excel(sectors_SPPDgrp)
sectors_SPPDgrp <- as.data.frame(sectors_SPPDgrp)
colnames(sectors_SPPDgrp)[3] <- "primary naics code"


#Merge sectors with NEI data by NAICS
NEI_sectors_SPPDgrp <- merge(NEI, sectors_SPPDgrp, by = "primary naics code", all.x=TRUE)

#Edit SPPD group labels
NEI_sectors_SPPDgrp[NEI_sectors_SPPDgrp$sector_3 == "Commercial Sterilization" & !is.na(NEI_sectors_SPPDgrp$sector_3), "SPPD Group"] <- "MMG"
NEI_sectors_SPPDgrp[NEI_sectors_SPPDgrp$sector_3 == "Oil and Gas Production and Distribution" & !is.na(NEI_sectors_SPPDgrp$sector_3), "SPPD Group"] <- "FIG"
NEI_sectors_SPPDgrp[NEI_sectors_SPPDgrp$`primary naics description` == "Drycleaning and Laundry Services (except Coin-Operated)" & !is.na(NEI_sectors_SPPDgrp$sector_3), "SPPD Group"] <- "MICG"
NEI_sectors_SPPDgrp[NEI_sectors_SPPDgrp$`primary naics description` == "Oil and Gas Pipeline and Related Structures Construction" & !is.na(NEI_sectors_SPPDgrp$sector_3), "SPPD Group"] <- "FIG"
NEI_sectors_SPPDgrp$`SPPD Group`[NEI_sectors_SPPDgrp$`SPPD Group` == "CCG"] <- "MMG"

#Split NEI data based on SPPD group
FIG <- filter(NEI_sectors_SPPDgrp, `SPPD Group` == "FIG")
MMG <- filter(NEI_sectors_SPPDgrp, `SPPD Group` == "MMG")
RCG <- filter(NEI_sectors_SPPDgrp, `SPPD Group` == "RCG")
ESG <- filter(NEI_sectors_SPPDgrp, `SPPD Group` == "ESG")
MICG <- filter(NEI_sectors_SPPDgrp, `SPPD Group` == "MICG")
NRG <- filter(NEI_sectors_SPPDgrp, `SPPD Group` == "NRG")

#write files for SPPD groups
path <- "C:/Users/NCOPE/OneDrive - Environmental Protection Agency (EPA)/CPRG-Data-Analysis/SPPD Groups/"
write.csv(FIG, file = paste0(path, "FIG", ".csv"))
write.csv(MMG, file = paste0(path, "MMG", ".csv"))
write.csv(RCG, file = paste0(path, "RCG", ".csv"))
write.csv(ESG, file = paste0(path, "ESG", ".csv"))
write.csv(MICG, file = paste0(path, "MICG", ".csv"))
write.csv(NRG, file = paste0(path, "NRG", ".csv"))

NEI_sectors_SPPDgrp <- subset (NEI_sectors_SPPDgrp, select = -`SPPD Group`)

#Split NEI data based on industry sector
NEI_sectors_SPPDgrp$sector_2 <- factor(NEI_sectors_SPPDgrp$sector_2)
agriculture <- as.data.frame(filter(NEI_sectors_SPPDgrp, sector_2 == levels(NEI_sectors_SPPDgrp$sector_2)[1]))
chemicals <- as.data.frame(filter(NEI_sectors_SPPDgrp, sector_2 == levels(NEI_sectors_SPPDgrp$sector_2)[2]))
commercial <- as.data.frame(filter(NEI_sectors_SPPDgrp, sector_2 == levels(NEI_sectors_SPPDgrp$sector_2)[3]))
construction <- as.data.frame(filter(NEI_sectors_SPPDgrp, sector_2 == levels(NEI_sectors_SPPDgrp$sector_2)[4]))
manufacturing <- as.data.frame(filter(NEI_sectors_SPPDgrp, sector_2 == levels(NEI_sectors_SPPDgrp$sector_2)[5]))
electric <- as.data.frame(filter(NEI_sectors_SPPDgrp, sector_2 == levels(NEI_sectors_SPPDgrp$sector_2)[6]))
metals <- as.data.frame(filter(NEI_sectors_SPPDgrp, sector_2 == levels(NEI_sectors_SPPDgrp$sector_2)[7]))
institutions <- as.data.frame(filter(NEI_sectors_SPPDgrp, sector_2 == levels(NEI_sectors_SPPDgrp$sector_2)[8]))
indust_prod <- as.data.frame(filter(NEI_sectors_SPPDgrp, sector_2 == levels(NEI_sectors_SPPDgrp$sector_2)[9]))
minerals <- as.data.frame(filter(NEI_sectors_SPPDgrp, sector_2 == levels(NEI_sectors_SPPDgrp$sector_2)[10]))
misc <- as.data.frame(filter(NEI_sectors_SPPDgrp, sector_2 == levels(NEI_sectors_SPPDgrp$sector_2)[11]))
oilgas <- as.data.frame(filter(NEI_sectors_SPPDgrp, sector_2 == levels(NEI_sectors_SPPDgrp$sector_2)[12]))
petro <- as.data.frame(filter(NEI_sectors_SPPDgrp, sector_2 == levels(NEI_sectors_SPPDgrp$sector_2)[13]))
private <- as.data.frame(filter(NEI_sectors_SPPDgrp, sector_2 == levels(NEI_sectors_SPPDgrp$sector_2)[14]))
trans <- as.data.frame(filter(NEI_sectors_SPPDgrp, sector_2 == levels(NEI_sectors_SPPDgrp$sector_2)[15]))
waste <- as.data.frame(filter(NEI_sectors_SPPDgrp, sector_2 == levels(NEI_sectors_SPPDgrp$sector_2)[16]))

#Write excel files for industry sectors
path <- "C:/Users/NCOPE/OneDrive - Environmental Protection Agency (EPA)/CPRG-Data-Analysis/Industry Sectors/"
write.csv(agriculture, file = paste0(path,levels(NEI_sectors_SPPDgrp$sector_2)[1],".csv"))
write.csv(chemicals, file = paste0(path,levels(NEI_sectors_SPPDgrp$sector_2)[2],".csv"))
write.csv(commercial, file = paste0(path,levels(NEI_sectors_SPPDgrp$sector_2)[3],".csv"))
write.csv(construction, file = paste0(path,levels(NEI_sectors_SPPDgrp$sector_2)[4],".csv"))
write.csv(manufacturing, file = paste0(path,levels(NEI_sectors_SPPDgrp$sector_2)[5],".csv"))
write.csv(electric, file = paste0(path,levels(NEI_sectors_SPPDgrp$sector_2)[6],".csv"))
write.csv(metals, file = paste0(path,levels(NEI_sectors_SPPDgrp$sector_2)[7],".csv"))
write.csv(institutions, file = paste0(path,levels(NEI_sectors_SPPDgrp$sector_2)[8],".csv"))
write.csv(indust_prod, file = paste0(path,"Industrial Production",".csv"))
write.csv(minerals, file = paste0(path,levels(NEI_sectors_SPPDgrp$sector_2)[10],".csv"))
write.csv(misc, file = paste0(path,levels(NEI_sectors_SPPDgrp$sector_2)[11],".csv"))
write.csv(oilgas, file = paste0(path,levels(NEI_sectors_SPPDgrp$sector_2)[12],".csv"))
write.csv(petro, file = paste0(path,levels(NEI_sectors_SPPDgrp$sector_2)[13],".csv"))
write.csv(private, file = paste0(path,levels(NEI_sectors_SPPDgrp$sector_2)[14],".csv"))
write.csv(trans, file = paste0(path,levels(NEI_sectors_SPPDgrp$sector_2)[15],".csv"))
write.csv(waste, file = paste0(path,levels(NEI_sectors_SPPDgrp$sector_2)[16],".csv"))


