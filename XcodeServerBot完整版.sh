#!/bin/sh
#蒲公英配置
#归档路径
echo $XCS_PRODUCT
output=`curl -F "file=@$XCS_PRODUCT" \
-F "uKey=d80860e40467f5cff3ecc366ddbcd57e" \
-F "_api_key=4065595ad23259b34c352053506bf544" \
https://www.pgyer.com/apiv1/app/upload`

echo $output

export PYTHONIOENCODING=utf8
appName=`echo  ${output} |python -c "import sys, json; print json.load(sys.stdin)['data']['appName']"|sed 's/[[:space:]]//g'`
appVersion=`echo  ${output}|python -c "import sys, json; print json.load(sys.stdin)['data']['appVersion']"|sed 's/[[:space:]]//g'`
appQRCodeURL=`echo  ${output}|python -c "import sys, json; print json.load(sys.stdin)['data']['appQRCodeURL']" |sed 's/[[:space:]]//g'`
appUpdated=`echo  ${output}|python -c "import sys, json; print json.load(sys.stdin)['data']['appUpdated']" |sed 's/[[:space:]]//g'`
appIdentifier=`echo  ${output}|python -c "import sys, json; print json.load(sys.stdin)['data']['appIdentifier']" |sed 's/[[:space:]]//g'`
appbuildKey=`echo  ${output}|python -c "import sys, json; print json.load(sys.stdin)['data']['appKey']" |sed 's/[[:space:]]//g'`
appbulidUrl="https://www.pgyer.com/apiv2/app/install?_api_key=4065595ad23259b34c352053506bf544&buildKey=$appbuildKey&buildPassword="


# 钉钉 配置
######## 以下为 markdown 写法
curl 'https://oapi.dingtalk.com/robot/send?access_token=a56251fb20ed4854ed5017e785f0bbd6ffef98083a087291c18edd1b68b71a87' \
-H 'Content-Type: application/json' \
-d '
{
"msgtype": "markdown",
"markdown": {
"title":"'$appName'",
"text": "#### '$appName'\tIOS版正式包\n>bundleID:'$appIdentifier'\n\n>更新版本:'$appVersion'\n\n>![screenshot]('$appQRCodeURL')\n> ###### 更新时间:'$appUpdated'\n\n@18924121125@17688151855\n***\n[点击安装]('$appbulidUrl')\n"
},
"at":{
"atMobiles": ["18924121125","17688151855"],
"isAtAll": false
}
}'

######## 以下为 text 写法
curl 'https://oapi.dingtalk.com/robot/send?access_token=a56251fb20ed4854ed5017e785f0bbd6ffef98083a087291c18edd1b68b71a87' \
-H 'Content-Type: application/json' \
-d '
{"msgtype": "text",
"text": {
"content": "更新应用：'$appName'\tIOS版\t内测包，\n更新版本：'$appVersion'，\n更新时间：'$appUpdated'，\nbundleID：'$appIdentifier'，\n二维码地址:\n'$appQRCodeURL'"
},
"at":{
"atMobiles": ["18924121125"],
"isAtAll": false
}
}'

