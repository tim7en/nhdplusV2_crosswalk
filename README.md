# nhdplusV2_crosswalk
Attributing NHDPlusV2 - COMID in R.

Required inputs.
1. https://www.sciencebase.gov/catalog/item/57976a0ce4b021cadec97890
NHDPlusV2 basin attributes, BASIN_CHAR_TOT_CONUS - total accumulation, BASIN_CHAR_CAT_CONUS - catchment specific.
2. EROM attributes from http://www.horizon-systems.com/NHDPlus/NHDPlusV2_data.php 
Functions require: EROM_MA0001.dbf

Structure of folders:
~/NHDPLus/EROM/{region}/{subregion}/EROMExtension/

Required library in R:
1. foreign

Library functionality description
1. IO dbf files

Output examples
https://drive.google.com/drive/folders/1_Xq2Td0jMoAU7m45626xH9ZGCGDyoVeC?usp=sharing
