#!/bin/bash
set -euo pipefail

FLAG_FILE="./config/.done"

if [ -f "$FLAG_FILE" ]; then
  echo "[ConfigSetup] Already done. Skipping."
  exit 0
fi

# EDCB設定ファイルの準備

mkdir -p ./config/Scanned/EDCB

cp "./config/Scanned/EDCB-Wine/BonDriver_mirakc_S(BonDriver_mirakc).ChSet4.txt" "./config/Scanned/EDCB/BonDriver_LinuxMirakc_S(LinuxMirakc).ChSet4.txt"
cp "./config/Scanned/EDCB-Wine/BonDriver_mirakc_T(BonDriver_mirakc).ChSet4.txt" "./config/Scanned/EDCB/BonDriver_LinuxMirakc_T(LinuxMirakc).ChSet4.txt"
cp "./config/Scanned/EDCB-Wine/BonDriver_mirakc(BonDriver_mirakc).ChSet4.txt" "./config/Scanned/EDCB/BonDriver_LinuxMirakc(LinuxMirakc).ChSet4.txt"
cp "./config/Scanned/EDCB-Wine/ChSet5.txt" "./config/Scanned/EDCB/ChSet5.txt"

mkdir -p ./config/EDCB
mkdir -p ./config/EDCB/bat
cp ./ConfigSetup/EDCB/Common.ini ./config/EDCB/Common.ini
cp ./ConfigSetup/EDCB/EpgDataCap_Bon.ini ./config/EDCB/EpgDataCap_Bon.ini
cp ./ConfigSetup/EDCB/RecEnd.sh ./config/EDCB/RecEnd.sh
python3 main.py -t "./ConfigSetup/EDCB/EpgTimerSrv.template.ini" -o ./config/EDCB/EpgTimerSrv.ini

# KonomiTV設定ファイルの準備
mkdir -p ./config/KonomiTV
cp -r ./ConfigSetup/KonomiTV/config.yaml ./config/KonomiTV/config.yaml

# Amatsukaze設定ファイルの準備

cd ./Amatsukaze/docker
/bin/bash ./setup.sh
cd ../../

mkdir -p ./config/Amatsukaze/avs
mkdir -p ./config/Amatsukaze/bat
mkdir -p ./config/Amatsukaze/profile
mkdir -p ./config/Amatsukaze/drcs
mkdir -p ./config/Amatsukaze/JL
mkdir -p ./config/Amatsukaze/config
mkdir -p ./config/Amatsukaze/logo

cp -r ./Amatsukaze/docker/avs/* ./config/Amatsukaze/avs
cp -r ./Amatsukaze/docker/bat/* ./config/Amatsukaze/bat
cp -r ./Amatsukaze/docker/profile/* ./config/Amatsukaze/profile
cp -r ./Amatsukaze/docker/drcs/* ./config/Amatsukaze/drcs
cp -r ./Amatsukaze/docker/JL/* ./config/Amatsukaze/JL

# 完了
echo "[ConfigSetup] Setup completed."
touch "$FLAG_FILE"