---
name: antigravity-install-all-premium
description: 一鍵部署全新 PC 全部開發環境、全域設定、WPS 操控與外掛 (Premium)。說「一鍵安裝全部」「安裝旗艦版懶人包」時載入。
---

# 一鍵部署全新 PC 開發環境、全域設定與自訂外掛 (Premium)

這個技能是一次性將所有開發環境、全域與局部 MCP 設定檔、WPS 操控技能、Firecrawl 網頁爬蟲、語言包外掛還原到新電腦的終極方案。

## 部署與還原清單

本套件將依次為您安裝與部署以下模組：

1. **06-env-setup** — 系統基礎開發工具（Git, Node.js, Python, GitHub CLI）自動化安裝與配置
2. **09-antigravity-app** — 還原主程式路徑、中文語言包（ms-ceintl）、全域 `argv.json` 與 `mcp.json` 設定，開機自動跳過首次教學引導
3. **01-notebooklm** — 下載並註冊 NotebookLM MCP 服務
4. **03-firebase** — 註冊 Firebase MCP 服務
5. **07-wps-office** — 自動克隆並編譯客製化 WPS Office 系統操作 MCP 伺服器
6. **08-firecrawl** — 全域安裝並配置網頁解析 Firecrawl MCP
7. **02-github** — 配置與登入 GitHub CLI 連接
8. **04-draw** — AI 畫圖指引
9. **05-workflow** — 自動化開工/收工/初始化專案流程

## 自動還原方法

### 🚀 最推崇：透過一鍵指令檔還原
在該懶人包的根目錄下，我們為您設計了 `setup_antigravity.ps1` 部署指令檔，它能完全自動地運行以上所有邏輯。

請以 **系統管理員身分** 啟動 PowerShell 終端機，執行以下指令：
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\setup_antigravity.ps1
```

這將以高達 99% 的自動化率為您一次部署完畢！
