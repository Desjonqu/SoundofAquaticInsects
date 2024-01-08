# SoundofAquaticInsects
data and code linked to the manuscript titled "The potential of acoustic monitoring of aquatic insects for freshwater assessment" by Camille Desjonquères, Simon Linke, Jack Greenhalgh, Fanny Rybak, and Jérôme Sueur. 

This repository contains 6 files:
- two data tables
- three R scripts

The two data tables are globalspeclist.csv and taxlist.csv. 
- taxlist.csv contains the names of the aquatic insect genera that contain sound producing species and were querried in GBIF
- globalspeclist.csv list of species that are within the genera expected to produce sounds and information about sound production mechanisms, lifestage, sex, frequency range, behavioural context and reference.

The two scripts are: gbif.R and suppl1.R
- gbif.R allows to querry GBIF and get the names of species in each genera that contain sound producing species.
- suppl1.R allows to get counts of missing values and generate graphs for figure 1.
