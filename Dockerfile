FROM virtualstaticvoid/heroku-docker-r:plumber

# install pkgs
RUN R -e "install.packages('plumber', dependencies = TRUE)"
RUN R -e "install.packages('xml2', dependencies = TRUE)"
RUN R -e "install.packages('tidyRSS', dependencies = TRUE)"
RUN R -e "install.packages('tidyverse', dependencies = TRUE)"
RUN R -e "install.packages('glue', dependencies = TRUE)"
RUN R -e "install.packages('future', dependencies = TRUE)"
RUN R -e "install.packages('magrittr', dependencies = TRUE)"
RUN R -e "install.packages('operator.tools', dependencies = TRUE)"

COPY / /
ENV PORT 8080
CMD ["/usr/bin/R", "--no-save", "--gui-none", "-f", "/api-googlenews/main.R"]
#CMD ["Rscript", "main.R"]