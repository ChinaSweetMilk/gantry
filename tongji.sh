#--------------------------------------------
# author：李威远
# date:2020/02/26 15:22
# version:2020/02/26 15:22
#--------------------------------------------
#!/bin/bash

MediaType=(ETC CPC);

: > ${MediaType[0]}result
: > ${MediaType[1]}result

SpecialType=(104 105 107 108 109 116 117 120 121 122 123 131 132 138 145 146 147 148 149 150 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 187 188 189 190 191 192 101 102 103 106 118 119 130 135 136 137 185 186 193);

for ((j=0; j<2; j ++))
do
for ((i=0; i<=65; i ++))
do
  if [ ${SpecialType[$i]} == 104 ];then
  echo -e "\033[31m====================${MediaType[j]} 交易失败分析====================\033[0m" >> ${MediaType[j]}result
  echo -e "\033[31m\n=======异常错误=======\033[0m" >> ${MediaType[j]}result
  echo -e "\033[31m\n特情码 数量\033[0m" >> ${MediaType[j]}result
  elif [ ${SpecialType[$i]} = 101 ];then
  echo -e "\033[32m\n=======正常错误=======\033[0m" >> ${MediaType[j]}result
  fi
  
  cat 21_* | grep -E "交易特情:${SpecialType[$i]} \[实时成功率\(小时\)\] ${MediaType[j]}"|wc -l > ${MediaType[j]}${SpecialType[$i]}
  
  sum=0
  while read line
  do
  sum=`expr $sum + $line`
  done  < ${MediaType[j]}${SpecialType[$i]}
  echo "${SpecialType[$i]}    $sum" >> ${MediaType[j]}result
done

cat ${MediaType[j]}result
done

for ((j=0; j<2; j ++))
do
for ((i=0; i<=65; i ++))
do
  rm -rf ${MediaType[j]}${SpecialType[$i]}
done
done

echo -e "\033[32m\n=====================================================\033[0m";
echo "收到[b2]帧次数： `cat 21_* | grep -E "收到\[b2\]帧"|wc -l`";
echo "发送[c6]帧次数： `cat 21_* | grep -E "发送\[c6\]帧"|wc -l`";
echo "交易结果成功次数： `cat 21_* | grep -E "交易结果\:成功"|wc -l`";
echo "交易结果失败次数： `cat 21_* | grep -E "交易结果\:失败"|wc -l`";