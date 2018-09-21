#Code File 1 for lapstartup project
#Example R File for Data Analysis
#Created Elise Larsen 2018-09-20, Ries Lab, Georgetown University


######################
# Best practices Notes
# Use r projects so you don't need individualized directories
# Change RStudio setting to never save workspace
# Command rm(list=ls()) removes all objects from the current workspace


############################
#1. Load necessary libraries
library(ggplot2)
#If error: install.packages("ggplot2")


##########################################
#2. Source code files (new functions, etc)
source("src/degday1.R")
#degday1.R contains the degreedays() FUNCTION which calculates daily degree days using the single sine method
#degreedays=function(tmin,tmax,ldt,udt)


###############
#3. Import data
#NOAA temperature data from some MD stations
md.noaa.raw<-read.csv("data/2005_noaa_md.csv", header=T)


#################
#4. Data cleaning
names(md.noaa.raw)
#new data object with only the columns I'm interested in
md.noaa<-md.noaa.raw[,c(2,3,5:8,11,15:16)]
summary(md.noaa)

##Data table includes 3 stations but 1 has significantly less data
#Identify any stations without a full year of data
bad.stns<-which(by(md.noaa,md.noaa$STATION,nrow)<365)
#Remove data for these stations
md.noaa<-subset(md.noaa, !(md.noaa$STATION %in% levels(md.noaa$STATION)[bad.stns]))
#Refactor levels of station to remove ones without data
md.noaa$STATION<-factor(md.noaa$STATION)

##Temperature data has values (-9999) that represent missing data
md.noaa.real<-subset(md.noaa, md.noaa$TMIN > -100 )


#####################
#5.Data visualization
ggplot(md.noaa.real, aes(JULIAN_DAY, TMAX)) +
  geom_point() 

