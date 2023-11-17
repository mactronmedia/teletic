+ Media TB

- Media Title TB
- Media Description TB
- Media Pinned Messages
- Media Category TB
- Media Language TB
- Media Type TB


TABLE 
- id
- handle
- body
- category
- language
- type
- created
- crated_at
- published_at
- verified
- scam
- nsfw
- logo_path
- logo_path_thumb
- pinned_message
- pinned_message_date
- description




https://discords.com/

https://us.youtubers.me/the-rubin-report/youtuber-stats
https://coingape.com/best-telegram-crypto-channels-list/



## API:

**API # 1:**
---------------------------------
+ CHANNEL INFO
- title
- photo
- username (handler)
- description
- subscribers

+ GROUP INFO
- title
- photo
- username (handler)
- description
- members

+ BOT INFO
- title
- photo
- username (handler)
- description
- members

+ CHANNEL MESSAGES 
- count of all messages
- id
- date
- views
- forwards
- text

+ GROUP MESSAGES 
- count of all messages
- id
- date
- views
- forwards
- text
- replies

https://rapidapi.com/i-YqErDdkq0t/api/telegram92

**API # 2:**
---------------------------------
+ CHANNEL INFO
- title
- username (handler)
- description
- subscribers
- created_at

+ CHANNEL INFO
- title
- username (handler)
- description
- members
- members online
- created_at
- megagroup
- gigagroup

+ CHABOT INFO
- title
- username (handler)
- description
- bot commands (start, search,..)
- first name
- last name
- premium

+ CHANNEL/GROUP MESSAGES 
 - date
 - photo
 - messages
 - author
 - reactions
 - replies
 - views

https://rapidapi.com/WorldOfApis/api/telegram102


**API # 3:**
---------------------------------

+ CHANNEL INFO
- title
- description
- subscribers
- subscribers online
- photo
- verified

https://rapidapi.com/akrakoro/api/telegram-channel/




import requests

bot_token = "6114412784:AAFtqj_pepVKbG8_lJu3dYDekE7N4H9j_9k"


channel_id = "@treasurebets"  # Replace with the actual channel username or ID
url = f"https://api.telegram.org/bot{bot_token}/getChatMembersCount?chat_id={channel_id}"

response = requests.get(url)
data = response.json()
print(data)


https://docs.pyrogram.org/


https://github.com/ehsanonline/stats_bot

https://github.com/mkdryden/telegram-stats-bot

