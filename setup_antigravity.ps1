# Antigravity 全新 PC 一鍵還原與環境部署指令檔
# 適用系統: Windows 10 / Windows 11
# 語系: 繁體中文 / 簡體中文

$ErrorActionPreference = "Stop"

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "   Antigravity AI 助理全新 PC 部署工具   " -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "此指令檔將自動為您在新電腦上安裝與配置所有相依環境、MCP 服務及設定檔。" -ForegroundColor Yellow
Write-Host "新電腦使用者目錄: $env:USERPROFILE" -ForegroundColor Gray
Write-Host "=========================================" -ForegroundColor Cyan

# 1. 偵測與安裝系統基礎軟體 (Git, Node.js, Python)
function Check-And-Install-Winget {
    param (
        [string]$Name,
        [string]$CommandCheck,
        [string]$WingetId
    )
    
    $installed = $false
    try {
        Invoke-Expression "$CommandCheck" | Out-Null
        Write-Host "[✔] $Name 已安裝！" -ForegroundColor Green
        $installed = $true
    } catch {
        Write-Host "[x] 偵測不到 $Name，正嘗試透過 winget 自動為您安裝..." -ForegroundColor Yellow
    }

    if (-not $installed) {
        try {
            Write-Host "正在執行: winget install --id $WingetId --silent --accept-source-agreements --accept-package-agreements" -ForegroundColor Cyan
            Start-Process "winget" -ArgumentList "install --id $WingetId --silent --accept-source-agreements --accept-package-agreements" -Wait -NoNewWindow
            Write-Host "[✔] $Name 安裝成功，請重啟此 PowerShell 視窗以套用環境變數！" -ForegroundColor Green
        } catch {
            Write-Host "[!] 自動安裝 $Name 失敗，請稍後手動下載安裝 (ID: $WingetId)" -ForegroundColor Red
        }
    }
}

# 執行系統相依套件檢查與安裝
Write-Host "`n1. 正在檢查基礎開發工具套件..." -ForegroundColor Cyan
Check-And-Install-Winget "Git" "git --version" "Git.Git"
Check-And-Install-Winget "Node.js" "node --version" "OpenJS.NodeJS.LTS"
Check-And-Install-Winget "Python" "python --version" "Python.Python.3.11"
Check-And-Install-Winget "GitHub CLI" "gh --version" "GitHub.cli"

# 2. 建立目錄結構
Write-Host "`n2. 正在建立 Antigravity 與 Gemini 設定目錄..." -ForegroundColor Cyan
$GeminiPath = Join-Path $env:USERPROFILE ".gemini\antigravity"
$GeminiScratch = Join-Path $GeminiPath "scratch"
$GeminiBin = Join-Path $GeminiPath "bin"
$AntigravityGlobalPath = Join-Path $env:USERPROFILE ".antigravity"

