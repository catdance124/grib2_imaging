grib2_dec
===
気象庁が配布する`grib2_dec`を用いてPNG画像を作成するスクリプト
# メモ
- 32bit Linuxでmake & executeするとうまくいく
  - 64bitだとsegmentation fault...
- 32bit LinuxとしてUbuntu 16.04.2 LTSを選択
  - VMware上に仮想環境を作成
  - 共有フォルダ上のファイルをいじる
    - `/mnt/hgfs/`にマウントされる
  - キーボード配列変更-> https://blog.amedama.jp/entry/2017/03/10/210552
- makeしたgrib2_decを実行して.xpmを作成
```bash
$ cd /mnt/hgfs/radar2011/SAMPLE_C
$ make
$ /mnt/hgfs/radar2011/SAMPLE_C/grib2_dec FILENAME -xpm
```
- .xpmがよくわからんので.pngに変換
  - ImageMagickで変換できるらしい ->https://symfoware.blog.fc2.com/blog-entry-133.html
```bash
$ sudo apt install imagemagick
$ convert ~~~.xpm ~~~.png
```
- .bin -> .xpm -> .pngの処理をスクリプト化
```bash
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
```