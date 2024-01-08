rm(list=ls())
library("ggplot2")
library("dplyr") 
library(ggpubr)

xdata <- read.csv(file = 'globalspeclist.csv', header=TRUE)
taxalist<-read.csv("taxlist.csv")

xdata$family <- taxalist$family[match(xdata$higher_taxon,taxalist$genus)]
xdata$order <- taxalist$order[match(xdata$higher_taxon,taxalist$genus)]

table(xdata$sound.production)# number of species supposed and confirmed to produce sounds.
table(xdata$family[which(xdata$sound.production=='Y')])# number of species per family that are known to produce sounds
length(which(rowSums(is.na(xdata[which(xdata$sound.production=='Y'), 8:14]))==0))#soniferous species for which we have all the info

length(which(is.na(xdata$lifestage)))#number of species lacking info about lifestage
length(which(is.na(xdata$sex)))#number of species lacking info about sex
length(which(is.na(xdata$mechanism)))#number of species lacking info about lifestage
length(which(is.na(xdata$frequency.range)))#number of species lacking info about frequency range
length(which(is.na(xdata$behavioural.context)))#number of species lacking info about behavioural context

table(xdata$lifestage)#number of species for each lifestage type


count.data <- data.frame(table(xdata$order))
names(count.data) <-  c('order', 'proportion')
count.data <- count.data[order(count.data$proportion),]
count.data$lab.ypos <- cumsum(count.data$proportion) - 0.5*count.data$proportion
count.data$lab.xpos <- c(1.1,1,1,1)

mycols <- c("#0073C2FF", "#EFC000FF", "#868686FF", "#CD534CFF")

p1 <- ggplot(count.data, aes(x = "", y = proportion, fill = order)) + geom_bar(width = 1, stat = "identity") +  coord_polar("y", start = 0) + theme_void() + geom_text(aes(x=lab.xpos,y = lab.ypos, label = proportion), color = "black") + scale_fill_manual(values = mycols)

count.data.coleo <- data.frame(table(xdata$family[xdata$order=='Coleoptera']))
names(count.data.coleo) <-  c('family', 'proportion')
count.data.coleo <- count.data.coleo[order(count.data.coleo$proportion),]
count.data.coleo$lab.ypos <- sum(count.data.coleo$proportion) - cumsum(count.data.coleo$proportion) + 0.5*count.data.coleo$proportion
count.data.coleo$family <- factor(count.data.coleo$family, levels=as.character(count.data.coleo$family))
count.data.coleo$lab.xpos <- c(1.1, 1.2, 1.3,1,1,1,1,1)

p2 <- ggplot(count.data.coleo, aes(x = "", y = proportion, fill = family)) + geom_bar(width = 1, stat = "identity") +  coord_polar("y", start = 0) + theme_void() + geom_text(aes(y = lab.ypos, x=lab.xpos, label = proportion), color = "black")

count.data.hemi <- data.frame(table(xdata$family[xdata$order=='Hemiptera']))
names(count.data.hemi) <-  c('family', 'proportion')
count.data.hemi <- count.data.hemi[order(count.data.hemi$proportion),]
count.data.hemi$lab.ypos <- sum(count.data.hemi$proportion) - cumsum(count.data.hemi$proportion) + 0.5*count.data.hemi$proportion
count.data.hemi$family <- factor(count.data.hemi$family, levels=as.character(count.data.hemi$family))
count.data.hemi$lab.xpos <- c(1.1, 1.2, 1.3,1,1,1,1,1)

p3 <- ggplot(count.data.hemi, aes(x = "", y = proportion, fill = family)) + geom_bar(width = 1, stat = "identity") +  coord_polar("y", start = 0) + theme_void() + geom_text(aes(y = lab.ypos, x=lab.xpos, label = proportion), color = "black")

ggarrange(p1, p2, p3,ncol = 3, nrow=1, labels = c('(a)', '(b)', "(c)"), font.label = 'italic')
ggsave("speciestaxodistrib.jpg", width=30, height=12, unit='cm')

