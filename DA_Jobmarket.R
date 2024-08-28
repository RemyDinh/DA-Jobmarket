#DA - Job market analysis 

# Part A: Prepare environment

## Load packages & set working directory
library(dplyr)
library(tidygeocoder)
setwd("INSERT YOUR PATH")

## Load data 
data <- read.csv("dataset_indeed.csv")
labeling <- read.csv("ChatGPT Labeling Experience.csv", header = FALSE)
colnames(labeling) <- "experience"

# Part B: Cleaning

## 1. Drop irrelevant columns
data.use <- subset(data, select = c("company", "description", "jobType.0", "location", "positionName", "rating", "reviewsCount", "salary"))

## 2. Standardize Location

### Get rid of zip codes and delete white spaces
data.use$location <- trimws(gsub("[0-9]", "", data.use$location))

### Get coordinates
coords <- cbind(data.use$company,data.use$location)
colnames(coords) <- c("Company", "City")
coords <- as.data.frame(coords)
coords <- coords %>%
  mutate(location = City) %>%
  geocode(location, method = 'osm', lat = latitude, long = longitude)

## 3. Standardize Job Types
standardized_job_types <- data.use$jobType.0 %>%
  recode(
    "Fulltime" = "Full-time",
    "Full-time" = "Full-time",
    "Parttime" = "Part-time",
    "Vaste baan" = "Unknown",
    "Uitzicht op vast" = "Unknown",
    "Bepaalde tijd" = "Unknown",
    "Stage" = "Other",
    "Internship" = "Other",
    "Net afgestudeerd" = "Unknown",
    "Freelance / zzp" = "Other",
    "Studentenbaan" = "Other",
    .default = "Unknown"  # Assign a default label for not handled cases
  )
data.use$jobType.0 <- standardized_job_types

## 4. Standardize Salary 

### Make formatting consistent & Split text and number
data.use$text_salary <-gsub("[0-9]", "", data.use$salary)
data.use$text_salary <- trimws(gsub("[-€.,]", "", data.use$text_salary))
data.use$numeric_salary <- gsub("[A-Za-z]", "", data.use$salary)
data.use$numeric_salary <- trimws(gsub("[€.]", "", data.use$numeric_salary))


### Clean further and make sure if salary range is included, the average is taken
split_values <- strsplit(data.use$numeric_salary, "-")

for (i in seq_along(split_values)) {
  if (length(split_values[[i]]) == 0) {
    split_values[[i]] <- NA  # Replace character(0) with NA
  } else {
    # Replace commas with periods
    split_values[[i]] <- gsub(",", ".", split_values[[i]])
    
    # Remove leading/trailing spaces and convert to numeric
    split_values[[i]] <- as.numeric(trimws(split_values[[i]]))
    
    # If there are two values, replace with their average
    if (length(split_values[[i]]) == 2) {
      split_values[[i]] <- mean(split_values[[i]], na.rm = TRUE)
    }
  }
}

### Round values to 2 decimals
data.use$numeric_salary <- round(unlist(split_values),2)

### Make sure annual salaries are included
for (i in seq_len(nrow(data.use))) {
  if (grepl("per maand", data.use$text_salary[i])) {
    data.use$numeric_salary[i] <- data.use$numeric_salary[i] * 12 * 1.08 # Montly to annual 
  } else if (grepl("per week", data.use$text_salary[i])) {
    data.use$numeric_salary[i] <- data.use$numeric_salary[i] * 52 # Weekly to annual
  } else if (grepl("per dag", data.use$text_salary[i])) {
    data.use$numeric_salary[i] <- data.use$numeric_salary[i] * 231 # Daily to annual
  } else if (grepl("per uur", data.use$text_salary[i])) {
    data.use$numeric_salary[i] <- data.use$numeric_salary[i] * 2048 # Hourly to annual
  }
}

## 5. Identify mentioned skills / Education levels
### Create skills columns
skills <- c("Python", "SQL", "Azure", " R ", "AWS", "Spark","Power BI", "Tableau", "Java", "Excel", "Git", "HBO", "WO", "Master", "Bachelor") # Top skills

# Create empty new rows for each skill
for (skill in skills) {
  data.use[[skill]] <- 0
}

# Identify skills
for (i in seq_len(nrow(data.use))) {
  for (skill in skills) {
    if (grepl(skill, data.use$description[i], ignore.case = TRUE)) {
      data.use[[skill]][i] <- 1
    }
  }
}

## 6. Identify mentioning of education lvl.
### Identification was already done in step 5

### Identify lowest degree necessary (Bachelor/Master)
data.use$degree1 <- with(data.use, 
                         ifelse(Bachelor == 1 & Master == 1, "Both",
                                ifelse(Bachelor == 1 & Master == 0, "Bachelor",
                                       ifelse(Bachelor == 0 & Master == 1, "Master", "None"))))

### Identify lowest degree necessary (HBO/WO)
data.use$degree2 <- with(data.use, 
                         ifelse(HBO == 1 & WO == 1, "HBO",
                                ifelse(HBO == 1 & WO == 0, "HBO",
                                       ifelse(HBO == 0 & WO == 1, "WO", "None"))))

## 7. Experience labels
### Add ChatGPT labeled data
data.use <- cbind(data.use, labeling)

# Part 3: Create final dataset
data.final <- data.use %>% select(-description)

# write.csv(data.final, "final_dataset.csv", row.names = FALSE)


