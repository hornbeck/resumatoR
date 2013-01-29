getUser <- function(user_id) {
  user.json <- getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$users, "/", user_id, "?apikey=", .ResumatorEnv$data$apikey, sep=""), curl=getCurlHandle())
  user <- fromJSON(user.json)
  
  ## returns a applicant as a list    
  return(user)
}

getUsers <- function(name = NULL, email = NULL, type = NULL, team_id = NULL) {
 
  results <- getResults("users")    
  
  ## transform the JSON to a data.frame, taken from zendeskR
  users.df <- jsonToDataFrame(results)
  
  return(users.df)
}
