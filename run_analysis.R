library("reshape2")
library(plyr)

# 1
# Read datasets
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Create datasets
x_data <- rbind(x_train,x_test)
y_data <- rbind(y_train,y_test)
subject_data <- rbind(subject_train,subject_test)

# 2
features <- read.table("UCI HAR Dataset/features.txt")

mean_sd_features <- grep("-(mean|std)\\(\\)", features[,2])

x_data <- x_data[,mean_sd_features]
names(x_data) <- features[mean_sd_features, 2]

# 3
activities <- read.table("UCI HAR Dataset/activity_labels.txt")

y_data[,1] <- activities[y_data[,1],2]
names(y_data) <- "activity"

# 4
names(subject_data) <- "subject"
all_data <- cbind(x_data,y_data,subject_data)

# 5
average_data <- ddply(all_data, .(subject,activity), function(x) colMeans(x[,1:66]))
write.table(average_data, "average_data.txt")
