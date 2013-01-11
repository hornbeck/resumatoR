getApplicant <- function(applicant_id) {
  applicant.json <- getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$applicants, "/", applicant_id, "?apikey=", .ResumatorEnv$data$apikey, sep=""), curl=getCurlHandle())
  applicant <- fromJSON(applicant.json)
  
  ## returns a applicant as a list    
  return(applicant)
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
  applicants.df <- jsonToDataFrame(result)
  
  ## transform dates from integers into characters
  applicants.df$apply_date <- toChar(applicants.df$apply_date)

  
  return(applicants.df)
}

