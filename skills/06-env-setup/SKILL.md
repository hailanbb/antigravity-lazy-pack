---
name: antigravity-env-setup
description: 安裝與配置基礎系統環境 (Git, Node.js, Python, GitHub CLI)。說「安裝基礎環境」「配置 Git/Node/Python」時載入。
---

# 部署基礎系統環境

這個技能可以引導或為使用者自動配置新電腦上的系統環境。

## 安裝步驟

### 1. 偵測與安裝開發軟體
在管理員權限的 PowerShell 視窗中執行以下 `winget` 指令來自動安裝基礎工具（免手動開瀏覽器下載）：

```powershell
# 安裝 Git
winget install --id Git.Git -e --silent --accept-source-agreements --accept-package-agreements

# 安裝 Node.js LTS 
winget install --id OpenJS.NodeJS.LTS -e --silent --accept-source-agreements --accept-package-agreements

# 安裝 Python 3.11 
winget install --id Python.Python.3.11 -e --silent --accept-source-agreements --accept-package-agreements

# 安裝 GitHub CLI
winget install --id GitHub.cli -e --silent --accept-source-agreements --accept-package-agreements
```

### 2. 重新整理環境變數
安裝完成後，**必須重啟終端機視窗**以使新的環境變數生效。您可以透過以下指令檢查是否安裝成功：

```powershell
git --version
node --version
npm.cmd --version
python --version
gh --version
```

### 3. 配置 Git 使用者名稱與信箱
```powershell
git config --global user.name "Your Name"
git config --global user.email "your-email@example.com"
```
