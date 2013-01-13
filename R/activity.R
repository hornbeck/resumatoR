getActivity <- function(activity_id) {
  activity.json <- getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$activities, "/", activity_id, "?apikey=", .ResumatorEnv$data$apikey, sep=""), curl=getCurlHandle())
  activity <- fromJSON(activity.json)
  
  ## returns a applicant as a list    
  return(activity)  
}

getActivities <- function() {
  result <- list()
  stopPaging <- FALSE
  i <- 1
  
  ## paging isn't working since resumator doesn't return next_page, so it's always NULL
  ## Need to page through the results since only 100 are returned at a time, taken from zendeskR
  while(stopPaging==FALSE){
    result[[i]]<-getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$activities, "/page/", i, "?apikey=", .ResumatorEnv$data$apikey, sep=""), curl=getCurlHandle())
    if(is.null(fromJSON(result[[i]])$next_page)){
      stopPaging = TRUE
    }
    i <- i + 1
  }
  
  ## transform the JSON to a data.frame, taken from zendeskR
  activities.df <- jsonToDataFrame(result)
  
  
  return(activities.df)
}