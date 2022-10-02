err <-
  data.frame(
    status    = c(503, 503, 503, 503),
    error_msg = c(
      "[{var}] in [country] is too short, please enter a valid country name or country code.",
      "[{var}] is not a valid country code.",
      "[{var}] is not valid country name",
      "[{var}] is not valid, please choose from the bellow predefined topics"
    )
  )

err_handler <-
  function(status, helper = NULL, var, res, req) {
    
    msg <- err[err$status == { status },]$error_msg[1]
    
    if (! is.null(helper)) {
      return(
        list(
          error   = status,
          message = glue::glue(msg),
          guide   = helper
        )
      )
    } else {
      return(
        list(
          error   = status,
          message = glue::glue(msg)
        )
      )
    }
  }