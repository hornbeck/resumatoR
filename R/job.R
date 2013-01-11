getJob <- function(job_id) {
  job.json <- getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$jobs, "/", job_id, "?apikey=", .ResumatorEnv$data$apikey, sep=""), curl=getCurlHandle())
  job <- fromJSON(job.json)
 
  ## returns a job as a list    
  return(job)
}

getJobs <- function() {
  result <- list()
  stopPaging <- FALSE
  i <- 1
  
  ## Need to page through the results since only 100 are returned at a time
  while(stopPaging==FALSE){
    result[[i]]<-getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$jobs, "/page/", i, "?apikey=", .ResumatorEnv$data$apikey, sep=""), curl=getCurlHandle())
    if(is.null(fromJSON(result[[i]])$next_page)){
      stopPaging = TRUE
    }
    i <- i + 1
  }
  
  ## transform the JSON to a data.frame, taken from zendeskR
  jobs.df <- jsonToDataFrame(result)
  
  return(jobs.df)
}


