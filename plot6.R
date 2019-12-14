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
Baltimore_emissions_sum$city = rep("Baltimore", nrow(Baltimore_emissions_sum))
colnames(Baltimore_emissions_sum) <- c("Year", "Sum", "City")

LA_data <- NEI[NEI$fips=="06037" & NEI$type=="ON-ROAD",]
LA_emissions_sum <- aggregate(LA_data$Emissions, by=list(LA_data$year), FUN=sum)
LA_emissions_sum$city = rep("Los Angeles", nrow(LA_emissions_sum))
colnames(LA_emissions_sum) <- c("Year", "Sum", "City")

Merged_data = rbind(Baltimore_emissions_sum, LA_emissions_sum)

## Plotting:
png("plot6.png")
ggplot(Merged_data, aes(as.factor(Year), Sum)) +
  xlab("Year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle(expression('Vehicle PM'[2.5]*" Emissions from 1998 to 2008")) +
  geom_histogram(stat = "identity") +
  facet_grid(. ~ City)
dev.off()