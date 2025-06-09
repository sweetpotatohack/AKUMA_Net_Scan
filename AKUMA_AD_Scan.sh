#!/bin/bash

set -e

# ===================== Арт и приветствие =====================
clear
tput civis

glitch_lines=(
"Ξ Запуск кибердек ядра... [ну наконец-то]"
"Ξ Внедрение системных эксплойтов... [не спрашивай откуда они]"
"Ξ Рукопожатие с нейросетью... [надеемся, что она дружелюбная]"
"Ξ Подмена MAC-адреса... ok [теперь я - принтер HP]"
"Ξ Ректификация сплайнов... ok [никто не знает, что это]"
"Ξ Инициализация модуля анализа целей... [прицел калиброван]"
"Ξ Выпуск дронов SIGINT... [вышли через Wi-Fi соседа]"
"Ξ Подключение к интерфейсу кибервойны... [настраиваю лазерную указку]"
"Ξ ████████████▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░ [10%] загрузка кофеина"
"Ξ ███████████████▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░ [42%] теряется связь с реальностью"
"Ξ ███████████████████████▓▓▓▓▓░░░░░░░░ [76%] синхронизация с darknet"
"Ξ ████████████████████████████████████ [100%] ты больше не человек"
)

for line in "${glitch_lines[@]}"; do
  if command -v lolcat &>/dev/null; then
    echo -ne "\e[1;32m$line\e[0m\n" | lolcat
  else
    echo -ne "\e[1;32m$line\e[0m\n"
  fi
  sleep 0.18
done

echo ""
echo -ne "\e[1;35m┌──────────────────────────────────────────────────────┐\e[0m\n"
echo -ne "\e[1;35m│ \e[0m\e[1;36m   HACK MODULE LOADED :: WELCOME, OPERATIVE.   \e[0m\e[1;35m      │\e[0m\n"
echo -ne "\e[1;35m└──────────────────────────────────────────────────────┘\e[0m\n"
sleep 1

for i in {1..20}; do
    echo -ne "\e[32m$(head /dev/urandom | tr -dc 'A-Za-z0-9!@#$%^&*_?' | head -c $((RANDOM % 22 + 10)))\r\e[0m"
    sleep 0.05
done

sleep 0.3

