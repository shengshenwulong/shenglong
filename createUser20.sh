#! /bin/bash

tempFile=$(mktemp tempFile.XXX)
tempResultFile=$(mktemp user_result_XXX.txt)

#获取a-zA-Z0-9组成的6位字符密码，strings的作用是将前面输入的字符转成可读字符
cat /dev/urandom | strings -n 6 | egrep '^[a-zA-Z0-9]{6}$' | head -20 > $tempFile


for i in $(seq -w 1 20);do
   #创建例如 user01 user02 user10 user11等用户
   useradd user$i
   password=$(head -$i $tempFile |tail -1)
   #依次设置某个用户的密码
   echo $password |password --stdin user$i &>/dev/null
#将账号密码填入文件中进行保存
   echo "user$i: $password" >> $tempResultFile
done

#删除临时密码临时文件
rm -rf $tempFile

echo "用户创建成功，新用户的账号密码在,$tempFille 文件中"
   
