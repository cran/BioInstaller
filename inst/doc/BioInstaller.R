## ---- echo = FALSE-------------------------------------------------------
knitr::opts_chunk$set(comment = "#>", collapse = TRUE)

## ------------------------------------------------------------------------
library(BioInstaller)

# Show all avaliable softwares/dependece in default inst/extdata/github.toml 
# and inst/extdata/nongithub.toml
install.bioinfo(show.all.names = TRUE)

# Fetching versions of softwares
install.bioinfo('samtools', show.all.versions = TRUE)

# Install 'demo' quite
download.dir <- sprintf('%s/demo_1', tempdir())
install.bioinfo('demo', download.dir = download.dir, verbose = FALSE)

# Install 'demo' with debug infomation
download.dir <- sprintf('%s/demo_2', tempdir())
install.bioinfo('demo', download.dir = download.dir, verbose = TRUE)

# Download demo source code
download.dir <- sprintf('%s/demo_3', tempdir())
install.bioinfo('demo', download.dir = download.dir,
  download.only = TRUE, verbose = TRUE)

# Set download.dir rrr destdir (destdir like /usr/local 
# including bin, lib, include and others), 
# destdir will work if install step {{destdir}} be used
download.dir <- sprintf('%s/demo_source', tempdir())
destdir <- sprintf('%s/demo', tempdir())
install.bioinfo('demo', download.dir = download.dir, destdir = destdir)

## ------------------------------------------------------------------------
temp.db <- tempfile()
set.biosoftwares.db(temp.db)
is.biosoftwares.db.active(temp.db)
params <- list(name = 'demo', comments = 'This is a demo.')
do.call(change.info, params)
get.info('demo')
del.info('demo')

