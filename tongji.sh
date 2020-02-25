#--------------------------------------------
# author：李威远
# date:2020/02/25 19:00
#--------------------------------------------
#!/bin/bash

MediaType=(ETC CPC);

: > ${MediaType[0]}result
: > ${MediaType[1]}result

SpecialType=(101 102 103 104 105 106 107 108 109 116 117 118 119 120 121 122 123 130 131 132 135 136 137 138 145 146 147 148 149 150 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 185 186 187 188 189 190 191 192 193);

for ((j=0; j<=1; j ++))
do
for ((i=0; i<=65; i ++))
do
  cat 21_* | grep -E "交易特情:${SpecialType[$i]} \[实时成功率\(小时\)\] $MediaType"|wc -l > ${MediaType}${SpecialType[$i]}

  sum=0
  while read line
  do
  sum=`expr $sum + $line`
  done  < ${MediaType[j]}${SpecialType[$i]}
  echo "${SpecialType[$i]}    $sum" >> ${MediaType[j]}result
done
echo -e "\033[32m\n====================${MediaType[j]} 交易失败分析====================\033[0m"
echo -e "\033[32m\n特情码 数量\033[0m"
cat ${MediaType[j]}result
done