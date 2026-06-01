# AntiGravity 旗艦還原懶人包 (Personalized Version)

本倉庫是專為您的 **Antigravity AI 編碼助理** 打造的全新 PC 一鍵還原與環境遷移方案。除保留了原版 NotebookLM、Firebase 及工作流指南外，特別加入了您**本地客製化的系統環境 (Git, Node, Python)、本地中文語言外掛、WPS 文檔操控 MCP 服務、Firecrawl 爬蟲服務，以及離線一鍵漢化與還原管理控制面板**，確保新電腦一鍵開箱即用。

---

## 📂 倉庫結構與檔案說明

```text
├── README.md                 # 倉庫說明文件（已客製化更新）
├── SKILL.md                  # AI 助理一鍵安裝與部署引導入口（已註冊新技能）
├── setup_antigravity.ps1     # 🚀 全新 PC 一鍵自動還原 PowerShell 腳本
├── 09-AntiGravity專屬懶人包.md # 詳細的服務連接教學手冊
└── skills/                   # 各項還原模組獨立技能庫
    ├── 00-install-all        # 一次安裝原版基礎技能
    ├── 01-notebooklm         # 連接 NotebookLM MCP
    ├── 02-github             # 連接 GitHub CLI 授權
    ├── 03-firebase           # 連接 Firebase MCP
    ├── 04-draw               # 生圖指引
    ├── 05-workflow           # 自動化開工/收工/專案初始化
    ├── 06-env-setup          # 部署 Git, Node.js, Python, gh-cli 環境
    ├── 07-wps-office         # 部署客製化 WPS Office MCP 操作伺服器
    ├── 08-firecrawl          # 部署 Firecrawl MCP 全域爬蟲
    ├── 09-antigravity-app    # 還原全域 argv/mcp.json 設定及中文語言包
    ├── 10-install-all-premium# 一鍵部署上述全部 Premium 設定
    └── 11-chinese-localization# 🇨🇳 【離線一鍵漢化與還原可視化管理控制台】
```

---

## 🚀 部署與使用方式

### 方式一：全新 PC 一鍵還原（強烈推薦）
在新電腦上打包主程式後，下載本倉庫並以**系統管理員權限**啟動 PowerShell，執行根目錄下的一鍵指令檔：
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\setup_antigravity.ps1
```
> 指令檔會自動偵測並安裝所有開發工具（Git、Node、Python）、配置目錄與設定檔、動態對齊新用戶路徑，並完成 `wps-skills` 克隆與 TypeScript 編譯，實現 99% 的全自動部署。

### 方式二：交給您的新電腦 AI 助理執行
將此 GitHub 倉庫網址貼給新 PC 上的 AI 助理，並對它說：
> *"這是我的 Antigravity 還原懶人包 <您的倉庫地址>。請讀取 repo 的 SKILL.md 安裝入口，列出可用技能，並幫我自動安裝部署。"*

---

## 🇨🇳 離線一鍵中文漢化與還原面板 (L10N Dashboard)

本倉庫內建了完整的離線漢化引擎（源自 `liominsb/Antigravity-Chinese-Localization`），您無需再下載其他第三方工具即可本地運行漢化或還原：

### 1. 啟動管理面板
1. 開啟終端機或檔案總管，進入倉庫的 `skills\11-chinese-localization\` 目錄。
2. 雙擊運行 **`双击运行汉化.bat`**。
3. 腳本將在背景啟動 Node.js 服務並自動為您開啟瀏覽器控制台：
   👉 **`http://localhost:3388`**

### 2. 網頁可視化操作
* **一鍵漢化 (Localize App)**：自動備份您的原始 `app.asar` 為 `app.asar.bak`，並向 preload.js、menu.js、tray.js 注入精準的中文 UI DOM 翻譯，點擊即可完成漢化。
* **一鍵還原英文 (Restore English)**：當程式升級、出錯或您想回歸官方英文原版時，點擊即可秒速覆蓋還原備份，100% 安全無殘留！

---

## 🔐 安全防護原則
* 本倉庫**不存儲**任何個人帳號的 `GITHUB_TOKEN`、`FIRECRAWL_API_KEY`、Firebase Admin 密鑰或 NotebookLM 緩存，所有敏感性帳號均引導在還原後透過 OAuth 一次性安全登入，確保您的資訊安全。
* 當您變更了新的本地 MCP 服務時，可以直接提交更新到本 GitHub 倉庫，方便永久同步維護您的專屬 AI 助理環境！
