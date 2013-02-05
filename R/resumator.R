resumator <- function(api) {
  if(!is.null(api)) {
    .ResumatorEnv$data$apikey <- api
  }
  else {
    warning("API must be provided in order to access your organization's data")
  }
}