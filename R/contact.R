getContact <- function(contact_id) {
  contact.json <- getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$contacts, "/", contact_id, "?apikey=", .ResumatorEnv$data$apikey, sep=""), curl=getCurlHandle())
  contact <- fromJSON(contact.json)
  
  ## returns a applicant as a list    
  return(contact)
}

getContacts <- function(from_date = NULL, to_date = NULL) {
  result <- list()
  stopPaging <- FALSE
  i <- 1
  
  ## paging isn't working since resumator doesn't return next_page, so it's always NULL
  ## Need to page through the results since only 100 are returned at a time, taken from zendeskR
  while(stopPaging==FALSE){
    result[[i]]<-getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$contacts, "/page/", i, "?apikey=", .ResumatorEnv$data$apikey, sep=""), curl=getCurlHandle())
    if(is.null(fromJSON(result[[i]])$next_page)){
      stopPaging = TRUE
    }
    i <- i + 1
  }
  
  ## transform the JSON to a data.frame, taken from zendeskR
  contacts.df <- jsonToDataFrame(result)
  
  return(contacts.df)
}