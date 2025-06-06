# AKUMA\_NET\_SCAN - 悪魔のゼロデей・ネットワークハンтер

*"When the neon fog descends, AKUMA hunts the living hosts among cyber-ghosts..."*

---

🚀 **概要 (Overview)**

**AKUMA\_NET\_SCAN** (悪魔 — “Demon”) — это инструмент высокоинтенсивной киберразведки для сетевого пентеста, рожденный в кибер-катакомбах Токио.
AKUMA обходит зомби-прокси, выявляет только реально живые тачки и автоматически отправляет отчеты прямо в твой Grafana-храм, чтобы ты мог искать, как истинный охотник теней.

---

# 起動コマンド (Activation Sequence)

```bash
sudo ./AKUMA_Net_Scan.sh 10.154.0.0/23
```
![image](https://github.com/user-attachments/assets/4339ab08-ad07-42ff-917b-9663bd3c365c)

---

🔥 **特徴 (Features)**

* **Demon Scan Core:**
  Два круга ада: ICMP-пинг + TCP-фильтрация, чтобы зомби даже не мечтали попасть в твой отчёт.
* **Автоматическая магия:**
  Установит всё, что надо — вплоть до lolcat и docker.
* **Антизомби:**
  Защита от proxy-ARP, туннелей и сетевых призраков.
* **Full-Auto Grafana Integration:**
  XML-отчёт сразу импортируется в SQLite и появляется в Grafana.
* **CYBERPUNK-ASCII:**
  Заставка-ритуал с неоновым арт-эффектом и философией AKUMA.
* **One-Click Deploy:**
  Клонирует `nmap-did-what`, всё ставит и запускает.
* **Only Living Hosts:**
  Ни одного мертвяка, только те, кто реально дышит в сети.

---

💀 **システム要件 (System Requirements)**

# 地獄の依存関係 (Dependencies from Hell)

```bash
sudo apt install git python3 nmap fping docker.io docker-compose lolcat
```

(Скрипт сам всё установит при первом запуске!)

---

🗡️ **使用方法 (Usage)**

# 1. 悪魔の覚醒 (Wake the Demon)

```bash
chmod +x AKUMA_Net_Scan.sh
sudo ./AKUMA_Net_Scan.sh 10.154.0.0/23
```

# 2. 収穫 (Collect the Blood Bounty)

* Открывай Grafana на сервере (`localhost:3000` по умолчанию *admin:admin впервый вход нужно поменять пароль).
* Фильтруй, ищи, бей только реальных врагов.
* Все данные уже в SQLite — ничто не укроется.
![image](https://github.com/user-attachments/assets/5fe348b3-462c-49b7-93c8-c78f57d4ddc7)
---

🌌 **出力例 (Sample Output)**

\[ネオンに血の雨] Результаты сканирования:
• Living hosts (real, not zombies): 9
• Each host: портовые баннеры, SSL, HTTP title
• Nmap XML сразу в Grafana
• Фантомы и зомби-прокси — *excluded by force*

```
 █████╗ ██╗  ██╗██╗   ██╗███╗   ███╗ █████╗ 
██╔══██╗██║ ██╔╝██║   ██║████╗ ████║██╔══██╗
███████║█████╔╝ ██║   ██║██╔████╔██║███████║
██╔══██║██╔═██╗ ██║   ██║██║╚██╔╝██║██╔══██║
██║  ██║██║  ██╗╚██████╔╝██║ ╚═╝ ██║██║  ██║
╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝
```

---

⚠️ **免責事項 (Disclaimer)**

Этот инструмент создан для **легального** пентеста и оценки защищённости вашей инфраструктуры.
*"The demon bites both ways — use responsibly. If you awaken ghosts, be ready to face the shadows..."*

---

```
    _  _                  _  _            
   / \/ \   _   _   _   / \/ \    _   _  
  / /\_/\ / \ / \ / \ / /\_/\ \ / \ / \ 
  \/      \_/ \_/ \_/ \/      \/ \_/ \_/ 
  AKUMA sees you. The rest are blind.
```

Github: [https://github.com/sweetpotatohack/AKUMA\_Net\_Scan](https://github.com/sweetpotatohack/AKUMA_Net_Scan)
License: BSD 3-Clause "Blood Pact Edition"

---

**AKUMA\_NET\_SCAN — “В неоновых тенях цифрового ада только живые IP дышат в отчёте…”**
