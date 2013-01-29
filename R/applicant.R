getApplicant <- function(applicant_id) {
  applicant.json <- getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$applicants, "/", applicant_id, "?apikey=", 
                                 .ResumatorEnv$data$apikey, sep=""), curl=getCurlHandle())
  applicant <- fromJSON(applicant.json)
  
  ## returns a applicant as a list    
  return(applicant)
}

getApplicants <- function(name = NULL, city = NULL, job_id = NULL, job_title = NULL, recruiter_id = NULL, apply_date = NULL, from_apply_date = NULL, to_apply_date = NULL) {
  
  results <- getResults()
  
  ## transform the JSON to a data.frame
  json.data <- lapply(unlist(results), fromJSON)
  pre.result <- lapply(json.data, function(x) do.call("rbind", x))
  pre.result[[length(pre.result)]] <- NULL
  applicants.df <- rbind(pre.result[[1]])
  for (y in 2:length(pre.result)) {
    applicants.df <- rbind(applicants.df, pre.result[[y]])
  }
  
  return(applicants.df)
}

getResults <- function() {
  result <- list()
  stopPaging <- FALSE
  i <- 1
  
  # make the call to resumator and return the results
  while(stopPaging==FALSE){
    # the tryCatch block is used to page through until there are no longer any results      
    result[[i]]<- tryCatch({
      getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$applicants, "/page/", i, "?apikey=", 
                   .ResumatorEnv$data$apikey, sep=""), curl=getCurlHandle())
    }, error = function(err) {
      return(NULL)
    })
    # the last result that is returned and breaks the while loop is an empty set of brackets
    if(result[[i]]=="[]"){
      stopPaging = TRUE
    }
    i <- i + 1
  }
  return(result)
}