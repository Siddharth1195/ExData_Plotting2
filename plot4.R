## Downloading the zip file, creating datasets and loading required libraries:
fileURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
dataset = "Assignment2_data.zip"
download.file(fileURL, dataset, method="curl")
unzip(dataset)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Preprocessing:
SCC_coal = SCC[(grepl(x = SCC$Short.Name, pattern = "Coal", ignore.case=TRUE)),]
NEI_coal = merge(NEI, SCC_coal, by = "SCC")

# Aggregate emissions
emissions_sum <- aggregate(NEI_coal$Emissions, by=list(NEI_coal$year), FUN=sum)
colnames(emissions_sum) <- c("Year","Sum")
emissions_sum$group <- rep("Coal", nrow(emissions_sum))

# Make the plot
png("plot4.png")
ggplot(emissions_sum, aes(as.factor(Year), Sum, group = group, label = round(Sum))) +
  geom_line(color="red") +
  geom_point(size = 1, color="red", show.legend = TRUE) +
  xlab("Year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle(expression('Coal-sourced PM'[2.5]*" emissions from 1998 to 2008")) +
  geom_text(check_overlap = TRUE, vjust = 1.2, hjust = 1.2)
dev.off()
