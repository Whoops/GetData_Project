library(plyr)

getSet <- function(name) {
  dir <- file.path("UCI HAR Dataset", name)
  dataFile <- file.path(dir, paste("X_", name, ".txt", sep=""))
  subjectFile <- file.path(dir, paste("subject_", name, ".txt", sep=""))
  activityFile <- file.path(dir, paste("y_", name, ".txt", sep=""))
  featureFile <- file.path("UCI HAR Dataset", "features.txt")
  
  data <- read.table(dataFile)
  features <- read.table(featureFile)$V2
  cols <- grep("(mean|std)\\(\\)", features)
  data <- data[, cols]
  cnames <- features[cols]
  cnames <- gsub("mean\\(\\)", "Mean", cnames)
  cnames <- gsub("std\\(\\)", "Std", cnames)
  cnames <- gsub("\\-", "", cnames)
  
  names(data) <- cnames
  
  subjects <- readLines(subjectFile)
  activities <- readLines(activityFile)
  data <- cbind(subject=subjects, activityNum=activities, data)
  
  activityNames <- read.table(file.path("UCI HAR Dataset", "activity_labels.txt"))
  names(activityNames) <- c("activityNum", "activity")
  data <- merge(activityNames, data)
  
  data <- data[ ,c("activity", "subject", cnames)]
  data
}

test <- getSet("test")
train <- getSet("train")
full <- rbind(test, train)
full$subject <- as.numeric(full$subject)
fullNames <- names(full)
measureNames <- fullNames[3:length(fullNames)]
tidy <- aggregate(full[, measureNames], by=list(full$activity, full$subject), FUN=mean)
names(tidy) <- fullNames

tidy <- arrange(tidy, subject, activity)
full <- arrange(full, subject, activity)

write.csv(full, "full.txt", row.names=FALSE)
write.csv(tidy, "tidy.txt", row.names=FALSE)