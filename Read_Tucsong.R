##' @title Clean_Tucson
##' @name Clean_Tucson
##' @description  tree core QAQC
##' @export
##' 
setwd("~/Desktop/tree ring lab")
Clean_Tucson <- function(file) {
  lines <- scan(file, character(), sep = "\n")
  split <- strsplit(lines, " ")
  tags <- NULL
  decade <- NULL
  
  for (i in seq_along(split)) {
    tags[i]   <- split[[i]][1]
    decade[i] <- split[[i]][2]
  }
  utags <- unique(tags)
  newfile <- paste0(file, ".COR.txt")
  if (file.exists(newfile)) {
    file.remove(newfile)
  }
  
  for (tag in utags) {
    rows <- rev(which(tags == tag))
    keep <- 1
    for (i in seq_along(rows)) {
      if (rows[i] - rows[keep] >= -1) {
        keep <- i
      } else {
        break
      }
    }
    keep   <- min(keep, length(rows))
    rows   <- rev(rows[1:keep])
    append <- file.exists(newfile)
    write(lines[rows], newfile, append = append)
  }
  return(newfile)
} # Clean_Tucson

##' @title Read_Tucson
##' @name Read_Tucson
##' @export
##' @description wrapper around read.tucson that loads a whole directory of tree ring files 
##' and calls a 'clean' function that removes redundant records 
##' (WinDendro can sometimes create duplicate records when editing)
folder<-"./Pinus edulis/"
data <- Read_Tucson(folder)
read.csv("./Pinus edulis/RecruitData.csv")

for (file in 1:628){
  data[[file]]$year <- rownames(data[[file]])
  data[[file]]$name <- colnames(data[[file]])[1]
  names(data[[file]]) <- c("growth", "name", "year")  
}

datac <- data[[1]]
for (file in 2:628){
  datac <- rbind(datac, data[[file]])
}
datac

data[[20]]
data[[1]]
data[[2]]
data3<-rbind(data[[1]], data[[2]])

unique(datac$name)

#unique(data3$name)

#head(filenames)


mydata <- read.table("./Pinus edulis/RecruitData.csv", header=TRUE, sep=",")

datamerge1 <- merge(datac, mydata, by = "name", all.x = true)
datamerge2 <- merge(datac, mydata, by = "name", all = false)


mydata
Read_Tucson <- function(folder) {
  
  library(dplR)
  
  filenames <- dir(folder, pattern = "TXT", full.names = TRUE)
  filenames <- c(filenames, dir(folder, pattern = "rwl", full.names = TRUE))
  #filenames <- c(filenames, dir(folder, pattern = "rw", full.names = TRUE))
  corrected <- grep(pattern = "COR.txt", x = filenames)
  if (length(corrected) > 0) {
    filenames <- filenames[-corrected]
  }
  filedata <- list()
  for (file in filenames) {
    #file <- Clean_Tucson(file)
    filedata[[file]] <- read.tucson(file, header = TRUE)
    filedata[[file]]$name <- filenames[file]
  }
  
  return(filedata)
} # Read_Tucson
data[[1]]$year <- rownames(data[[1]])
colnames(data[[1]])
data[[1]]$name <- colnames(data[[1]])[1]
data[[1]]
