---
name: antigravity-firecrawl
description: 全域安裝與註冊 Firecrawl MCP 網頁爬蟲服務。說「安裝 Firecrawl」「設定網頁爬蟲」時載入。
---

# 全域安裝與註冊 Firecrawl MCP 網頁爬蟲服務

這個技能可以為使用者配置全域網頁爬蟲及解析服務，方便 AI 助理直接抓取和分析各大網頁內容。

## 部署步驟

### 1. 全域安裝 firecrawl-mcp
在命令行中執行全域 npm 安裝：
```powershell
npm install -g firecrawl-mcp
```

### 2. 獲取或填寫 API Key
此服務需要 Firecrawl 平台的 API 金鑰：
* 預設金鑰已封裝在您的局部還原檔中，或是您可以登入 [Firecrawl](https://firecrawl.dev) 申請專屬的 `FIRECRAWL_API_KEY`。

### 3. 註冊局部 MCP 伺服器
請在您的 `C:\Users\<您的用戶名>\.gemini\antigravity\mcp_config.json` 設定檔的 `mcpServers` 底下填寫以下內容：

```json
"firecrawl-mcp": {
  "command": "node",
  "args": [
    "C:\\Users\\<您的用戶名>\\AppData\\Roaming\\npm\\node_modules\\firecrawl-mcp\\dist\\index.js"
  ],
  "env": {
    "FIRECRAWL_API_KEY": "fc-d511444e155846638561b5c335ebcb81"
  }
}
```

> [!IMPORTANT]
> 請將上述 JSON 中的 `<您的用戶名>` 替換為新 PC 的實際 Windows 使用者名稱。
