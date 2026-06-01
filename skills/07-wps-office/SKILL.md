---
name: antigravity-wps-office
description: 克隆與編譯 WPS Office MCP 操控服務。說「安裝 WPS」「配置 WPS 操控」時載入。
---

# 克隆與編譯 WPS Office MCP 服務

這個技能可以為使用者安裝與配置操控金山/WPS Office 文檔的 MCP 伺服器，讓 AI 能夠以超高流暢度操作 Excel、Word 和 PPT。

## 部署步驟

### 1. 建立技能暫存目錄
在 PowerShell 中執行以下指令：
```powershell
mkdir -p "$env:USERPROFILE\.gemini\antigravity\scratch"
```

### 2. 克隆 wps-skills 項目
```powershell
cd "$env:USERPROFILE\.gemini\antigravity\scratch"
git clone https://github.com/lc2panda/wps-skills.git wps-skills
```

### 3. 安裝相依套件與編譯 TypeScript
```powershell
cd wps-skills\wps-office-mcp
npm install
npm run build
```

### 4. 註冊局部 MCP 伺服器
請在您的 `C:\Users\<您的用戶名>\.gemini\antigravity\mcp_config.json` 設定檔的 `mcpServers` 底下填寫以下內容：

```json
"wps-office": {
  "command": "node",
  "args": [
    "C:\\Users\\<您的用戶名>\\.gemini\\antigravity\\scratch\\wps-skills\\wps-office-mcp\\dist\\index.js"
  ]
}
```

> [!IMPORTANT]
> 請將上述 JSON 中的 `<您的用戶名>` 替換為新 PC 的實際 Windows 使用者名稱，並確保雙反斜線 (`\\`) 的格式正確。
