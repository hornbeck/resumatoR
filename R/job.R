getJob <- function(job_id) {
  job.json <- getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$jobs, "/", job_id, "?apikey=", .ResumatorEnv$data$apikey, sep=""), curl=getCurlHandle())
  job <- fromJSON(job.json)
 
  ## returns a job as a list    
  return(job)
}

getJobs <- function(title = NULL, recruiter = NULL, board_code = NULL, department = NULL, hiring_lead = NULL, team_id = NULL, state = NULL, city = NULL) {
 
  ## Need to page through the results since only 100 are returned at a time
  results <- getResults()
  
  ## transform the JSON to a data.frame, taken from zendeskR
  jobs.df <- jsonToDataFrame(results)
  
  return(jobs.df)
}
getResults <- function() {
  result <- list()
  stopPaging <- FALSE
  i <- 1
  
  # make the call to resumator and return the results
  while(stopPaging==FALSE){
    # the tryCatch block is used to page through until there are no longer any results      
    result[[i]]<- tryCatch({
      getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$jobs, "/page/", i, "?apikey=", 
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

