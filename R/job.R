getJob <- function(job_id) {
  job.json <- getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$jobs, "/", job_id, "?apikey=", .ResumatorEnv$data$apikey, sep=""), curl=getCurlHandle())
  job <- fromJSON(job.json)
 
  ## returns a job as a list    
  return(job)
}

getJobs <- function(title = NULL, recruiter = NULL, board_code = NULL, department = NULL, hiring_lead = NULL, team_id = NULL, state = NULL, city = NULL) {
 
  ## Need to page through the results since only 100 are returned at a time
  results <- getResults("jobs")
  
  ## transform the JSON to a data.frame, taken from zendeskR
  jobs.df <- jsonToDataFrame(results)
  
  return(jobs.df)
}
