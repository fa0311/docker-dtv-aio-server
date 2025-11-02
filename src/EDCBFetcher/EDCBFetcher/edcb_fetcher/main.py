import time
import requests
from bs4 import BeautifulSoup
import os


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

    def find_and_submit_form(self, name, value="y"):
        for form in self._get_forms():
            if form.find("input", attrs={"name": name, "value": value}):
                ctok = form.find("input", attrs={"name": "ctok"})["value"]
                action = form.get("action") or "index.html"
                action = f"{self.base_url}/legacy/{action}"
                self.session.post(action, data={"ctok": ctok, name: value}, timeout=2).raise_for_status()
                return
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
    client.find_and_submit_form("epgcap")
    print("✅ EGP取得を開始しました。")
    if not client.check_epg_ready():
        client.find_and_submit_form("epgreload")
        print("✅ EGP再読み込みを開始しました。")
    client.wait_until_epg_ready()
    print("✅ EPGデータ取得完了")


if __name__ == "__main__":
    main()
