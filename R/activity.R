getActivity <- function(activity_id) {
  activity.json <- getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$activities, "/", activity_id, "?apikey=", .ResumatorEnv$data$apikey, sep=""), curl=getCurlHandle())
  activity <- fromJSON(activity.json)
  
  ## returns a applicant as a list    
  return(activity)  
}

getActivities <- function(user_id = NULL, team_id = NULL, object_id = NULL, category = NULL, date = NULL, from_date = NULL, to_date = NULL) {
  
  results <- getResults()
  
  ## transform the JSON to a data.frame, taken from zendeskR
  activities.df <- jsonToDataFrame(results)
  
  
  return(activities.df)
}

getResults <- function() {
  result <- list()
  stopPaging <- FALSE
  i <- 1
  
  # make the call to resumator and return the results
  while(stopPaging==FALSE){
    # the tryCatch block is used to page through until there are no longer any results      
    result[[i]]<- tryCatch({
      getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$activities, "/page/", i, "?apikey=", 
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