# AntiGravity 旗艦還原懶人包 (Personalized Version)

本倉庫是專為您的 **Antigravity AI 編碼助理** 打造的全新 PC 一鍵還原與環境遷移方案。本版本全面升級，除原版 NotebookLM、Firebase 之外，完整封裝了您**本地客製化的開發環境 (Git, Node, Python)、本地中文語言外掛、WPS 文檔操控 MCP 服務、Firecrawl 爬蟲服務、離線一鍵漢化網頁控制台，以及自我進化 (Self-Improvement) 技能與自訂大師級技能組**，確保新電腦一鍵還原即可擁有最強悍的 AI 助手。

---

## 📂 倉庫結構與檔案說明

```text
├── README.md                 # 倉庫說明文件（已升級客製化）
├── SKILL.md                  # AI 助理一鍵安裝與部署引導入口（已註冊全部技能）
├── setup_antigravity.ps1     # 🚀 全新 PC 三階段一鍵自動還原腳本 (修復 MCP 面板不可見問題)
├── reset_antigravity.ps1     # 🧹 【新增】環境強制清理與重置腳本 (用於還原初始狀態與 PC 維護)
├── 09-AntiGravity專屬懶人包.md # 詳細的服務連接教學手冊
└── skills/                   # 各項還原模組獨立技能庫
    ├── 00-install-all        # 一次安裝原版基礎技能
    ├── ... (其餘模組省略)
    ├── 12-self-improvement   # 🧠 自我進化技能 (記錄錯誤與踩坑知識庫)
    ├── 13-antigravity-design-expert # 🎨 Antigravity 視覺運動與 3D UI 設計專家
    ├── 14-antigravity-skill-orchestrator # 🤖 技能調度協調器 (動態多工協同)
    └── 15-antigravity-workflows # 🚀 SaaS MVP / 安全審計流程策劃大師
```

---

## 🚀 部署與使用方式

### 方式一：全新 PC 一鍵全自動下載與還原（強烈推薦）
在最新的版本中，我們將下載倉庫與執行的步驟整合為一句自動化指令。只需在新電腦上以**系統管理員權限啟動 PowerShell**，並複製貼上以下指令：

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-WebRequest -Uri "https://github.com/hailanbb/antigravity-lazy-pack/archive/refs/heads/main.zip" -OutFile "$env:TEMP\lazy-pack.zip"; Expand-Archive -Path "$env:TEMP\lazy-pack.zip" -DestinationPath "$env:TEMP\lazy-pack" -Force; Set-Location "$env:TEMP\lazy-pack\antigravity-lazy-pack-main"; .\setup_antigravity.ps1
```

> 此指令將自動從 GitHub 下載最新版懶人包、解壓縮到系統暫存資料夾，並直接觸發 `setup_antigravity.ps1`，讓您連「點擊下載」的步驟都省了！

**腳本會執行以下三個階段：**
1. **第一階段：基礎環境部署**
   自動安裝 Git, Node.js, Python, gh-cli，並重新加載 PATH 變數以進行嚴格驗證，確保環境就緒。
2. **第二階段：部署自定義技能**
   自動將 `skills` 目錄中的資源無縫拷貝至全域目錄。
3. **第三階段：配置與安裝 MCP 服務**
   動態克隆並編譯 WPS Office、Firecrawl 與 NotebookLM 等 MCP 服務。**此階段已修復 `mcp_config.json` 路徑反斜線格式轉義異常的問題，確保所有服務均能在 Antigravity 2.0.11 中正常顯示。**

---

## 🧹 環境維護：一鍵重置指令

為了防止安裝過程中遇到任何意外情況，或者您需要維護 PC 使其恢復至最原始的乾淨狀態，我們新增了重置指令檔：

```powershell
.\reset_antigravity.ps1
```
**作用：**
執行此命令後，腳本會安全刪除 `$env:USERPROFILE\.gemini` 與 `$env:USERPROFILE\.antigravity` 等核心暫存與設定檔資料夾，將系統重置為初始狀態。隨後您可以再次使用 `setup_antigravity.ps1` 進行全新乾淨安裝。

---

## 🔐 安全防護原則
* 本倉庫**不存儲**任何個人帳號的 `GITHUB_TOKEN`、`FIRECRAWL_API_KEY` 等密鑰，腳本將在安裝時以安全對話方塊要求輸入（或引導登入），確保您的資訊安全。
* 當您變更了新的本地 MCP 服務時，可以直接提交更新到本 GitHub 倉庫，方便永久同步維護您的專屬 AI 助理環境！
