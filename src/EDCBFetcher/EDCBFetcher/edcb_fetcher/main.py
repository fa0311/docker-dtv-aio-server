import os
import time

import requests
from bs4 import BeautifulSoup


class EPGClient:
    def __init__(self, base_url=None, interval=5):
        self.base_url = base_url
        self.session = requests.Session()
        self.interval = interval

    def _get_forms(self):
        url = f"{self.base_url}/legacy/index.html"
        r = self.session.get(url, timeout=2)
        r.raise_for_status()
        soup = BeautifulSoup(r.text, "html.parser")
        return soup.find_all("form")
    
    def __form_action(self, url: str, data: dict):
        r = self.session.post(url, data=data, timeout=2)
        r.raise_for_status()
        soup = BeautifulSoup(r.text, "html.parser")
        return soup.select_one("#result")

    def find_and_submit_form(self, name, value="y"):
        url = f"{self.base_url}/legacy"
        for form in self._get_forms():
            if form.find("input", attrs={"name": name, "value": value}):
                ctok = form.find("input", attrs={"name": "ctok"})["value"]
                action = form.get("action") or ""
                res = self.__form_action(f"{url}/{action}", data={"ctok": ctok, name: value})
                return res.text
        raise SystemExit(f"❌ フォームが見つかりません: {name}")

    
    def check_epg_ready(self):
        try:
            url = f"{self.base_url}/EMWUI/epgweek.html"
            r = self.session.get(url, timeout=2)
            return r.status_code == 200
        except requests.RequestException:
            return False

    def wait_until_epg_ready(self):
        while True:
            if self.check_epg_ready():
                return
            time.sleep(self.interval)


def main():
    client = EPGClient(interval=5, base_url=os.getenv("BASE_URL", "http://127.0.0.1:5510"))
    print("⏳ EPGデータ取得中...")
    skip_epg = os.getenv("SKIP_EPG_RELOAD") == "1" or os.getenv("SKIP_EPG_RELOAD") == "true"
    ready = client.check_epg_ready()

    if not skip_epg or not ready:
        text = client.find_and_submit_form("epgcap")
        if "EPG取得を開始しました" in text:
            print(f"✅ {text}")
        else:
            raise SystemExit(f"❌ {text}")

    if not ready:
        text = client.find_and_submit_form("epgreload")
        if "EPG再読み込みを開始しました" in text:
            print(f"✅ {text}")
        else:
            raise SystemExit(f"❌ {text}")
    client.wait_until_epg_ready()
    print("✅ EPGデータ取得完了")


if __name__ == "__main__":
    main()
