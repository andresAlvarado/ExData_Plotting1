# Requirements to run the script:
#	Have sqldf library installed. install.packages("sqldf")
#	The household_power_consumption.txt should be in the R working directory.
#	

# needed Libraries.
library(sqldf)

# data file path
fileName = "household_power_consumption.txt"

# sqldf will be used to read file, hence specify sql query
sqlStatement = "Select * 
 		From   file 
		Where  1 = 1
		And    date In ('1/2/2007','2/2/2007')"

# read file
dataFile <- read.csv.sql( file   = fileName
			, sql    = sqlStatement
			, header = TRUE
			, sep 	 = ";"
			)
# close file connection
closeAllConnections()

# convert ?'s to NA's
dataFile[dataFile == "?"] <- NA

# create histogram
hist( x    = dataFile$Global_active_power
    , col  = "red"
    , main = "Global Active Power"
    , xlab = "Global Active Power (kilowatts)" 
    )

# save png
dev.copy(png, file = "plot1.png")

# close device
dev.off()
