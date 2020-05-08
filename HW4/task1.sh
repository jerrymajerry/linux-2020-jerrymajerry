!/bin/bash
for f in $(find ./images -iname "*.*"); do
        i=${f*.}

#将png/svg图片统一转换为jpg格式图片
       echo $i
       if [[ $i == "png"||$i == "svg" ]];then
               convert $f ${f%.*}.jpg
               echo ${f%.*}.jpg
       fi

#对jpeg格式图片进行图片质量压缩(以75%为例)
       if [[ $i == "jpg" ]];then
               convert -quality 75 $f ${f%.*}-conpression.jpg
               echo ${f%.*}-conpression.jpg 
       fi
#对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率
       if [[ $i == "png"||$i == "svg"||$i == "jpg" ]];then
               convert -resize 10000@ $f ${f%.*}-resize.$i #按比例调整图片至面>积最靠近10000
               echo ${f%.*}-resize.$i
       fi

#对图片批量添加自定义文本水印
       convert $f -gravity center -fill black -pointsize 16 -draw "text 5,5 'watermark'" ${f%.*}-watermark.$i #将watermark字样水印添加到图片中央
       echo ${f%.*}-watermark.$i

#批量重命名（统一添加文件名前缀或后缀，不影响原始文件扩展名）
       mv $f ${f%/*}/-rename-${f*/*/} #前缀
       echo ${f%/*}/-rename-${f*/*/}
       mv $f ${f%.*}-rename-.$i #后缀
       echo ${f%.*}-rename-.$i
done