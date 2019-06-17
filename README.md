# nhdplusV2_crosswalk
Attributing NHDPlusV2 - COMID in R.

Required inputs.
1. https://www.sciencebase.gov/catalog/item/57976a0ce4b021cadec97890
NHDPlusV2 basin attributes, BASIN_CHAR_TOT_CONUS - total accumulation, BASIN_CHAR_TOT_CONUS - catchment specific.
2. EROM attributes from http://www.horizon-systems.com/NHDPlus/NHDPlusV2_data.php 
Functions require: EROM_MA0001.dbf

Structure of folders:
~/NHDPLus/EROM/{region}/{subregion}/EROMExtension/

Required library in R:
1. foreign
