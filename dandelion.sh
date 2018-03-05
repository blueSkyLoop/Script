#
# Copyright 2018 ikrulala. All rights reserved.
#
# V1.0.0
#
# 2018.02.02
#
#
#
###########################################################
#    脚本集成到Xcode工程的Bot Post-integration Scripts
###########################################################
#
# --- Copy the SCRIPT to the Run Script of Post-integration Scripts in the Xcode bot ---
#
# #
# # 蒲公英 API Key 配置
PGY_API_KEY="4065595ad23259b34c352053506bf544"
#
# # 钉钉机器人 webhook 配置
#
# # 内部群组的机器人 webhook
DINGTALK_WEBHOOK_GROUP_OWN="https://oapi.dingtalk.com/robot/send?access_token=a56251fb20ed4854ed5017e785f0bbd6ffef98083a087291c18edd1b68b71a87"
#
# # 测试群组的机器人 webhook
DINGTALK_WEBHOOK_GROUP_TEST="https://oapi.dingtalk.com/robot/send?access_token=9c5897a8bd11bfd3523577da505df7c364da1c448091b5bd8a2758553a1e2b15"
# #
# --- END OF SCRIPT ---
#
#
#
#
# # 脚本默认ipa路径
echo $XCS_PRODUCT
#
# # 脚本上传ipa 托管方为蒲公英
#
# # 本文使用API 2.0,详情查看:https://www.pgyer.com/doc/view/api#uploadApp
#
PGY_UPLOAD_RESULT=`curl -F "file=@$XCS_PRODUCT" \
-F "_api_key=$PGY_API_KEY" \
https://www.pgyer.com/apiv2/app/upload`
#
# # 打印当前ipa存放的路径
echo $PGY_UPLOAD_RESULT
#
# # python v2.7 解析json
export PYTHONIOENCODING=utf8
PGY_APP_NAME=`echo  ${PGY_UPLOAD_RESULT} |python -c "import sys, json; print json.load(sys.stdin)['data']['buildName']"|sed 's/[[:space:]]//g'`
PGY_APP_VERSION=`echo  ${PGY_UPLOAD_RESULT}|python -c "import sys, json; print json.load(sys.stdin)['data']['buildVersion']"|sed 's/[[:space:]]//g'`
PGY_APP_QRCODEURL=`echo  ${PGY_UPLOAD_RESULT}|python -c "import sys, json; print json.load(sys.stdin)['data']['buildQRCodeURL']" |sed 's/[[:space:]]//g'`
PGY_APP_UPDATED=`echo  ${PGY_UPLOAD_RESULT}|python -c "import sys, json; print json.load(sys.stdin)['data']['buildUpdated']" |sed 's/[[:space:]]//g'`
PGY_APP_IDENTIFIER=`echo  ${PGY_UPLOAD_RESULT}|python -c "import sys, json; print json.load(sys.stdin)['data']['buildIdentifier']" |sed 's/[[:space:]]//g'`
PGY_APP_KEY=`echo  ${PGY_UPLOAD_RESULT}|python -c "import sys, json; print json.load(sys.stdin)['data']['buildKey']" |sed 's/[[:space:]]//g'`
PGY_APP_BUILD_VERSION=`echo  ${PGY_UPLOAD_RESULT}|python -c "import sys, json; print json.load(sys.stdin)['data']['buildBuildVersion']" |sed 's/[[:space:]]//g'`
PGY_APP_DOWNLOAD_URL="https://www.pgyer.com/apiv2/app/install?_api_key=4065595ad23259b34c352053506bf544&buildKey=$PGY_APP_KEY&buildPassword="
#
# # 钉钉 机器人webhook配置,详情参看:https://open-doc.dingtalk.com/docs/doc.htm?spm=a219a.7629140.0.0.jjxKoj&treeId=257&articleId=105735&docType=1
#
# # 执行内部群组的机器人 webhook 请求
curl $DINGTALK_WEBHOOK_GROUP_OWN \
-H 'Content-Type: application/json' \
-d '
{
"msgtype": "markdown",
"markdown": {
"title":"'$PGY_APP_NAME'",
"text": "#### '$PGY_APP_NAME'\tIOS\t测试包\n>bundleID:'$PGY_APP_IDENTIFIER'\n\n>更新版本:'$PGY_APP_VERSION'\n\n>构建版本:'$PGY_APP_BUILD_VERSION'\n\n>![screenshot]('$PGY_APP_QRCODEURL')\n> ###### 更新时间:'$PGY_APP_UPDATED'\n\n@18924121125@17688151855\n***\n[点击安装]('$PGY_APP_DOWNLOAD_URL')\n"
},
"at":{
"atMobiles": ["18924121125","17688151855"],
"isAtAll": false
}
}'
#
# # 执行测试群组的机器人 webhook 请求
curl $DINGTALK_WEBHOOK_GROUP_TEST \
-H 'Content-Type: application/json' \
-d '
{
"msgtype": "markdown",
"markdown": {
"title":"'$PGY_APP_NAME'",
"text": "#### '$PGY_APP_NAME'\tIOS版\t测试包\n>bundleID:'$PGY_APP_IDENTIFIER'\n\n>更新版本:'$PGY_APP_VERSION'\n\n>构建版本:'$PGY_APP_BUILD_VERSION'\n\n>![screenshot]('$PGY_APP_QRCODEURL')\n> ###### 更新时间:'$PGY_APP_UPDATED'\n\n\n***\n[点击安装]('$PGY_APP_DOWNLOAD_URL')\n"
},
"at":{
"isAtAll": true
}
}'
