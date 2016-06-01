
#Check if required package are installed
if (!require("data.table")) {
    install.packages("data.table")}
if (!require("reshape2")) {
    install.packages("reshape2")}

#load packages
library(data.table)
library(reshape2)

#load labels and feature which are used for labelling the activity and columns
labels <- read.table("./data/UCI_HAR_Dataset/activity_labels.txt")
feature <- read.table("./data/UCI_HAR_Dataset/features.txt")[,2]
names(labels) <- c("actnumber","activity")

#set variable to get only data with Mean and STD
extracts <- feature[grepl("([Mm]ean|[Ss][Tt][Dd])",feature)==TRUE]

#load train datas
subject_train <- read.table("./data/UCI_HAR_Dataset/train/subject_train.txt")
x_train <- read.table("./data/UCI_HAR_Dataset/train/x_train.txt")
y_train <- read.table("./data/UCI_HAR_Dataset/train/y_train.txt")

#rename column names for x_train using feature and subject_train as subject
names(x_train) <- feature
names(subject_train) <- "subject"

#Extract only measures with Mean and STD for train data.
x_train <- x_train[,extracts]

#combine subject_train, y_train, x_train, and then labels
train <- cbind(as.data.table(subject_train), y_train, x_train)
train <- merge(labels, train, by.x="actnumber", by.y = "V1", all=TRUE)


#load test data
subject_test <- read.table("./data/UCI_HAR_Dataset/test/subject_test.txt")
x_test <- read.table("./data/UCI_HAR_Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI_HAR_Dataset/test/Y_test.txt")

#rename column names for x_test and subject_test
names(x_test) <- feature
names(subject_test) <- "subject"

#Extract only measures with Mean and STD.
x_test <- x_test[,extracts]

#combine subject_train, y_train, x_train, and then labels
test <- cbind(as.data.table(subject_test), y_test, x_test)
test <- merge(labels, test, by.x="actnumber", by.y = "V1", all=TRUE)

#combined the data for Test and Train
combined <- rbind(train, test)

# create the tidy data set
melted <- melt(combined, id=c("subject","activity"))
tidy_data <- dcast(melted, subject_id+activity ~ variable, mean)

# write the tidy data set to a file
write.table(tidy_data, "tidy.txt", row.names=FALSE)