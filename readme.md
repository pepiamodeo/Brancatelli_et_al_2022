
# Data and R scripts for the article Brancatelli *et al* 2022. Demographic Model for Aleppo Pine Invading Argentinean Grasslands
## Journal *Ecological Modelling*

Authors: 

* Brancatelli, G.I.E.
* Amodeo, M.R. 
* Zalba, S.M. 

This repository is preserved by Zenodo at <!-- [![DOI](https://.svg)](https://zenodo.org/)-->

### Project description

This R project consists in the datasets and scripts used for the analyses and plots exposed in the article. 

*Pinus halepensis* is an invasive species in Sierra de la Ventana mountains in the southwest of Buenos Aires Province, Argentina. We combined information on the biology of the species in its native range with our own data in the invaded area to develop a population model aimed at understanding the invasion process and detecting key parameters associated with its success. A 12 x 12 stage-structured matrix model was used to describe the dynamics of the species in the area, through deterministic and stochastic projections.

* Folder */data*. Datasets in CSV format: 
    - ConeCount.csv: cone production by sampled trees 
    - data_matrices.csv: stage-based demographic matrix for deterministic projections
    - MeanParam.csv: mean and standard deviation of each demographic parameter

* Folder */R*. R scripts containing custom functions used for data loading and matrix constructions. They are called from the main scripts in the analyses folder (relative path indicated).

* Folder */analyses*. R scripts for conducting the main analyses in the article. They are supposed to be run within the Rproject environment (relative path indicated).

* Folder */output*. Figures and table in pdf format.

For a full description of the study, data, experimental design, analyses and conclusions please see the published article Brancatelli *et al* 2022 in Ecological Modelling.
