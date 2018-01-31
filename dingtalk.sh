curl 'https://oapi.dingtalk.com/robot/send?access_token=a56251fb20ed4854ed5017e785f0bbd6ffef98083a087291c18edd1b68b71a87' \
-H 'Content-Type: application/json' \
-d '
{"msgtype": "text",
"text": {
"content": ">> 产业Live内测版已发布 <<\n注意:如果需要覆盖恢复，请先手动删除目标数据库的数据"
},
"at":{
"atMobiles": ["18924121125"],
"isAtAll": false
}
}'
