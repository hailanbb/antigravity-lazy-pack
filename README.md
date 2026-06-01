# AntiGravity 旗艦還原懶人包 (Personalized Version)

本倉庫是專為您的 **Antigravity AI 編碼助理** 打造的全新 PC 一鍵還原與環境遷移方案。本版本全面升級，除原版 NotebookLM、Firebase 之外，完整封裝了您**本地客製化的開發環境 (Git, Node, Python)、本地中文語言外掛、WPS 文檔操控 MCP 服務、Firecrawl 爬蟲服務、離線一鍵漢化網頁控制台，以及自我進化 (Self-Improvement) 技能與自訂大師級技能組**，確保新電腦一鍵還原即可擁有最強悍的 AI 助手。

---

## 📂 倉庫結構與檔案說明

```text
├── README.md                 # 倉庫說明文件（已升級客製化）
├── SKILL.md                  # AI 助理一鍵安裝與部署引導入口（已註冊全部技能）
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
    ├── 11-chinese-localization# 🇨🇳 離線一鍵漢化與還原可視化管理控制台
    ├── 12-self-improvement   # 🧠 【新增】自我進化技能 (記錄錯誤與踩坑知識庫)
    ├── 13-antigravity-design-expert # 🎨 【新增】Antigravity 視覺運動與 3D UI 設計專家
    ├── 14-antigravity-skill-orchestrator # 🤖 【新增】技能調度協調器 (動態多工協同)
    └── 15-antigravity-workflows # 🚀 【新增】SaaS MVP / 安全審計流程策劃大師
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

## 🧠 新增核心技能亮點介紹

### 1. 自我進化技能 (`12-self-improvement`)
* 這是專為 AI 助理設計的**反思與學習引擎**。當遇到命令報錯、外部 API 斷開、使用者指正（"不对，這裏應該是..."）或踩坑時，助理會自動在專案的 `.learnings/` 底下寫入 `LEARNINGS.md` 與 `ERRORS.md`。
* 在下一次面對類似任務時，助理會自動讀取並避開歷史錯誤，實現持續的自我進化與修正。

### 2. 視覺運動與 3D UI 專家 (`13-antigravity-design-expert`)
* 專注於開發具有「Antigravity 風格」的極致視覺網頁。包含 buttery-smooth 的 **GSAP 動畫**、**3D CSS 旋轉與 perspective**、**高級毛玻璃效果 (Glassmorphism)** 和高水準的微動態 UI 組件，讓您的前端介面達到 premium 級別。

### 3. 智慧技能調度器與流程大師 (`14-skill-orchestrator` & `15-workflows`)
* **`skill-orchestrator`** 是一個元技能（Meta-skill），能動態辨識任務複雜度，並智慧組合、調用多個 MCP 服務（如 WPS+Firecrawl），避免資源浪費。
* **`workflows`** 則內建了「交付一個 SaaS 項目」、「執行安全審計」等一系列大師級指導步驟，能一步步指引助理產出完美交付物。

---

## 🔐 安全防護原則
* 本倉庫**不存儲**任何個人帳號的 `GITHUB_TOKEN`、`FIRECRAWL_API_KEY`、Firebase Admin 密鑰或 NotebookLM 緩存，所有敏感性帳號均引導在還原後透過 OAuth 一次性安全登入，確保您的資訊安全。
* 當您變更了新的本地 MCP 服務時，可以直接提交更新到本 GitHub 倉庫，方便永久同步維護您的專屬 AI 助理環境！
