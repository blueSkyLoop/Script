#蒲公英配置
#归档路径
echo $XCS_PRODUCT
curl -F "file=@$XCS_PRODUCT" \
-F "uKey=d80860e40467f5cff3ecc366ddbcd57e" \
-F "_api_key=659a0cbe0d7bacb444552223de9d6500" \
https://www.pgyer.com/apiv1/app/upload

echo "上传成功"

# 钉钉 配置
curl 'https://oapi.dingtalk.com/robot/send?access_token=a56251fb20ed4854ed5017e785f0bbd6ffef98083a087291c18edd1b68b71a87' \
-H 'Content-Type: application/json' \
-d '
{"msgtype": "text",
"text": {
"content": ">> 美好志愿内测版已发布 <<"
},
"at":{
"atMobiles": ["18924121125"],
"isAtAll": false
}
}'
