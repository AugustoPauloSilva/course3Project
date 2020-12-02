workspace = "./UCI HAR Dataset/complete"

# Writing complete dataset, with train and test data
if (!dir.exists(workspace)){
        current_folder = "./UCI HAR Dataset/train"
        needed_files = list.files(current_folder,full.names = TRUE)
        needed_filesB = list.files(paste0(
                current_folder,"/Inertial Signals"),full.names = TRUE)
        dir.create(workspace)
        dir.create(paste0(workspace,"/Inertial Signals"))
        file.copy(needed_files,workspace)
        file.copy(needed_filesB,paste0(workspace,"/Inertial Signals"))
        current_folder = "./UCI HAR Dataset/test"
        needed_files = list.files(current_folder,full.names = TRUE)
        needed_filesB = list.files(paste0(
                current_folder,"/Inertial Signals"),full.names = TRUE)
        work_files = list.files(workspace,full.names = TRUE)
        work_filesB = list.files(paste0(workspace,"/Inertial Signals"),
                                 full.names = TRUE)
        
        for(index in 2:length(needed_files)){
                to_write = readLines(needed_files[index])
                write(to_write,work_files[index],append = TRUE)
        }
        for(index in 1:length(needed_filesB)){
                to_write = readLines(needed_filesB[index])
                write(to_write,work_filesB[index],append = TRUE)
        }
        needed_files = list.files(workspace,full.names = TRUE,
                                  recursive = TRUE)
        renamed_files = sub("train","complete",needed_files)
        file.rename(needed_files,renamed_files)
        
        rm(to_write,work_files,work_filesB,needed_files,needed_filesB,
           index,current_folder,renamed_files)
}

# Constructing required dataset
using = read.table(paste0(workspace,"/X_complete.txt"))
features = read.table("./UCI HAR Dataset/features.txt")
features = features[,2]
names(using) = features
using = using[,c(1:6,41:46,81:86,121:126,201,202,214,215,227,228,
                 240,241,266:271,345:350,424:429,503,504,516,517,
                 529,530,542,543)]
# write.table(using,paste0(workspace,"/X_extract_complete.txt"),
#            row.names = FALSE,col.names = FALSE)
rm(features)

activity = read.table(paste0(workspace,"/y_complete.txt"))
using[,dim(using)[2]+1] = activity
names(using)[dim(using)[2]] = "activity"
activity = read.table("./UCI HAR Dataset/activity_labels.txt")
activity = activity[,2]
using$activity = factor(using$activity,1:6,activity)
rm(activity)
