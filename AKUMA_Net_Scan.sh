#!/bin/bash

# AKUMA Net Scan — Ready For War, v2025

color_echo() {
  local color_code=$1
  shift
  echo -e "\e[1;${color_code}m$@\e[0m"
}

color_echo 36 ">>> [0] Установка всех инструментов (nmap, fping, python3, docker, lolcat, git)..."

# Установка инструментов (Debian-based)
if ! command -v nmap &>/dev/null; then
    color_echo 33 "[*] Устанавливаю nmap..."
    sudo apt update && sudo apt install -y nmap
fi
if ! command -v fping &>/dev/null; then
    color_echo 33 "[*] Устанавливаю fping..."
    sudo apt install -y fping
fi
if ! command -v python3 &>/dev/null; then
    color_echo 33 "[*] Устанавливаю python3..."
    sudo apt install -y python3
fi
if ! command -v docker &>/dev/null; then
    color_echo 33 "[*] Устанавливаю docker..."
    sudo apt install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
fi
if ! command -v docker-compose &>/dev/null; then
    color_echo 33 "[*] Устанавливаю docker-compose..."
    sudo apt install -y docker-compose
fi
if ! command -v lolcat &>/dev/null; then
    color_echo 33 "[*] Устанавливаю lolcat..."
    sudo apt install -y lolcat
fi
if ! command -v git &>/dev/null; then
    color_echo 33 "[*] Устанавливаю git..."
    sudo apt install -y git
fi

color_echo 32 "[+] Всё, что надо — установлено!"
sleep 1

### === 0.1. КЛОНИРОВАНИЕ NMAP-DID-WHAT ===
if [ ! -d "/root/nmap-did-what" ]; then
  color_echo 36 "[*] Клонирую nmap-did-what из гита..."
  sudo git clone https://github.com/hackertarget/nmap-did-what.git /root/nmap-did-what
else
  color_echo 32 "[*] /root/nmap-did-what уже есть, пропускаю клонирование."
fi

### === 1. КИБЕРЗАСТАВКА ===

clear
tput civis  # скрыть курсор

glitch_lines=(
"Ξ Запуск терраформирования матрицы... [отключаю холодильник соседа]"
"Ξ Бутстрап рута... [мама сказала, чтобы не запускал это]"
"Ξ Вызов цифрового шамана... [AI-гадание на эксплойте]"
"Ξ Внедрение пакета чёрного кофе... [держусь на последнем байте]"
"Ξ Отправка дронов в darknet... [их там уже ждут]"
"Ξ Переименование себя в admin... ok [ну а что, могу себе позволить]"
"Ξ Калибровка хаос-алгоритма... ok [ещё чуть-чуть, и баг превратится в фичу]"
"Ξ Подмена сигнатуры антивируса... [сканирую на вирусы в самой жизни]"
"Ξ ████████████▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░ [11%] заливаю утреннюю паранойю"
"Ξ ███████████████▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░ [51%] канализирую данные через тостер"
"Ξ ███████████████████████▓▓▓▓▓░░░░░░░░ [82%] провожу ритуал безоткатного доступа"
"Ξ ████████████████████████████████████ [100%] скан завершён — ты официально киборг"
)

for line in "${glitch_lines[@]}"; do
  if command -v lolcat &>/dev/null; then
    echo -ne "\e[1;32m$line\e[0m\n" | lolcat
  else
    echo -ne "\e[1;38;5;82m$line\e[0m\n"
  fi
  sleep 0.2
done

# ASCII-заставка с ником AKUMA
echo -e "\n\e[1;38;5;201m █████╗ ██╗  ██╗██╗   ██╗███╗   ███╗ █████╗ \n██╔══██╗██║ ██╔╝██║   ██║████╗ ████║██╔══██╗\n███████║█████╔╝ ██║   ██║██╔████╔██║███████║\n██╔══██║██╔═██╗ ██║   ██║██║╚██╔╝██║██╔══██║\n██║  ██║██║  ██╗╚██████╔╝██║ ╚═╝ ██║██║  ██║\n╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝\n\e[0m"

echo ""
echo -ne "\e[1;38;5;93m┌──────────────────────────────────────────────────────┐\e[0m\n"
echo -ne "\e[1;38;5;93m│ \e[0m\e[1;38;5;87m WELCOME TO CYBER-DEEP SCAN, АКУМА В СТРОЮ! \e[0m\e[1;38;5;93m│\e[0m\n"
echo -ne "\e[1;38;5;93m└──────────────────────────────────────────────────────┘\e[0m\n"
sleep 1

