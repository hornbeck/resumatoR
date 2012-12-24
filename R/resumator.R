resumator <- function(api) {
  if(!is.null(api)) {
    .ResumatorEnv$data$api <- api
  }
  else {
    warning("API must be provided in order to access your organization's data")
  }
}