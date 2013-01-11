.ResumatorEnv <- new.env()
.ResumatorEnv$data <- list()

.onLoad <- function(libname, pkgname){
  if(is.null(.ResumatorEnv$data) == FALSE){
    .ResumatorEnv$data <- list(
      apikey = NULL,
      url = "https://api.resumatorapi.com/v1",
      activities = "/activities",
      applicants = "/applicants",
      contacts = "/contacts",
      jobs = "/jobs",
      tasks = "/tasks",
      users = "/users"
    )
  }
}

## transform the JSON to a data.frame, taken from zendeskR
jsonToDataFrame <- function(json) {
  json.data <- lapply(unlist(json), fromJSON)
  pre.result <- lapply(json.data, function(x) do.call("rbind", x))
  final.result <- do.call("rbind", pre.result)
  return(data.frame(final.result))
}

## transform a column of integers to characters.
toChar <- function(column) {
  listChar <- lapply(column, function(x) as.character(x))
  return(unlist(listChar))
}