nickname="AKUMA"
for ((i=0; i<${#nickname}; i++)); do
    echo -ne "\e[1;31m${nickname:$i:1}\e[0m"
    sleep 0.13
done

echo -e "\n"
echo -e "\n💀 Все системы онлайн. Если что — это не мы."
echo -e "🧠 Добро пожаловать в матрицу, \e[1;32m$nickname\e[0m... У нас тут sudo и печеньки 🍪."
tput cnorm
echo -e "\n"

# ===================== HELP МЕНЮ =====================

show_help() {
  echo -e "\n\033[1;36mAKUMA AD/Net Scan\033[0m"
  echo "Использование:"
  echo "  $0 <target1> [target2 ...] <username> <password> [domain]"
  echo "  $0 targets.txt <username> <password> [domain]"
  echo ""
  echo "Где:"
  echo "  <target1> ...   — диапазон (например, 192.168.1.0/24, 10.0.0.1)"
  echo "  targets.txt     — файл со списком сетей/адресов по одной в строке"
  echo "  <username>      — имя пользователя (например, Administrator)"
  echo "  <password>      — пароль"
  echo "  [domain]        — (опционально) имя домена, если нужно"
  echo ""
  echo "Примеры:"
  echo "  $0 10.0.0.0/23 'pentester' 'Passw0rd!'"
  echo "  $0 targets.txt admin 'Secret123' LAB.LOCAL"
  echo ""
  echo "  -h, --help      — показать это меню"
  echo ""
  echo "Автор: AKUMA, 2025. Powered by NetExec + nmap + bash."
  exit 0
}

# HELP по флагу или отсутствию обязательных аргументов
if [[ "$1" == "-h" || "$1" == "--help" || $# -lt 3 ]]; then
  show_help
fi

# ===================== Парсинг целей и кредов =====================

SUBNETS=()
if [[ -f "$1" ]]; then
    while read -r line; do
        [[ -z "$line" || "$line" =~ ^# ]] && continue
        SUBNETS+=("$line")
    done < "$1"
    shift 1
else
    # Собираем всё, что похоже на IP/подсеть
    while [[ "$1" =~ ^[0-9a-fA-F\.:/]+$ ]]; do
      SUBNETS+=("$1")
      shift 1
    done
fi

USERNAME="$1"
PASSWORD="$2"
DOMAIN="${3:-}"

if [[ -z "$USERNAME" || -z "$PASSWORD" ]]; then
  show_help
fi

echo -e "\e[36m[*] Цели для сканирования:\e[0m"
for s in "${SUBNETS[@]}"; do echo "   $s"; done
echo -e "\e[36m[*] Используем креды:\e[0m $USERNAME / $PASSWORD / $DOMAIN"
echo ""

# ===================== Проверка утилит =====================

for i in nmap fping python3 git; do
  if ! command -v $i &>/dev/null; then
    echo -e "\e[33m[*] Устанавливаю $i ...\e[0m"
    sudo apt update && sudo apt install -y $i
  fi
done

if ! command -v nxc &>/dev/null; then
    echo -e "\e[33m[!] NetExec (nxc) не найден! Установи из https://github.com/Pennyw0rth/NetExec \e[0m"
    exit 1
fi

# ===================== Конфиг =====================
WORK_DIR="$HOME/AD"
OUTPUT_DIR="$WORK_DIR/results_$(date +%Y%m%d_%H%M%S)"
LOG_FILE="$OUTPUT_DIR/scan.log"
MAX_PARALLEL=12
TIMEOUT_PER_HOST=180

mkdir -p "$OUTPUT_DIR/logs" "$OUTPUT_DIR/results"

SMB_MODULES=(ms17-010 smbghost zerologon nopac petitpotam printnightmare spooler coerce_plus netlogon shadowcoerce dfscoerce printerbug)
LDAP_MODULES=(ldap-checker enum_trusts find-computer subnets obsolete pre2k adcs delegations laps gpp_password get-desc-users user-desc groupmembership)
AUX_MODULES=(enum_dns enum_ca rdp web_delivery vnc mssql_priv wdigest)

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"; }

# ===================== Функции =====================

scan_hosts() {
    local protocol=$1
    local ports=$2
    local out_file="$OUTPUT_DIR/${protocol}_hosts.txt"
    log "Сканирование ${protocol} хостов (порты ${ports})..."
    nmap -Pn -p${ports} --open --min-rate 200 --max-retries 2 \
         --max-rtt-timeout 1500ms --min-hostgroup 100 \
         "${SUBNETS[@]}" -oG - | awk '/Up$/{print $2}' > "$out_file"
    local count=$(wc -l < "$out_file")
    log "Найдено ${count} ${protocol} хостов"
}

run_check() {
    local host=$1
    local protocol=$2
    local module=$3
    local log_file="$OUTPUT_DIR/logs/${protocol}_${module}_${host//\//_}.log"
    local result_file="$OUTPUT_DIR/results/${protocol}_${module}.txt"
    # Аргументы для nxc
    AUTH_ARGS="-u '$USERNAME' -p '$PASSWORD'"
    [ -n "$DOMAIN" ] && AUTH_ARGS="$AUTH_ARGS -d '$DOMAIN'"

    timeout $TIMEOUT_PER_HOST nxc "$protocol" "$host" $AUTH_ARGS -M "$module" > "$log_file" 2>&1
    case $module in
        zerologon|nopac|petitpotam|printnightmare|ms17-010|smbghost)
            grep -q 'VULNERABLE\|Potentially vulnerable\|Vulnerable' "$log_file" && {
                echo "$host - $(grep -m1 'VULNERABLE\|Potentially vulnerable\|Vulnerable' "$log_file")" >> "$result_file"
            }
            ;;
        *)
            grep -q '[+]' "$log_file" && {
                echo "$host - $(grep -m1 '[+]' "$log_file")" >> "$result_file"
            }
            ;;
    esac
    [ $(stat -c%s "$log_file" 2>/dev/null || echo 0) -lt 50 ] && rm -f "$log_file"
}

main_checks() {
    scan_hosts "smb" "445"
    scan_hosts "ldap" "389,636"
    scan_hosts "rdp" "3389"
    scan_hosts "mssql" "1433"
    for module in "${SMB_MODULES[@]}"; do
        log "Запуск SMB проверки: $module"
        count=0
        while IFS= read -r host; do
            run_check "$host" "smb" "$module" &
            (( ++count % MAX_PARALLEL == 0 )) && wait
        done < "$OUTPUT_DIR/smb_hosts.txt"
        wait
        touch "$OUTPUT_DIR/results/smb_${module}.txt"
    done
    for module in "${LDAP_MODULES[@]}"; do
        log "Запуск LDAP проверки: $module"
        count=0
        while IFS= read -r host; do
            run_check "$host" "ldap" "$module" &
            (( ++count % MAX_PARALLEL == 0 )) && wait
        done < "$OUTPUT_DIR/ldap_hosts.txt"
        wait
        touch "$OUTPUT_DIR/results/ldap_${module}.txt"
    done
    for module in "${AUX_MODULES[@]}"; do
        case $module in
            enum_dns|enum_ca)
                log "Запуск DNS/CA проверок"
                nxc dns "${SUBNETS[@]}" -u "$USERNAME" -p "$PASSWORD" ${DOMAIN:+-d "$DOMAIN"} -M "$module" > "$OUTPUT_DIR/logs/${module}.log" 2>&1
                grep '[+]' "$OUTPUT_DIR/logs/${module}.log" > "$OUTPUT_DIR/results/${module}.txt" || true
                ;;
            rdp|vnc|mssql_priv)
                proto="${module%_*}"
                log "Проверка $proto ($module)"
                count=0
                while IFS= read -r host; do
                    run_check "$host" "$proto" "$module" &
                    (( ++count % MAX_PARALLEL == 0 )) && wait
                done < "$OUTPUT_DIR/${proto}_hosts.txt"
                wait
                touch "$OUTPUT_DIR/results/${proto}_${module}.txt"
                ;;
            *)
                log "Пропуск неподдерживаемого модуля: $module"
                ;;
        esac
    done
}

generate_report() {
    local report="$OUTPUT_DIR/FINAL_REPORT.txt"
    echo "=== ИТОГОВЫЙ ОТЧЕТ ===" > "$report"
    echo "Дата: $(date)" >> "$report"
    echo "Проверенные подсети:" >> "$report"
    printf "  %s\n" "${SUBNETS[@]}" >> "$report"
    echo -e "\n=== КРИТИЧЕСКИЕ УЯЗВИМОСТИ ===" >> "$report"
    grep -r -h 'VULNERABLE\|CRITICAL' "$OUTPUT_DIR/results" >> "$report"
    echo -e "\n=== ПОТЕНЦИАЛЬНЫЕ УЯЗВИМОСТИ ===" >> "$report"
    grep -r -h 'Potentially vulnerable\|WARNING' "$OUTPUT_DIR/results" >> "$report"
    echo -e "\n=== КОНФИДЕНЦИАЛЬНЫЕ ДАННЫЕ ===" >> "$report"
    grep -r -h 'Password\|Hash\|Secret\|Credential' "$OUTPUT_DIR/results" >> "$report"
    echo -e "\n=== ВСЕ АКТИВНЫЕ ХОСТЫ ===" >> "$report"
    echo "SMB (445/tcp): $(wc -l < "$OUTPUT_DIR/smb_hosts.txt")" >> "$report"
    echo "LDAP (389,636/tcp): $(wc -l < <(cat "$OUTPUT_DIR/ldap_hosts.txt" 2>/dev/null || echo ""))" >> "$report"
    echo "RDP (3389/tcp): $(wc -l < "$OUTPUT_DIR/rdp_hosts.txt")" >> "$report"
    echo "MSSQL (1433/tcp): $(wc -l < "$OUTPUT_DIR/mssql_hosts.txt")" >> "$report"
    echo -e "\n=== ПРОВЕРЕННЫЕ МОДУЛИ ===" >> "$report"
    printf "SMB: %s\n" "${SMB_MODULES[@]}" >> "$report"
    printf "LDAP: %s\n" "${LDAP_MODULES[@]}" >> "$report"
    printf "Другие: %s\n" "${AUX_MODULES[@]}" >> "$report"
}

cleanup() {
    log "Очистка пустых файлов..."
    find "$OUTPUT_DIR/logs" -type f -size 0 -delete
    find "$OUTPUT_DIR/results" -type f -size 0 -delete
}

main() {
    log "Начало сканирования"
    log "Проверяемые подсети:"
    printf "  %s\n" "${SUBNETS[@]}" | tee -a "$LOG_FILE"
    main_checks
    cleanup
    generate_report
    log "Проверка завершена. Отчет: $OUTPUT_DIR/FINAL_REPORT.txt"
    echo -e "\n\e[1;36m=== КРАТКАЯ СТАТИСТИКА ===\e[0m"
    echo -e "Найдено уязвимых систем:"
    grep -r -h 'VULNERABLE\|CRITICAL' "$OUTPUT_DIR/results" | wc -l | awk '{print "  Критические: " $1}'
    grep -r -h 'Potentially vulnerable\|WARNING' "$OUTPUT_DIR/results" | wc -l | awk '{print "  Предупреждения: " $1}'
    echo -e "\nПолный отчет: \e[1;33m$OUTPUT_DIR/FINAL_REPORT.txt\e[0m"
}

main
