library(plumber)
library(tidyRSS)
library(xml2)
library(tidyverse)
library(stringr)
library(glue)
library(magrittr)
library(future)
library(operator.tools)

source('data/load.R')
source('logic/fun.R')
source('logic/error_handling.R')

port = Sys.getenv('PORT')
server = plumber::plumb('api.R')
server$run(
  host = "0.0.0.0",
  port = as.numeric(port),
  docs = TRUE
)
