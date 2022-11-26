# 确保下列三个包都已安装：install.packages("dplyr/tidyr/lubridate")
library(dplyr)
library(tidyr)
library(lubridate)
iri <- read.table("D:/桌面文件夹/mission/R/data-assignment/data-assignment/iri.csv",header = TRUE,sep=",")

# 第一小问
a <- iri|>
  filter(STATE_CODE == 6,stringr::str_detect(SHRP_ID,"050"))

# 第二小问
iri_sub <- iri|>
  group_by(STATE_CODE,SHRP_ID)|>
  summarise(
    observation = n(),
    iri_min = min(IRI),
    iri_max = max(IRI),
    iri_mean = mean(IRI)
  )|>
  ungroup()

# 第三小问
iri_sub2 <- iri_sub|>
  arrange(desc(iri_mean))

# 第四小问
#选取截面以第一小问为例
a <- iri|>
  filter(STATE_CODE == 6,stringr::str_detect(SHRP_ID,"050"))

mean_time_history <- a|>
  group_by(VISIT_DATE,STATE_CODE)|>
  summarise(
    observation = n(),
    iri_mean2 = mean(IRI)
  )|>
  ungroup()
mean_time_history2 <- mean_time_history|>
  separate(VISIT_DATE,c("VISIT_DATE",NULL),sep=",")|>
  mutate(VISIT_DATE = parse_date_time(VISIT_DATE,"%m/%d/%y"))|>
  arrange(VISIT_DATE)
mean_time_history3 <- mean_time_history2|>
  separate(VISIT_DATE,c("YEAR","MONTH","DAY"),sep="-")
IRI_MEAN <- mean_time_history3|>
  group_by(YEAR)|>
  summarise(
    observation = n(),
    MEAN_IRI = mean(iri_mean2,na.rm = TRUE)
  )|>
  ungroup()
attach(IRI_MEAN)
plot(YEAR,MEAN_IRI)
detach(IRI_MEAN)
