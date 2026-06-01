---
name: antigravity-app-setup
description: 還原 Antigravity 主程式路徑、全域設定 (argv/mcp.json) 及簡體中文擴充。說「還原 Antigravity 設定」「安裝語言包」時載入。
---

# 還原 Antigravity 設定與本地外掛 (Plugins)

這個技能可以為使用者部署 Antigravity 本身的全域環境設定，包含中文語言擴充套件，並設定好開機跳過導覽，實現「開箱即用」。

## 部署步驟

### 1. 打包與複製主程式本體
從原本的舊電腦複製整個主程式安裝目錄：
* 原路徑：`C:\Users\<舊用戶名>\AppData\Local\Programs\antigravity`
* 複製到新電腦相同位置：`C:\Users\<新用戶名>\AppData\Local\Programs\antigravity`

> [!TIP]
> 複製完成後，可以在新電腦上右鍵點擊 `Antigravity.exe` -> **傳送到** -> **桌面快捷方式**，方便未來直接開啟。

### 2. 還原全域 argv.json 與全域 mcp.json 設定
在 `%USERPROFILE%\.antigravity\` 資料夾中：

* 建立全域設定檔 **`mcp.json`**：
  ```json
  {
    "mcpServers": {
      "notebooklm": {
        "command": "nlm",
        "args": ["mcp"],
        "disabled": false
      },
      "firebase": {
        "command": "npx.cmd",
        "args": ["-y", "firebase-tools@latest", "mcp"],
        "disabled": false
      }
    }
  }
  ```

* 建立啟動檔 **`argv.json`** (預設語系變更為中文):
  ```json
  {
    "enable-crash-reporter": true,
    "locale": "zh-cn"
  }
  ```

### 3. 還原簡體中文語言擴充套件 (Local Language Extension Plugin)
將以下目錄下的擴充資料夾從舊電腦複製到新電腦對應目錄：
* 目錄路徑：`C:\Users\<您的用戶名>\.antigravity\extensions\`
* 資料夾名稱：`ms-ceintl.vscode-language-pack-zh-hans-1.104.0-universal`
* 並在該目錄下寫入 `extensions.json` 聲明檔：
  ```json
  [{"identifier":{"id":"ms-ceintl.vscode-language-pack-zh-hans"},"version":"1.104.0","location":{"$mid":1,"fsPath":"c:\\Users\\<您的用戶名>\\.antigravity\\extensions\\ms-ceintl.vscode-language-pack-zh-hans-1.104.0-universal","_sep":1,"external":"file:///c%3A/Users/<您的用戶名>/.antigravity/extensions/ms-ceintl.vscode-language-pack-zh-hans-1.104.0-universal","path":"/c:/Users/<您的用戶名>/.antigravity/extensions/ms-ceintl.vscode-language-pack-zh-hans-1.104.0-universal","scheme":"file"},"relativeLocation":"ms-ceintl.vscode-language-pack-zh-hans-1.104.0-universal","metadata":{"isApplicationScoped":true}}]
  ```

### 4. 寫入狀態防首次重複引導 (Skip Onboarding Tour)
為避免重啟後助理重複顯示 onboarding 新手引導流程，請寫入以下檔案：
* 目錄路徑：`C:\Users\<您的用戶名>\.gemini\antigravity\`
* 檔案名稱：`antigravity_state.pbtxt`
* 檔案內容：
  ```text
  post_onboarding:  {
    completed_steps:  POST_ONBOARDING_STEP_TYPE_MANAGER_WELCOME
    completed_steps:  POST_ONBOARDING_STEP_TYPE_USAGE_MODE
    completed_steps:  POST_ONBOARDING_STEP_TYPE_AGENT_CONFIGURATION
    completed_steps:  POST_ONBOARDING_STEP_TYPE_ADD_WORKSPACE
  }
  seen_nuxs:  {
    uids:  27
    uids:  26
    uids:  24
    uids:  23
  }
  agent_onboarding_completed:  AGENT_ONBOARDING_STATE_COMPLETED
  last_selected_agent_model:  MODEL_PLACEHOLDER_M20
  migrate_convos_into_projects:  MIGRATION_STATUS_COMPLETED
  migrate_retroactive_projects:  RETROACTIVE_MIGRATION_STATUS_COMPLETED_UNNECESSARY
  ```
