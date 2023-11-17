# bots/telegram_bot.py
from django.conf import settings
from telegram import Bot
from telegram.ext import Updater, CommandHandler

class TelegramBot:
    def __init__(self, token):
        self.bot = Bot(token)
        self.updater = Updater(token=token, use_context=True)
        self.dispatcher = self.updater.dispatcher

        # Register command handlers and other event handlers
        # Example: self.dispatcher.add_handler(CommandHandler('start', self.start_command))

    # Define any command/event handlers here

# Instantiate the bot
bot = TelegramBot(settings.TELEGRAM_BOT_TOKEN)
