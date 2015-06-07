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

# create time class
dataFile$Date <- as.Date( dataFile$Date
			, format = "%d/%m/%Y"
			)

dataFile$dateTime <- paste( dataFile$Date 
		   	  , dataFile$Time
 			  , sep = " "
		          ) 

dataFile$dateTime <- as.POSIXlt( dataFile$dateTime )

# plot
plot( x    = dataFile$dateTime 
    , y    = dataFile$Global_active_power
    , ylab = "Global Active Power (kilowatts)"
    , pch  = "."
    , xlab = ""
    )

lines( x    = dataFile$dateTime
     , y    = dataFile$Global_active_power
     )


# save png
dev.copy(png, file = "plot2.png")

# close device
dev.off()
