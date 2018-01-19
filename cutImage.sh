#!/bin/sh

# 参照图路径
filename="/Users/coder/Downloads/庞文良的打包文档（移动话务）/图标/guonrun.png"

# 切图后的目标路径
dirname="/Users/coder/Downloads/庞文良的打包文档（移动话务）/图标/国润"

# 图片名
filename_array=("40.png" "58.png" "60.png" "80.png" "87.png" "120-1x.png" "120-2.png" "180.png" )

# 图片尺寸
size_array=("40" "58" "60" "80" "87" "120" "120" "180" )

mkdir $dirname

for ((i=0;i<${#size_array[@]};++i)); do

mkdir $dirname

m_dir=$dirname/${filename_array[i]}

cp $filename $m_dir

sips -Z ${size_array[i]} $m_dir

done
