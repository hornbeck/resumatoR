getApplicant <- function(applicant_id) {
  
}

getApplicants <- function() {
  result <- list()
  stopPaging <- FALSE
  i <- 1
  
  ## paging isn't working since resumator doesn't return next_page, so it's always NULL
  ## Need to page through the results since only 100 are returned at a time, taken from zendeskR
  while(stopPaging==FALSE){
    result[[i]]<-getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$applicants, "/page/", i, "?apikey=", .ResumatorEnv$data$apikey, sep=""), curl=getCurlHandle())
    if(is.null(fromJSON(result[[i]])$next_page)){
      stopPaging = TRUE
    }
    i <- i + 1
  }
  
  ## transform the JSON to a data.frame, taken from zendeskR
  json.data <- lapply(unlist(result), fromJSON)
  pre.result <- lapply(json.data, function(x) do.call("rbind", x))
  final.result <- do.call("rbind", pre.result)
  applicants.df <- data.frame(final.result)
  
  ## transform dates from integers into characters
  new_dates <- lapply(applicants.df$apply_date, function(x) as.character(x))
  applicants.df$apply_date <- new_dates
  applicants.df$apply_date <- unlist(applicants.df$apply_date)

  
  return(applicants.df)
}