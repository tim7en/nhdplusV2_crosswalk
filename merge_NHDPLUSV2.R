require (foreign)

#basin area upstream
setwd("~/NHDPLus/BASIN_CHAR_TOT_CONUS")
basin <- read.csv('BASIN_CHAR_TOT_CONUS.TXT')
mytable <- data.frame (basin$COMID,basin$TOT_BASIN_AREA) #accum draina area
names (mytable) <- c('COMID', 'TOT_BASIN_AREA')

#catchment slope and stream length
setwd("~/NHDPLus/BASIN_CHAR_CAT_CONUS")
slope <- read.csv ('BASIN_CHAR_CAT_CONUS.TXT')
mytable2 <- data.frame (slope$COMID, slope$CAT_STREAM_SLOPE, slope$CAT_STREAM_LENGTH)
names (mytable2) <- c('COMID', 'CAT_STREAM_SLOPE','CAT_STREAM_LENGTH')

#merge area, slope, length
datas <- merge (mytable, mytable2, by = 'COMID')

#initialize my column
datas$Q0001E <- -9999
datas$V0001E <- -9999
datas$r2 <- -9999

#loop over each folder and extract EQ100
setwd("~/NHDPLus/EROM")
myfiles <- list.files ()[-1]

for (region in myfiles){
  setwd (paste0('~/NHDPlus/EROM/',region))
  subregions <- list.dirs()
  subregions <- subregions[grepl ('EROMExtension',subregions,  fixed = T)]
  for (subreg in subregions){
    setwd (paste0(getwd(), subreg))
    list_dbfs <- list.files()
    mydbf <- list_dbfs[grepl ('EROM_MA0001', list_dbfs, fixed = T)]
    flow_db <- read.dbf (mydbf)
    flow_db_sub <- data.frame (flow_db$ComID, flow_db$Q0001E, flow_db$V0001E, flow_db$r2)
    names(flow_db_sub) <- c('COMID','Q0001E', 'V0001E', 'r2')
    myind <- which (datas$COMID %in% flow_db_sub$COMID)
    mymatch <- match (datas$COMID[myind], flow_db_sub$COMID)
    datas$Q0001E[myind] <- flow_db_sub$Q0001E[mymatch]
    datas$V0001E[myind] <- flow_db_sub$V0001E[mymatch]
    datas$r2[myind] <- flow_db_sub$r2[mymatch]
    setwd (paste0('~/NHDPlus/EROM/',region))
  }
}

#combine and rename basin characteristics
datas_bchar <- data.frame (datas$COMID, datas$TOT_BASIN_AREA, datas$CAT_STREAM_SLOPE, datas$CAT_STREAM_LENGTH)
names(datas_bchar) <- names(datas)[1:4]

#combine and rename flow characteristics
datas_flowchar <- data.frame (datas$COMID, datas$Q0001E,datas$V0001E,datas$r2)
names(datas_flowchar) <- names (datas)[c(1,5,6,7)]

setwd("~/NHDPLus")
write.dbf (datas, 'datas_all.dbf')
write.dbf (datas_bchar, 'datas_bchar.dbf')
write.dbf (datas_flowchar, 'datas_flowchar.dbf')
#Total drainage area, square kilometers
#Slope, percent slope (percent rise)
#Stream length, KM
#Q0001E reference flow estimates, cfs
#V0001E reference velocity estimates, f/s
#r2 correlation between reach flow and at gage flow