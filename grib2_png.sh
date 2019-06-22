#!/bin/sh

dir_path="/mnt/hgfs/radar2011/DATA/"
bins=`find $dir_path -name *.bin`
exe="/mnt/hgfs/radar2011/SAMPLE_C/grib2_dec"
decoded_path="/mnt/hgfs/radar2011/decoded/"
mkdir -p "${decoded_path}xpm"

for bin in $bins;
do
  $exe $bin -xpm >/dev/null 2>&1
  xpm="${bin%_grib2.*}_0.xpm"    # *_grib2.bin -> *_0.xpm
  basename=`basename $xpm`
  png="${basename%.*}.png"
  convert $xpm $decoded_path$png
  mv $xpm "${decoded_path}xpm/"
done