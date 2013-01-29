getContact <- function(contact_id) {
  contact.json <- getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$contacts, "/", contact_id, "?apikey=", .ResumatorEnv$data$apikey, sep=""), curl=getCurlHandle())
  contact <- fromJSON(contact.json)
  
  ## returns a applicant as a list    
  return(contact)
}

getContacts <- function(from_date = NULL, to_date = NULL) {
 
  results <- getResults()
  
  ## transform the JSON to a data.frame, taken from zendeskR
  contacts.df <- jsonToDataFrame(results)
  
  return(contacts.df)
}

getResults <- function() {
  result <- list()
  stopPaging <- FALSE
  i <- 1
  
  # make the call to resumator and return the results
  while(stopPaging==FALSE){
    # the tryCatch block is used to page through until there are no longer any results      
    result[[i]]<- tryCatch({
      getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$contacts, "/page/", i, "?apikey=", 
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