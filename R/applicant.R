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
  applicants.df <- jsonToDataFrame(results)
  
  return(applicants.df)
}

