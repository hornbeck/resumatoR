getTask <- function(task_id) {
  task.json <- getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$tasks, "/", task_id, "?apikey=", .ResumatorEnv$data$apikey, sep=""), curl=getCurlHandle())
  task <- fromJSON(task.json)
  
  ## returns a applicant as a list    
  return(task)
}

getTasks <- function(from_date = NULL, to_date = NULL, status = NULL) {
 
  results <- getResults("tasks")
  
  ## transform the JSON to a data.frame, taken from zendeskR
  tasks.df <- jsonToDataFrame(results)
  
  return(tasks.df)
}

