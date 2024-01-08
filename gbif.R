rm(list=ls())
library(tidyverse)
library(rgbif)
library(taxize)

#function to check if this is an extinct species
is_extinct <- function(name, key) {
  res <- data.frame(name_lookup(name)$data)
  if (NROW(res) == 0) return(NA)
  if (NROW(res) > 1) {
    res <- res[res$key == key, ]
  }
  res$extinct %||% NA
}


#Create species list from higher taxa
taxalist<-read.csv("taxlist.csv")
taxvec<-taxalist$genus
finlist<-list()
for (taxon in 1:length(taxvec)){
    higher_taxon<-taxvec[taxon]
    htax_id<-get_gbifid(higher_taxon)
    speclist<-gbif_downstream(id = htax_id[1], downto="species", limit=1000)
    speclist$higher_taxon<-higher_taxon
    speclist$higher_taxon_id<-htax_id
    
    ext_vec <- Map(is_extinct, speclist$name, speclist$key)
    speclist$extinct <- unlist(unname(ext_vec))
    speclist <- speclist[which((speclist$extinct==FALSE)|is.na(speclist$extinct)),]
    
    finlist[[taxon]]<-speclist
}
global_speclist<-do.call(rbind,finlist)
specvec<-global_speclist$name

write.csv(x=global_speclist, file = 'globalspeclist.csv', row.names=FALSE)