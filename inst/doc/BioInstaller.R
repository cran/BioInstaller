## ---- echo = FALSE-------------------------------------------------------
knitr::opts_chunk$set(comment = "#>", collapse = TRUE)

## ------------------------------------------------------------------------
library(BioInstaller)

# Show all avaliable softwares/dependece in default inst/extdata/config/github/github.toml 
# and inst/extdata/config/nongithub/nongithub.toml
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
# Get all meta source files
meta_files <- get.meta.files()
meta_files

# Get all of meta informaton in BioInstaller
meta <- get.meta()
meta

# Examples of get.meta
db_cfg_meta <- get.meta(value = "cfg_meta", config = 'db')
db_cfg_meta

db_cfg_meta_parsed <- get.meta(value = 'cfg_meta', config = 'db', read.config.params = list(rcmd.parse = TRUE))
db_cfg_meta_parsed

db_cfg_meta <- get.meta(config = 'github', value = 'item')
db_cfg_meta$bwa

# Get databases meta file
db_meta_file <- get.meta(config = 'db_meta_file')
db_meta_file
db_meta_file <- meta_files[["db_meta_file"]]
db_meta_file

## ------------------------------------------------------------------------
# get all database name
library(stringr)
x <- install.bioinfo(show.all.names = T)
x <- x[str_detect(x, "^db_")]
x

# all databases config 
db_cfg_meta <- get.meta(config = 'db', value = 'cfg_meta', 
                        read.config.params=list(rcmd.parse = TRUE))
cfg_dir <- db_cfg_meta$cfg_dir
cfg_dir
avaliable_cfg <- db_cfg_meta$avaliable_cfg
avaliable_cfg
sprintf("%s/%s", cfg_dir, avaliable_cfg)

# ANNOVAR
download.dir <- sprintf('%s/db_annovar', tempdir())
config.toml <- system.file("extdata", "config/db/db_annovar.toml", 
  package = "BioInstaller")
#install.bioinfo('db_ucsc_refgene', download.dir = download.dir, 
#  nongithub.cfg = config.toml, extra.list = list(buildver = "hg19"))

# db_main
download.dir <- sprintf('%s/db_main', tempdir())
config.toml <- system.file("extdata", "config/db/db_main.toml", 
  package = "BioInstaller")
install.bioinfo('db_diseaseenhancer', download.dir = download.dir, 
  nongithub.cfg = config.toml)

