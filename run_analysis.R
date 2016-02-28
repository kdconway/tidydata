run_analysis <- function () {
    
    
    #use data.table framework for handling larger datasets. Also I like the syntax.
    
    library (data.table)
    library (dplyr)
    
    # set up activities and levels
    activities <- read.table ("./activity_labels.txt")
    activities <- as.character (activities$V2)
    
    #set up measurement id's
    featurelist <- read.table ("./features.txt")
    features <- as.character (featurelist [,2])
    col.keep <- grep ("[Mm]ean|[Ss]td", features)
    features <- features [col.keep]
    
    
    #read in training data
    
    id.train <- read.table ("./train/subject_train.txt")
    activity.train <- read.table ("./train/y_train.txt")
    obs.train <- read.table ("./train/X_train.txt")
    
    #select only observations that represent a mean or standard deviation
    
    obs.train <- select (obs.train, col.keep)             
    
    #create data.table of training data    
    data.train <- data.table (id = id.train , activity = activity.train , dataset = "train", obs = obs.train)
    setnames (data.train, old = c("id", "activity", "dataset", features))
    
    
    #read in testing data
    
    id.test <- read.table ("./test/subject_test.txt")
    activity.test <- read.table ("./test/y_test.txt")
    obs.test <- read.table ("./test/X_test.txt")
    
    #select only observations that represent a mean or standard deviation
    
    obs.test <- select (obs.test, col.keep)
    
    #create data.table of test data   
    data.test <- data.table (id.test, activity.test, dataset = "test", obs.test)
    setnames (data.test, old = c("id", "activity", "dataset", features))
    
    #combine training and test data
    
    data.all <- rbindlist (list (data.train, data.test))
    
    #recode activity values as factors    
    data.all [, activity := factor (activity)]
    levels (data.all$activity) <- activities

    
    #perform mean of all columns     
    data.means <- data.all [, lapply (.SD, mean), by=.(id, activity), .SDcols=4:89]
    setkey (data.means, activity, id)
    write.table (data.means, file = "./data_tidy.txt", row.names = FALSE)
    
}
