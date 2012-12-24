.ResumatorEnv <- new.env()
.ResumatorEnv$data <- list()

.onLoad <- function(libname, pkgname){
  if(is.null(.ResumatorEnv$data) == FALSE){
    .ResumatorEnv$data <- list(
      apikey <- NULL,
      url <- "www.resumatorapi.com/v1",
      activities <- "/activities",
      applicants <- "/applicants",
      contacts <- "/contacts",
      jobs <- "/jobs",
      tasks <- "/tasks",
      users <- "/users"
    )
  }
}