getTask <- function(task_id) {
  task.json <- getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$tasks, "/", task_id, "?apikey=", .ResumatorEnv$data$apikey, sep=""), curl=getCurlHandle())
  contact <- fromJSON(task.json)
  
  ## returns a applicant as a list    
  return(task)
}

getTasks <- function() {
  result <- list()
  stopPaging <- FALSE
  i <- 1
  
  ## paging isn't working since resumator doesn't return next_page, so it's always NULL
  ## Need to page through the results since only 100 are returned at a time, taken from zendeskR
  while(stopPaging==FALSE){
    result[[i]]<-getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$tasks, "/page/", i, "?apikey=", .ResumatorEnv$data$apikey, sep=""), curl=getCurlHandle())
    if(is.null(fromJSON(result[[i]])$next_page)){
      stopPaging = TRUE
    }
    i <- i + 1
  }
  
  ## transform the JSON to a data.frame, taken from zendeskR
  tasks.df <- jsonToDataFrame(result)
  
  return(tasks.df)
}