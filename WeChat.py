#/usr/bin/env python
import logging
import os
import time

from wxpy import *

bot = Bot()
# 给机器人自己发送消息
bot.self.send('Hello World!')
# 给文件传输助手发送消息
bot.file_helper.send('Hello World!')

# 查找昵称为'乙醚。'的好友
#my_friend = bot.friends().search(u'小肥')[0]
#my_friend.send('Hello, WeChat!')

tuling = Tuling(api_key='d5fb2e9cd7734f72a6f271d4af7a32eb')#key

cache_list = []


# 定位公司群
company_group = ensure_one(bot.groups().search('iOS入门到跑路'))

# 定位老板
boss = ensure_one(company_group.search('Lo'))

# 将老板的消息转发到文件传输助手
@bot.register(company_group)
def forward_boss_message(msg):
    if (msg.member == boss) and (msg.text == "开启机器人"):
        msg.forward(bot.file_helper, prefix='老板发言')
        cache_list.append(msg_sender)
        msg_sender.send('开启~~~')
        return None
    elif msg.text == "关闭机器人": #退出机器人
        if msg_sender in cache_list :
            cache_list.remove(msg_sender)
            msg_sender.send('关闭成功~~~')
            return None

    if msg_sender in cache_list:
        tuling.do_reply(msg)


@bot.register()
def print_others(msg):

    global cache_list
    msg_sender = msg.sender
    #根据命令启动机器人
    if (msg.text == "哈哈") and (not msg_sender in cache_list):
        cache_list.append(msg_sender)

        msg_sender.send('开启机器人')
        return None
    elif msg.text == "哈哈哈": #退出机器人
        if msg_sender in cache_list :
            cache_list.remove(msg_sender)
            msg_sender.send('关闭机器人')
            return None

    if msg_sender in cache_list:
        tuling.do_reply(msg)
embed()