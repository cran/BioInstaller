## ---- echo = FALSE-------------------------------------------------------
knitr::opts_chunk$set(comment = "#>", collapse = TRUE)

## ------------------------------------------------------------------------
library(configr)
library(BioInstaller)
blast.databases <- system.file('extdata', 
  'nongithub_databases_blast.toml', package = 'BioInstaller')

read.config(blast.databases)$blast_db_nr$source_url
read.config(blast.databases, glue.parse = TRUE)$blast_db_nr$source_url
mask.github <- tempfile()
file.create(mask.github)
install.bioinfo(nongithub.cfg = blast.databases, github.cfg = mask.github,
  show.all.names = TRUE)

