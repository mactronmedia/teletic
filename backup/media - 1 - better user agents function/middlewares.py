import random
from fake_useragent import UserAgent
from django.utils.deprecation import MiddlewareMixin

class UserAgentMiddleware(MiddlewareMixin):
    def __init__(self, get_response=None):
        self.user_agent = UserAgent()
        super().__init__(get_response)

    def process_request(self, request):
        user_agent = self.user_agent.random
        request.headers["User-Agent"] = user_agent