.ResumatorEnv <- new.env()
.ResumatorEnv$data <- list()

.onLoad <- function(libname, pkgname){
  if(is.null(.ResumatorEnv$data) == FALSE){
    .ResumatorEnv$data <- list(
      apikey = NULL,
      url = "https://api.resumatorapi.com/v1"      
    )
  }
}

## transform the JSON to a data.frame, taken from zendeskR
jsonToDataFrame <- function(json) {
  json.data <- lapply(unlist(json), fromJSON)
  pre.result <- lapply(json.data, function(x) do.call("rbind", x))
  final.result <- do.call("rbind", pre.result)
  return(data.frame(final.result))
}

## transform a column of integers to characters.
toChar <- function(column) {
  listChar <- lapply(column, function(x) as.character(x))
  return(unlist(listChar))
}

getResults <- function(model) {
  result <- list()
  stopPaging <- FALSE
  i <- 1
  
  # make the call to resumator and return the results
  while(stopPaging==FALSE){
    # the tryCatch block is used to page through until there are no longer any results      
    result[[i]]<- tryCatch({
      getURL(paste(.ResumatorEnv$data$url, "/", model, "/page/", i, "?apikey=", 
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