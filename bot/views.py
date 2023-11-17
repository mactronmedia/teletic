import requests
from python_telegram_bot import TelegramBot

class TelegramBotManager:
    def __init__(self, api_id, api_hash):
        self.bot = TelegramBot(api_id, api_hash)

    def get_channel_info(self, channel_id):
        channel_info = self.bot.get_chat(channel_id)
        return channel_info

    def get_group_info(self, group_id):
        group_info = self.bot.get_chat(group_id)
        return group_info

    def get_channel_members(self, channel_id, limit=100):
        members = []
        for i in range(0, int(limit / 100) + 1):
            response = self.bot.get_chat_members(channel_id, offset=i * 100)
            members += response['members']
        return members

    def get_group_members(self, group_id, limit=100):
        members = []
        for i in range(0, int(limit / 100) + 1):
            response = self.bot.get_chat_members(group_id, offset=i * 100)
            members += response['members']
        return members

    def get_channel_photos(self, channel_id, limit=100):
        photos = []
        for i in range(0, int(limit / 100) + 1):
            response = self.bot.get_chat_photos(channel_id, offset=i * 100)
            photos += response['photos']
        return photos

    def get_group_photos(self, group_id, limit=100):
        photos = []
        for i in range(0, int(limit / 100) + 1):
            response = self.bot.get_chat_photos(group_id, offset=i * 100)
            photos += response['photos']
        return photos

    def get_channel_videos(self, channel_id, limit=100):
        videos = []
        for i in range(0, int(limit / 100) + 1):
            response = self.bot.get_chat_videos(channel_id, offset=i * 100)
            videos += response['videos']
        return videos

    def get_group_videos(self, group_id, limit=100):
        videos = []
        for i in range(0, int(limit / 100) + 1):
            response = self.bot.get_chat_videos(group_id, offset=i * 100)
            videos += response['videos']
        return videos

    def get_channel_files(self, channel_id, limit=100):
        files = []
        for i in range(0, int(limit / 100) + 1):
            response = self.bot.get_chat_files(channel_id, offset=i * 100)
            files += response['files']
        return files

    def get_group_files(self, group_id, limit=100):
        files = []
        for i in range(0, int(limit / 100) + 1):
            response = self.bot.get_chat_files(group_id, offset=i * 100)
            files += response['files']
        return files

def main():
    api_id = settings.TELEGRAM_API_ID
    api_hash = settings.TELEGRAM_API_HASH

    bot_manager = TelegramBotManager(api_id, api_hash)

    channel_id = '-1001234567890'
    group_id = '-1001234567890'

    channel_info = bot_manager.get_channel_info(channel_id)
    print(channel_info)
