library(rrecsys)
library(dplyr)
data = read.csv("C:/Users/sriwi/OneDrive/Documents/MBA/Smith School of Business/Semester
4/BUMK 747 CRM Analytics/Final Project/Agg2010.csv")
df = data %>% select(panid, week, minute, L2)
## ASSOCIATION RULES
library(arules)
library(arulesViz)
if(sessionInfo()['basePkgs']=="dplyr" | sessionInfo()['otherPkgs']=="dplyr"){
  detach(package:dplyr, unload=TRUE)
}
library(plyr)
Transact_item <- ddply(df,c("panid", "week", "minute"), function(df)paste(df$L2, collapse = ","))
# Save processed transactions
write.csv(Transact_item,"C:/Users/sriwi/OneDrive/Documents/MBA/Smith School of
Business/Semester 4/BUMK 747 CRM Analytics/Final Project/Transact_item.csv", quote =
            FALSE, row.names = TRUE)
# Read processed transactions
Transact_tx = read.transactions(file="C:/Users/sriwi/OneDrive/Documents/MBA/Smith School of
Business/Semester 4/BUMK 747 CRM Analytics/Final Project/Transact_item.csv",
                                rm.duplicates= TRUE, format="basket",sep=",",cols=1);
# Strip quotes if they exist
Transact_tx@itemInfo$labels <- gsub("\"","",Transact_tx@itemInfo$labels)
# Create rules - Note these two parameters sup = support and conf = confidence can be
#adjusted to get more or fewer rules
Transact_rules <- apriori(Transact_tx,parameter = list(sup = 0.001, conf = 0.5,target="rules"));
saverules<-as(Transact_rules,"data.frame")
