#!/bin/bash
#统计访问来源主机TOP 100和分别对应出现的总次数
awk '{a[$1]++}END{for(i in a){ print i,a[i]}}' web_log.tsv | sort -n -r -k 2 | head -100
#统计访问来源主机TOP 100 IP和分别对应出现的总次数
awk '{if($1~/1[0-9][0-9]\.[0-9]/){a[$1]++}}END{for(i in a){print i,a[i]}}' web_log.tsv | sort -n -r -k 2 | head -100
#统计最频繁被访问的URL TOP 100
awk '{a[$5]++}END{for(i in a){ print i,a[i]}}' web_log.tsv | sort -n -r -k 2 | head -100
#统计不同响应状态码的出现次数和对应百分比
awk '{a[$6]++}{num++}END{for(i in a){{if(i!="response") print i,a[i],a[i]/num*100"%"}}}' web_log.tsv
#分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数
echo "403"
awk '{if($6~/403/){a[$5]++}}END{for(i in a){ print i,a[i]}}' web_log.tsv | sort -n -r -k 2 | head -10
echo "404"
awk '{if($6~/404/){a[$5]++}}END{for(i in a){ print i,a[i]}}' web_log.tsv | sort -n -r -k 2 | head -10
#给定URL输出TOP 100访问来源主机(以/elv/SCOUT/scout.gif为例)
awk '{if($5="/elv/SCOUT/scout.gif"){a[$1]++}}END{for(i in a){print i,a[i]}}' web_log.tsv | sort -n -r -k 2 | head -100