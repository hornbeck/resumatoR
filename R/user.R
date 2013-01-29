getUser <- function(user_id) {
  user.json <- getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$users, "/", user_id, "?apikey=", .ResumatorEnv$data$apikey, sep=""), curl=getCurlHandle())
  user <- fromJSON(user.json)
  
  ## returns a applicant as a list    
  return(user)
}

getUsers <- function(name = NULL, email = NULL, type = NULL, team_id = NULL) {
 
  results <- getResults()    
  
  ## transform the JSON to a data.frame, taken from zendeskR
  users.df <- jsonToDataFrame(results)
  
  return(users.df)
}

getResults <- function() {
  result <- list()
  stopPaging <- FALSE
  i <- 1
  
  # make the call to resumator and return the results
  while(stopPaging==FALSE){
    # the tryCatch block is used to page through until there are no longer any results      
    result[[i]]<- tryCatch({
      getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$jobs, "/page/", i, "?apikey=", 
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