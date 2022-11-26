ACCIDENT <- read.table("D:/桌面文件夹/mission/R/data-assignment/data-assignment/ACCIDENT.csv",header = TRUE,sep = ",")
PERSON <- read.table("D:/桌面文件夹/mission/R/data-assignment/data-assignment/PERSON.csv",header = TRUE,sep = ",")

# 第一小问
acc_per <- 
  inner_join(
    x=ACCIDENT,
    y=PERSON,
  )

# 第二小问
INJ_SEV <- PERSON|>
  group_by(INJ_SEV)|>
  summarise(observation = n())|>
  ungroup()
INJ_SEV

# 第三小问
# 安装mice包：install.packages("mice")
library(mice)
acc_veh_left <- left_join(
  x=ACCIDENT,
  y=PERSON,
  by=c("CASENUM","PSU")
)|>
  distinct()
md.pattern(acc_veh_left)


