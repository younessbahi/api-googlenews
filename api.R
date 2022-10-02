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
  loc <-
    if (str_length(country) > 2) {
      ifelse(is_empty(a2c),'invalid country name', a2c)
    } else if (str_length(country) == 2) {
      str_to_upper(country)
    } else {
      NA
    }
  
  if (is.na(loc)) {
    res$status <- 503
    res$body <-
      return(
        err_handler(
          status = 1001,
          msg = glue::glue("[{country}] in [country] is too short, please enter a valid country name or country code.")
        )
      )
    res
  } else if (loc == 'invalid country name') {
    res$status <- 503
    res$body <-
      return(
        err_handler(
          status = 1002,
          msg = glue::glue("[{country}] is not a valid country name.")
        )
      )
    res
  } else if (loc %!in% countryCode$Alpha.2.code | is_empty(loc_)) {
    res$status <- 503
    res$body <-
      return(
        err_handler(
          status = 1003,
          msg = glue::glue("[{country}] is not valid country code")
        )
      )
    res
  }
  
  loc_ <- paste0('gl=', loc)
  
  url_ <- sprintf('https://news.google.com/rss/search?q=%s&%s', q, loc_)
  
  tryCatch(
    expr = get.feed(url = url_, cat = 'custom'),
    error = function (e) {
      res$status <- 500
      res$body <-
        return(
          err_handler(
            status = 1005,
            msg = glue::glue("Sorry! No news found for [{q}] in {loc}")
          )
        )
      res
    }
  )
  
}

#* Get data from Google News guide
#* @param category Choose from pre-defined news topics
#* @param country Optional - Country alpha‑2 code or country name
#* @get /topic
news_topics <- function(category, country = 'US', res, req) {
  
  a2c <- countryCode[countryCode$Country == str_to_title({ country }),]$Alpha.2.code
  loc <-
    if (str_length(country) > 2) {
      ifelse(is_empty(a2c),'invalid country name', a2c)
    } else if (str_length(country) == 2) {
      str_to_upper(country)
    } else {
      NA
    }
  
  if (is.na(loc)) {
    res$status <- 503
    res$body <- return(err_handler(1001, msg = glue::glue("[{country}] in [country] is too short, please enter a valid country name or country code.")))
    res
  } else if (loc == 'invalid country name') {
    res$status <- 503
    res$body <- return(err_handler(1002, msg = glue::glue("[{country}] is not a valid country name.")))
    res
  } else if (loc %!in% countryCode$Alpha.2.code | is_empty(loc_)) {
    res$status <- 503
    res$body <-
      return(
        err_handler(
          status = 1003,
          msg = glue::glue("[{country}] is not valid country code")
        )
      )
    res
  }
  
  loc_ <- paste0('gl=', loc)
  
  if (category %!in% guide$category_) {
    res$status <- 503
    res$body <-
      return(
        err_handler(
          status = 1004,
          helper = list(guide$category_),
          msg = glue::glue("[{category}] is not valid, please choose from the bellow predefined topics")
        )
      )
    res
  }
  
  url_ <-
    guide %>%
      filter(category_ == category) %>%
      select(- category_) %$%
      paste0(root_, section_, path_, loc_)
  
  tryCatch(
    expr = get.feed(url = url_, cat = category),
    error = function (e) {
      res$status <- 500
      res$body <-
        return(
          err_handler(
            status = 1005,
            msg = glue::glue("Sorry! No news found for [{category}] in {loc}")
          )
        )
      res
    }
  )
}
#todo: status 500 provision