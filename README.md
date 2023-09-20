# jab.adverse.reactions

Provides data about the possible adverse events/reactions resulting from being injected with a vaccine/experimental gene therapy. Currently, this data set only includes data from six reference sources.  

For information about the hazards of vaccination$/immunization$/experimental gene therapie$, visit:  

- [Questioning the Universe Publishing: Resources to help us rethink, reimagine, & reFeel our world: Vaccination$](https://www.questionuniverse.com/rethink.html#vaccine),  

- [EcoC2S: Resources for a Healthier You (Resources to help us take responsibility back to heal ourselves and each other): Vaccination$](https://www.ecoccs.com/healing.html#vaccines),  

- [Questioning the Universe Publishing: Resources to help us rethink the current crisis (in perception): "Coronavirus" Vaccination$ Experimental Gene Therapy Technology](https://www.questionuniverse.com/rethink_current_crisis.html#cov_vaccin>),  

- [Questioning the Universe Publishing: COVID-19 Vaccination/Experimental Gene Therapy & What You Are Not Being Told (This is Just the "Tip of the Iceberg")](https://www.questionuniverse.com/vaccination.html).  




# Installation from the CRAN repository

To install the package from the [CRAN repository](https://CRAN.R-project.org/package=jab.adverse.reactions), please do the following in R:  

```R
install.packages("jab.adverse.reactions")
```


# Help

With credit due to the `matlab` package, for a complete list of functions and the package DESCRIPTION file, use:  

```R
library(help = "jab.adverse.reactions")
```


# Package Contents

This package contains a single data set:  

* `jab_adverse_reactions`: A collection of adverse events/reactions resulting from an injection with a vaccine/experimental gene therapy




# Examples

```R

install.load::load_package("jab.adverse.reactions", "data.table")

# load jab.adverse.reactions data
data(jab_adverse_reactions)

# View the data set
View(jab_adverse_reactions)

# Print the data set using data.table
jab_adverse_reactions

```



# For non-R users

There is a subfolder of the inst folder named public which contains the data contained in this R package in the following formats:  

- CSV (https://gitlab.com/iembry/jab.adverse.reactions.full/-/blob/master/inst/public/jab_adverse_reactions.csv)

- JSON (https://gitlab.com/iembry/jab.adverse.reactions.full/-/blob/master/inst/public/jab_adverse_reactions.json)

- XML (https://gitlab.com/iembry/jab.adverse.reactions.full/-/blob/master/inst/public/jab_adverse_reactions.xml)



# R package citation

If you wish to cite the `jab.adverse.reactions` R package, I have enclosed the preferred citation in BibTex format:  

@Manual{embry:2022,  
  title = {jab.adverse.reactions: Possible Adverse Events/Reactions from the Vaccinations/Experimental Gene Therapies},  
  author = {Irucka Embry},  
  year = {2022},  
  url = {https://gitlab.com/iembry/jab.adverse.reactions},  
  abstract = {Provides data about the possible adverse events/reactions resulting from being injected with a vaccine/experimental gene therapy. Currently, the data is only from three reference sources. Refer to the Citation file for the reference information. For information about vaccination$/immunization$ hazards, visit <https://www.questionuniverse.com/rethink.html#vaccine>, <https://www.ecoccs.com/healing.html#vaccines>, <https://www.questionuniverse.com/rethink_current_crisis.html#cov_vaccin>, and <https://www.questionuniverse.com/vaccination.html>.},  
  version = {1.0.1}  
}  
