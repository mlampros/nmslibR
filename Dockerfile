FROM rocker/rstudio:devel

LABEL maintainer='Lampros Mouselimis'

RUN export DEBIAN_FRONTEND=noninteractive; apt-get -y update && \
 apt-get install -y libssl-dev python pandoc pandoc-citeproc libicu-dev libcurl4-openssl-dev libpng-dev && \
 apt-get install -y sudo && \
 apt-get install -y python3-dev && \
 apt-get install -y python3-pip && \
 pip3 install numpy && \
 pip3 install scipy && \
 pip3 install --no-binary :all: nmslib && \
 R -e "install.packages(c( 'Rcpp', 'reticulate', 'R6', 'Matrix', 'KernelKnn', 'utils', 'RcppArmadillo', 'testthat', 'covr', 'knitr', 'rmarkdown', 'remotes' ), repos =  'https://cloud.r-project.org/' )" && \
 R -e "remotes::install_github('mlampros/nmslibR', upgrade = 'never', dependencies = FALSE, repos = 'https://cloud.r-project.org/')" && \
 apt-get autoremove -y && \
 apt-get clean


ENV USER rstudio
