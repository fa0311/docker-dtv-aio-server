from pathlib import Path
from ISDBScanner.isdb_scanner.tuner import ISDBTuner
import argparse

def half_for_epg(n: int) -> int:
    """EPG用チューナー数を計算 ((n - 1) // 2)"""
    if n == 0:
        return 0
    else:
        return max(n // 2, 1)

def main():
    parser = argparse.ArgumentParser(description="TVTest BonDriver設定生成スクリプト")
    parser.add_argument(
        "-t", "--template",
        type=Path,
        default=Path("tvtest_template.ini"),
        help="テンプレートINIファイルのパス (既定: tvtest_template.ini)"
    )
    parser.add_argument(
        "-o", "--output",
        type=Path,
        default=Path("tvtest_bondriver.ini"),
        help="出力INIファイルのパス (既定: tvtest_bondriver.ini)"
    )
    args = parser.parse_args()

    # チューナー情報取得
    isdbt = ISDBTuner.getAvailableISDBTTuners() or []
    isdbs = ISDBTuner.getAvailableISDBSTuners() or []
    multi = ISDBTuner.getAvailableMultiTuners() or []

    # 各値を計算
    values = {
        "isdbt_count": len(isdbt),
        "isdbt_epg": half_for_epg(len(isdbt)),
        "isdbs_count": len(isdbs),
        "isdbs_epg": half_for_epg(len(isdbs)),
        "multi_count": len(multi),
        "multi_epg": half_for_epg(len(multi)),
    }

    # テンプレート読み込み
    template_text = args.template.read_text(encoding="utf-8")

    # プレースホルダを置換
    for key, val in values.items():
        template_text = template_text.replace(f"{{{{{key}}}}}", str(val))

    # 出力
    args.output.write_text(template_text, encoding="utf-8")
    print(f"✅ 出力完了: {args.output.resolve()}")

if __name__ == "__main__":
    main()
