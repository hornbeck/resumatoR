getActivity <- function(activity_id) {
  activity.json <- getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$activities, "/", activity_id, "?apikey=", .ResumatorEnv$data$apikey, sep=""), curl=getCurlHandle())
  activity <- fromJSON(activity.json)
  
  ## returns a applicant as a list    
  return(activity)  
}

getActivities <- function(user_id = NULL, team_id = NULL, object_id = NULL, category = NULL, date = NULL, from_date = NULL, to_date = NULL) {
  
  results <- getResults("activities")
  
  ## transform the JSON to a data.frame, taken from zendeskR
  activities.df <- jsonToDataFrame(results)
  
  
  return(activities.df)
}

