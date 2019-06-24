#!/bin/sh

cd `dirname $0`

data_path="./DATA/"
bins=`find $dir_path -name *.bin`
exe="./SAMPLE_C/grib2_dec"
decoded_path="./decoded/"
mkdir -p "${decoded_path}xpm/"

for bin in $bins;
do
  $exe $bin -xpm >/dev/null 2>&1  # decode grib2->xpm
  xpm="${bin%_grib2.*}_0.xpm"  # filename *_grib2.bin->*_0.xpm
  basename=`basename $xpm`
  png="${decoded_path}${basename%.*}.png"
  convert $xpm $png  # convert xpm->png
  mv $xpm "${decoded_path}xpm/"  # move xpm
  echo "out: $png"
done