for i in {1..30}; do
    echo -ne "\e[32m$(head /dev/urandom | tr -dc 'A-Za-z0-9!@#$%^&*_?' | head -c $((RANDOM % 28 + 12)))\r\e[0m"
    sleep 0.05
done

sleep 0.3

nickname="AKUMA"
for ((i=0; i<${#nickname}; i++)); do
    echo -ne "\e[1;31m${nickname:$i:1}\e[0m"
    sleep 0.15
done
echo ""
tput cnorm  # вернуть курсор

sleep 1

### === 2. АНТИЗОМБИ-СКАН ===

if [ -z "$1" ]; then
  color_echo 31 "Usage: $0 <target> (например: 192.168.1.0/24 или 192.168.1.5)"
  exit 1
fi

TARGET=$1
WORKDIR=$(pwd)

color_echo 36 "==================[ AKUMA Net Scan Start ]===================="
color_echo 36 "[*] Цель сканирования: $TARGET"
color_echo 35 "[*] [Шаг 1] Составляем список IP для sweep..."

nmap -n -sL "$TARGET" | awk '/Nmap scan report/{print $NF}' > all_ips.txt

if command -v fping >/dev/null 2>&1; then
  color_echo 35 "[*] [Шаг 2] Ping sweep через fping..."
  fping -a -q -f all_ips.txt 2>/dev/null > ping_stage1.txt
else
  color_echo 35 "[*] [Шаг 2] fping не найден, используем ping (медленно)..."
  > ping_stage1.txt
  for ip in $(cat all_ips.txt); do
    if ping -c 1 -W 1 $ip | grep -q "1 received"; then
      echo $ip >> ping_stage1.txt
      color_echo 32 "[*] $ip отвечает на ICMP."
    fi
  done
fi

color_echo 34 "[*] [Шаг 3] Антизомби-фильтр по TCP-портам..."
> ping.txt
for ip in $(cat ping_stage1.txt); do
  for port in 445 135 80 22 3389; do
    timeout 1 bash -c "echo > /dev/tcp/$ip/$port" 2>/dev/null
    if [ $? -eq 0 ]; then
      echo "$ip" >> ping.txt
      color_echo 32 "[+] $ip реально слушает на $port"
      break
    fi
  done
done

ALIVE=$(wc -l < ping.txt)
color_echo 32 "[*] Живых хостов с реально открытым портом: $ALIVE"
cat ping.txt

if [ "$ALIVE" -eq 0 ]; then
  color_echo 31 "[!] Нет живых хостов с TCP! Останавливаю скан."
  exit 2
fi

color_echo 36 "=============================================================="
color_echo 33 "[*] [Шаг 4] Глубокий портскан с баннерами..."
nmap -iL ping.txt -sV -T5 -Pn -n -p- --min-rate 10000 \
  --script=http-title,ssl-cert,banner \
  -oA nmap_output

color_echo 32 "[*] Сканирование завершено!"
color_echo 32 "[*] Основной отчет: $WORKDIR/nmap_output.xml"
color_echo 36 "=============================================================="

DEST="/root/nmap-did-what/data/"
if [ -d "$DEST" ]; then
  color_echo 33 "[*] Копирую nmap_output.xml в $DEST ..."
  cp nmap_output.xml "$DEST"
else
  color_echo 31 "[!] Папка $DEST не найдена, пропускаю копирование."
fi

if [ -f "$DEST/nmap_output.xml" ]; then
  color_echo 33 "[*] Импортирую в SQLite для Grafana..."
  cd "$DEST"
  python3 nmap-to-sqlite.py nmap_output.xml
  cd "$WORKDIR"
else
  color_echo 31 "[!] XML не найден, пропускаю импорт в SQLite."
fi

if [ -d "/root/nmap-did-what/grafana-docker" ]; then
  color_echo 33 "[*] Запускаю Grafana через docker-compose..."
  cd /root/nmap-did-what/grafana-docker
  sudo docker-compose up -d
  cd "$WORKDIR"
else
  color_echo 31 "[!] grafana-docker не найден, пропускаю запуск Grafana."
fi

color_echo 35 "=============================================================="
color_echo 32 "[*] Все этапы завершены! Время киберохоты! Проверь Grafana!"
color_echo 35 "=============================================================="
