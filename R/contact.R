getContact <- function(contact_id) {
  contact.json <- getURL(paste(.ResumatorEnv$data$url, .ResumatorEnv$data$contacts, "/", contact_id, "?apikey=", .ResumatorEnv$data$apikey, sep=""), curl=getCurlHandle())
  contact <- fromJSON(contact.json)
  
  ## returns a applicant as a list    
  return(contact)
}

getContacts <- function(from_date = NULL, to_date = NULL) {
 
  results <- getResults("contacts")
  
  ## transform the JSON to a data.frame, taken from zendeskR
  contacts.df <- jsonToDataFrame(results)
  
  return(contacts.df)
}

