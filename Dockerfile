FROM rocker/r-ver:4.0.5
#FROM virtualstaticvoid/heroku-docker-r:plumber

RUN apt-get update -qq && apt-get install -y \
    libssl-dev \
    git-core \
    libssl-dev \
    libcurl4-gnutls-dev \
    curl \
    libsodium-dev \
    libxml2-dev \
    gcc \
    gsl-bin \
    libblas-dev

# install pkgs
RUN R -e "install.packages('plumber', dependencies = TRUE)"
RUN R -e "install.packages('xml2', dependencies = TRUE)"
RUN R -e "install.packages('tidyRSS', dependencies = TRUE)"
RUN R -e "install.packages('tidyverse', dependencies = TRUE)"
RUN R -e "install.packages('glue', dependencies = TRUE)"
RUN R -e "install.packages('future', dependencies = TRUE)"
RUN R -e "install.packages('magrittr', dependencies = TRUE)"
RUN R -e "install.packages('operator.tools', dependencies = TRUE)"

COPY / /app
WORKDIR /app
ENV PORT 8080
CMD ["Rscript", "main.R"]