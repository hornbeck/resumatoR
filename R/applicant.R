getApplicant <- function(applicant_id) {
  applicant.json <- getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$applicants, "/", applicant_id, "?apikey=", 
                                 .ResumatorEnv$data$apikey, sep=""), curl=getCurlHandle())
  applicant <- fromJSON(applicant.json)
  
  ## returns a applicant as a list    
  return(applicant)
}

getApplicants <- function(name = NULL, city = NULL, job_id = NULL, job_title = NULL, recruiter_id = NULL, apply_date = NULL, from_apply_date = NULL, to_apply_date = NULL) {
  
  results <- getResults("applicants")
  
  ## transform the JSON to a data.frame
  json.data <- lapply(unlist(results), function(x) fromJSON(x, nullValue=NA))
  pre.result <- lapply(json.data, function(x) do.call("rbind", x))
  final.result <- do.call("rbind", pre.result)
  applicants.df <- as.data.frame(final.result)
  
  return(applicants.df)
}

