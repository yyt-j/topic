#!/bin/bash
rm -rf .test
# 清理脚本运行环境
topic=./topic.txt
# 定义题库存在位置
sed -i "s#￥#\\\n#g" $topic
# 初始化题库
Start_Num=1
End_Num=`cat $topic|wc -l`
Array_Length=$[End_Num-Start_Num+1]
typeset RAND                 
for ((i=0;i<$Array_Length;i++));do
        Rnum=$[RANDOM%$Array_Length+Start_Num]    
        Length=${#RAND[@]}    
        if [ $Length -eq 0 ];then    
                RAND[$i]=$Rnum
        else
                for ((j=0;j<$Length;j++));do  
                        if [ $Rnum != ${RAND[$j]} ];then    
                                continue
                        else
                                Rnum=$[RANDOM%$Array_Length+Start_Num]    
                                j=-1    
                        fi  
                done
                RAND[$i]=$Rnum    
        fi  
done
for ((x=0;x<$Array_Length;x++));do
        echo ${RAND[$x]} >> .test
done
# 生成随机数

# 根据随机数出题
for ((i=1;i<=$End_Num;i++));do
	u=`sed -n ""$i"p" .test`
	timu=`sed -n ""$u"p" $topic|cut -d ':' -f1`
	daan=`sed -n ""$u"p" $topic|cut -d ':' -f2`
	echo -e $timu
	# 打印题目至屏幕
	read -p "请输入答案：" s
		if [ $s == $daan ];then
			echo "回答正确！";
			echo;
		else
			echo -e "$timu\n您的回答:$s\t正确答案：$daan" >> err.txt;
			echo "回答错误，已把题目及答案保存至err.txt文件内！";
			echo;
		fi
done
