---
name: antigravity-lazy-packs
description: AntiGravity 懶人包 — 全套開發環境、全域設定、WPS 操控、自定義技能、自我進化與工作流程還原。說「AntiGravity 懶人包」「還原 Antigravity 設定」時載入。
---

# AntiGravity 懶人包 — AI Agent 自動還原與安裝入口

這是為您的 Antigravity 設計的**全新 PC 旗艦版還原懶人包**。當您在新電腦上安裝並希望自動部署開發環境時，請將此 repo 網址貼給您的 AI 助理，助理將列出以下所有可用模組並進行自動配置：

## 步驟一：盤點可用還原與安裝模組

| 編號 | Skill 名稱 | 說明 |
|------|-----------|------|
| **06** | `06-env-setup` | 部署系統基礎開發環境（Git, Node.js, Python, GitHub CLI） |
| **09** | `09-antigravity-app` | 還原全域 argv/mcp.json 設定、開機跳過導覽、中文語言擴充外掛 |
| **11** | `11-chinese-localization` | 離線一鍵漢化與還原管理面板（安全注入中文 UI DOM 翻譯引擎） |
| **12** | `12-self-improvement` | **【NEW】自我進化技能 (Self-Improvement) — 自動記錄執行錯誤、踩坑經驗與學習筆記以實現持續自我優化** |
| **13** | `13-antigravity-design-expert` | **【NEW】Antigravity 視覺運動設計專家 — 專注於 GSAP、3D CSS、微動態與毛玻璃高級 UI 的構建** |
| **14** | `14-antigravity-skill-orchestrator` | **【NEW】技能調度協調器 — 智慧識別複雜任務、動態組合與調度多個 MCP 服務，避免無效調用** |
| **15** | `15-antigravity-workflows` | **【NEW】Antigravity 流程策劃大師 — 將複雜項目拆解為「Ship SaaS MVP」、「安全審計」等自動引導步驟** |
| **01** | `01-notebooklm` | 連接 NotebookLM MCP 伺服器 |
| **03** | `03-firebase` | 連接 Firebase MCP 伺服器 |
| **07** | `07-wps-office` | 部署客製化 WPS Office 系統操作 MCP 伺服器（操作 Word/Excel/PPT） |
| **08** | `08-firecrawl` | 全域部署網頁爬蟲 Firecrawl MCP 解析服務 |
| **02** | `02-github` | 連接 GitHub CLI 授權登入 |
| **04** | `04-draw` | 生圖提示指南 |
| **05** | `05-workflow` | 配置專案自動化開工 / 收工 / 新專案初始化流程 |
| **10** | `10-install-all-premium` | **【旗艦版】一鍵部署上述所有開發環境與 MCP 自訂外掛服務 (推薦)** |
| **00** | `00-install-all` | 一次安裝原版基礎技能 |

## 步驟二：選擇還原與安裝方式

* **方式一：一鍵腳本自動還原（強烈推薦，手動執行最簡便）**
  直接在管理員權限的 PowerShell 中執行倉庫根目錄下的一鍵指令檔：
  ```powershell
  Set-ExecutionPolicy Bypass -Scope Process -Force
  .\setup_antigravity.ps1
  ```

* **方式二：透過 AI 助理自動讀取並逐一還原**
  讓新電腦上的 AI 助理讀取此 repo 下對應編號的 `skills/<編號>-<名稱>/SKILL.md`，並下達安裝指令：
  ```bash
  npx skills add <您的用戶名>/antigravity-lazy-pack --skill <skill名稱> -g -y
  ```
  *(若無 `npx skills` 工具，AI 助理會自動讀取 SKILL.md 中的 PowerShell 與 JSON 指令，直接在您的新電腦上為您運行！)*
