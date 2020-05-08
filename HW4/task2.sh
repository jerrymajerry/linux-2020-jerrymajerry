#!/bin/bash
a=20
b=30
#统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比
awk '{num++; if ($6<'"$a"'){num1++}}END {printf"20岁以下球员数量：%d\n所占百分比
： %-2.2f%%\n",num1,num1/num*100}' worldcupplayerinfo.tsv
awk '{num++; if ($6>='"$a"' && $6<='"$b"' ) {num2++}}END {printf"20-30岁球员数量
：%d\n所占百分比： %-2.2f%%\n",num2,num2/num*100}' worldcupplayerinfo.tsv
awk '{num++; if ($6>'"$b"') {num3++}}END {printf"30岁以上球员数量：%d\n所占百分>比： %-2.2f%%\n",num3,num3/num*100}' worldcupplayerinfo.tsv
#统计不同场上位置的球员数量、百分比
awk -F'\t' '{num++;a[$5]++}END{for(i in a){if(i!="Position"){printf"位置:%s 数量
:%d 所占百分比:%-2.2f%%\n", i,a[i],a[i]/num*100}}}' worldcupplayerinfo.tsv
#名字最长的球员是谁？名字最短的球员是?
longest=$(awk -F'\t' '{if (length($9)>maxlength) maxlength=length($9) }END{print maxlength}' worldcupplayerinfo.tsv)
shortest=$(awk -F'\t' 'BEGIN{minlength=100}{if (length($9)<minlength) minlength=length($9) }END{print minlength}' worldcupplayerinfo.tsv)
echo "名字最长的球员是:"
longestname=$(awk -F '\t' '{if (length($9)=='$longest'){print $9 "&&"}}' worldcupplayerinfo.tsv)
echo $longestname
echo "名字最短的球员是:"
shortestname=$(awk -F '\t' '{if (length($9)=='$shortest'){print $9}}' worldcupplayerinfo.tsv)
echo $shortestname
#年龄最大的球员是谁？年龄最小的球员是谁？
echo "年龄最大球员和他的年龄:"
oldest=$(awk -F'\t' '{if ($6>max&&$6!="Age") max=$6 }END{print max}' worldcupplayerinfo.tsv)
oldestname=$(awk -F '\t' '{if ($6=='$oldest'){print $9}}' worldcupplayerinfo.tsv)
echo $oldestname
echo $oldest
echo "年龄最小球员和他的年龄:"
youngest=$(awk -F'\t' 'BEGIN{min=100}{if ($6<min&&$6!="Age") min=$6 }END{print min}' worldcupplayerinfo.tsv)
youngestname=$(awk -F '\t' '{if ($6=='$youngest'){print $9 "&&"}}' worldcupplayerinfo.tsv)
echo $youngestname
echo $youngest