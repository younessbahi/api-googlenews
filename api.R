plan(multisession)

#* @apiTitle Google News API
#* @apiDescription A Google News API alternative
#* @apiContact list(name = "Youness Bahi", url = "http://www.example.com/support", email = "support@example.com")
#* @apiVersion 1.0

#* @filter cors
cors <-
  function(req, res) {
    res$setHeader("Access-Control-Allow-Origin", "*")
    if (req$REQUEST_METHOD == "OPTIONS") {
      req$setHeader("Access-Control-Allow-Methods", "*")
      req$setHeader("Access-Control-Allow-Headers", req$HTTP_ACCESS_CONTROL_REQUEST_HEADERS)
      req$status <- 200
      return(list())
    } else {
      plumber::forward()
    }
  }

#* Get data from Custom Query
#* @param q Search term
#* @param country Optional - Country alpha‑2 code
#* @get /search
custom_query <- function(q, country = 'US', res, req) {
  
  a2c <- countryCode[countryCode$Country == str_to_title({ country }),]$Alpha.2.code
  loc_ <-
    if (str_length(country) > 2) {
      ifelse(is_empty(a2c),'invalid country name', a2c)
    } else if (str_length(country) == 2) {
      str_to_upper(country)
    } else {
      NA
    }
  
  if (is.na(loc_)) {
    res$status <- 1001
    return(err_handler(1001, var = country))
  } else if (loc_ == 'invalid country name') {
    res$status <- 1003
    return(err_handler(1003, var = country))
  } else if (loc_ %!in% countryCode$Alpha.2.code | is_empty(loc_)) {
    res$status <- 1002
    return(err_handler(1002, var = country))
  }
  
  loc_ <- paste0('gl=', loc_)
  
  url_ <- sprintf('https://news.google.com/rss/search?q=%s&%s', q, loc_)
  
  get.feed(url = url_, cat = 'custom')
  
}

#* Get data from Google News guide
#* @param category Choose from pre-defined news topics
#* @param country Optional - Country alpha‑2 code or country name
#* @get /topic
news_topics <- function(category, country = 'US', res, req) {
  
  a2c <- countryCode[countryCode$Country == str_to_title({ country }),]$Alpha.2.code
  loc_ <-
    if (str_length(country) > 2) {
      ifelse(is_empty(a2c),'invalid country name', a2c)
    } else if (str_length(country) == 2) {
      str_to_upper(country)
    } else {
      NA
    }
  
  if (is.na(loc_)) {
    res$status <- 1001
    return(err_handler(1001, var = country))
  } else if (loc_ == 'invalid country name') {
    res$status <- 1003
    return(err_handler(1003, var = country))
  } else if (loc_ %!in% countryCode$Alpha.2.code | is_empty(loc_)) {
    res$status <- 1002
    return(err_handler(1002, var = country))
  }
  
  loc_ <- paste0('gl=', loc_)
  
  if (category %!in% guide$category_) {
    res$status <- 1004
    return(err_handler(status = 1004, helper = list(guide$category_), var = category))
  }
  
  url_ <-
    guide %>%
      filter(category_ == category) %>%
      select(- category_) %$%
      paste0(root_, section_, path_, loc_)
  
  get.feed(url = url_, cat = category)
  
}