## Downloading the zip file, creating datasets and loading required libraries:
fileURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
dataset = "Assignment2_data.zip"
download.file(fileURL, dataset, method="curl")
unzip(dataset)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(ggplot2)

## Preprocessing
Baltimore_data <- NEI[NEI$fips=="24510",]
Baltimore_emissions_sum <- aggregate(Emissions ~ year + type, Baltimore_data, sum)
colnames(Baltimore_emissions_sum) <- c("Year", "Type", "Sum")

## Plotting:
png("plot3.png")
ggplot(Baltimore_emissions_sum, aes(Year, Sum, color = Type)) +
geom_line() +
xlab("Year") +
ylab(expression('Total PM'[2.5]*" Emissions")) +
ggtitle(expression('PM'[2.5]*" Emissions in Baltimore City, Maryland"))
dev.off()