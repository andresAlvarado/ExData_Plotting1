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

# plotting
with( dataFile, plot( dateTime, Sub_metering_1, ylab ="Energy sub metering", xlab = "", type = "n"))
with( dataFile, points( dateTime, Sub_metering_1, col = "black", pch = "." ))
with( dataFile, points( dateTime, Sub_metering_2, col = "red",   pch = "." ))
with( dataFile, points( dateTime, Sub_metering_3, col = "blue",  pch = "." ))
with( dataFile, lines( dateTime, Sub_metering_1, col = "black" ))
with( dataFile, lines( dateTime, Sub_metering_2, col = "red"  ))
with( dataFile, lines( dateTime, Sub_metering_3, col = "blue" ))
legend( "topright", pch = "-", col = c("black","red","blue"), lwd = c(1,1,1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# save png
dev.copy(png, file = "plot3.png")

# close device
dev.off()
