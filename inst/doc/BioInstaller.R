## ---- echo = FALSE-------------------------------------------------------
knitr::opts_chunk$set(comment = "#>", collapse = TRUE)

## ------------------------------------------------------------------------
library(BioInstaller)

# Show all avaliable softwares/dependece in default inst/extdata/github.toml 
# and inst/extdata/nongithub.toml
install.bioinfo(show.all.names = TRUE)

# Fetching versions of softwares
install.bioinfo('samtools', show.all.versions = TRUE)

# Install 'demo' with debug infomation
download.dir <- sprintf('%s/demo_2', tempdir())
install.bioinfo('demo', download.dir = download.dir, verbose = TRUE)

# Download demo source code
download.dir <- sprintf('%s/demo_3', tempdir())
install.bioinfo('demo', download.dir = download.dir,
  download.only = TRUE, verbose = TRUE)

# Set download.dir and destdir (destdir like /usr/local 
# including bin, lib, include and others), 
# destdir will work if install step {{destdir}} be used
download.dir <- sprintf('%s/demo_source', tempdir())
destdir <- sprintf('%s/demo', tempdir())
install.bioinfo('demo', download.dir = download.dir, destdir = destdir)

## ------------------------------------------------------------------------
temp.db <- tempfile()
set.biosoftwares.db(temp.db)
is.biosoftwares.db.active(temp.db)

# Install 'demo' quite
download.dir <- sprintf('%s/demo_1', tempdir())
install.bioinfo('demo', download.dir = download.dir, verbose = FALSE)
config <- get.info('demo')
config

config <- configr::read.config(temp.db)
config$demo$comments <- 'This is a demo.'
params <- list(config.dat = config, file.path = temp.db)
do.call(configr::write.config, params)
get.info('demo')
del.info('demo')

## ------------------------------------------------------------------------
download.dir <- sprintf('%s/github_demo_local', tempdir())
install.bioinfo('github_demo', download.dir = download.dir, download.only = TRUE, verbose = FALSE)
install.bioinfo('github_demo', local.source = download.dir)

download.dir <- sprintf('%s/demo_local', tempdir())
install.bioinfo('demo_2', download.dir = download.dir, download.only = TRUE, verbose = FALSE)
install.bioinfo('demo_2', download.dir = download.dir, local.source = sprintf('%s/GRCh37_MT_ensGene.txt.gz', download.dir), decompress = TRUE)

## ------------------------------------------------------------------------
download.dir <- sprintf('%s/craw_all_versions', tempdir())
craw.all.versions('demo', download.dir = download.dir)

## ------------------------------------------------------------------------
download.dir <- sprintf('%s/ANNOVAR', tempdir())
config.toml <- system.file("extdata", "databases/ANNOVAR.toml", 
  package = "BioInstaller")
install.bioinfo('raw_ucsc_refgene', download.dir = download.dir, 
  nongithub.cfg = config.toml, extra.list = list(buildver = "hg19"))