$PathsToCreate = @($GeminiScratch, $GeminiBin, $AntigravityGlobalPath)
foreach ($Path in $PathsToCreate) {
    if (-not (Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
        Write-Host "已建立目錄: $Path" -ForegroundColor Green
    } else {
        Write-Host "目錄已存在: $Path" -ForegroundColor Gray
    }
}

# 3. 寫入全域設定檔 .antigravity\mcp.json
Write-Host "`n3. 正在寫入全域 MCP 設定檔 (mcp.json)..." -ForegroundColor Cyan
$McpJsonContent = @"
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
"@
$McpJsonPath = Join-Path $AntigravityGlobalPath "mcp.json"
Set-Content -Path $McpJsonPath -Value $McpJsonContent -Encoding utf8
Write-Host "[✔] 已寫入: $McpJsonPath" -ForegroundColor Green

# 寫入全域 argv.json
$ArgvJsonContent = @"
{
  "enable-crash-reporter": true,
  "locale": "zh-cn"
}
"@
$ArgvJsonPath = Join-Path $AntigravityGlobalPath "argv.json"
Set-Content -Path $ArgvJsonPath -Value $ArgvJsonContent -Encoding utf8
Write-Host "[✔] 已寫入: $ArgvJsonPath" -ForegroundColor Green

# 4. 寫入局部設定檔 .gemini\antigravity\mcp_config.json (自動適配新電腦使用者目錄)
Write-Host "`n4. 正在寫入局部 mcp_config.json..." -ForegroundColor Cyan

# 處理雙斜線路徑以適應 JSON 格式
$EscapedUserProfile = $env:USERPROFILE -replace '\\', '\\\\'
$McpConfigContent = @"
{
  "mcpServers": {
    "notebooklm": {
      "command": "notebooklm-mcp",
      "args": []
    },
    "wps-office": {
      "command": "node",
      "args": [
        "${EscapedUserProfile}\\\\.gemini\\\\antigravity\\\\scratch\\\\wps-skills\\\\wps-office-mcp\\\\dist\\\\index.js"
      ]
    },
    "firecrawl-mcp": {
      "command": "node",
      "args": [
        "${EscapedUserProfile}\\\\AppData\\\\Roaming\\\\npm\\\\node_modules\\\\firecrawl-mcp\\\\dist\\\\index.js"
      ],
      "env": {
        "FIRECRAWL_API_KEY": "fc-d511444e155846638561b5c335ebcb81"
      }
    }
  }
}
"@
$McpConfigPath = Join-Path $GeminiPath "mcp_config.json"
Set-Content -Path $McpConfigPath -Value $McpConfigContent -Encoding utf8
Write-Host "[✔] 已寫入並自動適配路徑: $McpConfigPath" -ForegroundColor Green

# 寫入 antigravity_state.pbtxt (避免重複引導)
$StatePbContent = @"
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
"@
$StatePbPath = Join-Path $GeminiPath "antigravity_state.pbtxt"
Set-Content -Path $StatePbPath -Value $StatePbContent -Encoding utf8
Write-Host "[✔] 已寫入狀態檔以跳過首次導覽: $StatePbPath" -ForegroundColor Green

# 5. 下載與部署 WPS 輔助擴充 (wps-skills)
Write-Host "`n5. 正在下載與編譯 WPS Office MCP 服務..." -ForegroundColor Cyan
$WpsSkillsPath = Join-Path $GeminiScratch "wps-skills"

if (Test-Path $WpsSkillsPath) {
    Write-Host "WPS skills 目錄已存在，正在拉取最新代碼..." -ForegroundColor Gray
    Start-Process "git" -ArgumentList "-C `"$WpsSkillsPath`" pull" -Wait -NoNewWindow
} else {
    Write-Host "正在克隆 wps-skills 儲存庫..." -ForegroundColor Cyan
    Start-Process "git" -ArgumentList "clone https://github.com/lc2panda/wps-skills.git `"$WpsSkillsPath`"" -Wait -NoNewWindow
}

$WpsMcpPath = Join-Path $WpsSkillsPath "wps-office-mcp"
if (Test-Path $WpsMcpPath) {
    Write-Host "進入 wps-office-mcp 安裝依賴並編譯..." -ForegroundColor Cyan
    # 使用 cmd.exe 執行 npm 以免腳本中斷
    Start-Process "cmd.exe" -ArgumentList "/c cd /d `"$WpsMcpPath`" && npm install && npm run build" -Wait -NoNewWindow
    Write-Host "[✔] WPS Office MCP 服務安裝與編譯成功！" -ForegroundColor Green
} else {
    Write-Host "[!] 找不到 wps-office-mcp 目錄，請檢查 GitHub 儲存庫下載是否完整。" -ForegroundColor Red
}

# 6. 安裝 Python 和 NPM 全域 MCP 依賴
Write-Host "`n6. 正在安裝 Python 和 Node 全域 MCP 服務..." -ForegroundColor Cyan

# 安裝 firecrawl-mcp
Write-Host "正在安裝 Node 全域套件 firecrawl-mcp..." -ForegroundColor Cyan
Start-Process "cmd.exe" -ArgumentList "/c npm install -g firecrawl-mcp" -Wait -NoNewWindow
Write-Host "[✔] firecrawl-mcp 安裝完成。" -ForegroundColor Green

# 安裝 notebooklm-mcp-cli 及其相依
Write-Host "正在透過 pip 安裝 notebooklm-mcp-cli 及 notebooklm-mcp..." -ForegroundColor Cyan
Start-Process "cmd.exe" -ArgumentList "/c pip install notebooklm-mcp-cli notebooklm-mcp" -Wait -NoNewWindow
Write-Host "[✔] NotebookLM MCP CLI 安裝完成。" -ForegroundColor Green

Write-Host "`n=========================================" -ForegroundColor Cyan
Write-Host "   環境還原與自動配置成功完成！        " -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "【後續手動步驟，請在瀏覽器登入授權各項服務】:" -ForegroundColor Yellow
Write-Host "1. 登入 GitHub CLI 授權: " -ForegroundColor White
Write-Host "   gh auth login --web --git-protocol https" -ForegroundColor Cyan
Write-Host "2. 登入 NotebookLM 授權: " -ForegroundColor White
Write-Host "   nlm login" -ForegroundColor Cyan
Write-Host "3. 登入 Firebase 授權: " -ForegroundColor White
Write-Host "   npx.cmd -y firebase-tools@latest login" -ForegroundColor Cyan
Write-Host "4. 請將原本電腦中的 Antigravity 應用程式安裝包 (或 AppData\Local\Programs\antigravity 資料夾) 複製到新電腦並啟動。" -ForegroundColor Yellow
Write-Host "如有任何疑問，請隨時重啟 Antigravity 並向我發問！" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
