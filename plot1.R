## Downloading the zip file and creating datasets:
fileURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
dataset = "Assignment2_data.zip"
download.file(fileURL, dataset, method="curl")
unzip(dataset)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Preprocessing:
emissions_sum <- aggregate(NEI$Emissions, by = list(NEI$year), FUN = sum)
colnames(emissions_sum) <- c("Year", "Sum")

## Plotting:
png("plot1.png")
barplot(emissions_sum$Sum, emissions_sum$Year, 
        xlab = "Year", ylab = expression('Total PM'[2.5]*" Emissions"),  
        names.arg = emissions_sum$Year, main = expression('PM'[2.5]*" Emissions"))
dev.off()