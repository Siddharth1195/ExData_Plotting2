## Downloading the zip file, creating datasets and loading required libraries:
fileURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
dataset = "Assignment2_data.zip"
download.file(fileURL, dataset, method="curl")
unzip(dataset)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Preprocessing:
Baltimore_data <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",]
Baltimore_emissions_sum <- aggregate(Baltimore_data$Emissions, by=list(Baltimore_data$year), FUN=sum)
colnames(Baltimore_emissions_sum) <- c("Year", "Sum")

## Plotting:
png("plot5.png")
ggplot(Baltimore_emissions_sum, 
       aes(as.factor(Year), Sum, label = round(Sum))) +
  geom_histogram(stat = "identity") +
  xlab("Year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle(expression('Vehicle PM'[2.5]*" Emissions in Baltimore City, Maryland")) +
  geom_text(vjust = 0) 
dev.off()