# Antigravity 全新 PC 一鍵還原與環境部署指令檔
# 適用系統: Windows 10 / Windows 11
# 語系: 繁體中文 / 簡體中文

$ErrorActionPreference = "Stop"

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "   Antigravity AI 助理全新 PC 部署工具   " -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "此指令檔將自動為您在新電腦上安裝與配置所有相依環境、MCP 服務及設定檔。" -ForegroundColor Yellow
Write-Host "新電腦使用者目錄: `$env:USERPROFILE" -ForegroundColor Gray
Write-Host "=========================================" -ForegroundColor Cyan

# ---------------------------------------------------------
# 輔助函式：檢查與安裝 Winget 軟體
# ---------------------------------------------------------
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
            Write-Host "[✔] $Name 安裝指令執行完畢。" -ForegroundColor Green
        } catch {
            Write-Host "[!] 自動安裝 $Name 失敗，請稍後手動下載安裝 (ID: $WingetId)" -ForegroundColor Red
            throw "無法安裝必要組件 $Name"
        }
    }
}

# ---------------------------------------------------------
# 第一階段：基礎環境部署 (Git, Node.js, Python, gh-cli)
# ---------------------------------------------------------
Write-Host "`n=========================================" -ForegroundColor Magenta
Write-Host " 第一階段：安裝部署基礎開發環境" -ForegroundColor Magenta
Write-Host "=========================================" -ForegroundColor Magenta

Check-And-Install-Winget "Git" "git --version" "Git.Git"
Check-And-Install-Winget "Node.js" "node --version" "OpenJS.NodeJS.LTS"
Check-And-Install-Winget "Python" "python --version" "Python.Python.3.11"
Check-And-Install-Winget "GitHub CLI" "gh --version" "GitHub.cli"

Write-Host "`n正在重新加載環境變數 PATH..." -ForegroundColor Cyan
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

# 驗證第一階段
Write-Host "正在驗證第一階段環境..." -ForegroundColor Cyan
$Phase1Pass = $true
foreach ($cmd in @("git", "node", "python", "gh")) {
    try {
        Get-Command $cmd -ErrorAction Stop | Out-Null
        Write-Host "  [✔] $cmd 環境變數驗證成功。" -ForegroundColor Green
    } catch {
        Write-Host "  [!] 無法呼叫 $cmd ，可能需要重啟 PowerShell 或手動加入系統變數。" -ForegroundColor Red
        $Phase1Pass = $false
    }
}

if (-not $Phase1Pass) {
    Write-Host "`n[錯誤] 第一階段基礎環境安裝存在異常或環境變數未生效。請重啟 PowerShell 視窗後再試一次！" -ForegroundColor Red
    exit 1
} else {
    Write-Host "[✔] 第一階段完成！具備下一階段環境條件。" -ForegroundColor Green
}

# 建立相關目錄
Write-Host "`n正在建立 Antigravity 與 Gemini 設定目錄..." -ForegroundColor Cyan
$GeminiPath = Join-Path $env:USERPROFILE ".gemini\antigravity"
$GeminiScratch = Join-Path $GeminiPath "scratch"
$GeminiBin = Join-Path $GeminiPath "bin"
$AntigravityGlobalPath = Join-Path $env:USERPROFILE ".antigravity"

$PathsToCreate = @($GeminiScratch, $GeminiBin, $AntigravityGlobalPath)
foreach ($Path in $PathsToCreate) {
    if (-not (Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
    }
}

# ---------------------------------------------------------
# 第二階段：安裝各種 Skills
# ---------------------------------------------------------
Write-Host "`n=========================================" -ForegroundColor Magenta
Write-Host " 第二階段：部署自定義技能 (Skills)" -ForegroundColor Magenta
Write-Host "=========================================" -ForegroundColor Magenta

$GlobalSkillsPath = Join-Path $GeminiPath "skills"
if (-not (Test-Path $GlobalSkillsPath)) {
    New-Item -ItemType Directory -Path $GlobalSkillsPath -Force | Out-Null
}

$SourceFolders = @("skills", "mcps")
$Phase2Pass = $false
$SkillsFound = $false

foreach ($folder in $SourceFolders) {
    $RepoSkillsPath = Join-Path $PSScriptRoot $folder
    if (Test-Path $RepoSkillsPath) {
        $SkillDirs = Get-ChildItem -Path $RepoSkillsPath -Directory
        if ($SkillDirs.Count -gt 0) {
            $SkillsFound = $true
            foreach ($dir in $SkillDirs) {
                $SkillDirName = $dir.Name
                $CleanName = $SkillDirName -replace '^\d+-'
                $SrcSkillMd = Join-Path $dir.FullName "SKILL.md"
                $DestSkillMd = Join-Path $GlobalSkillsPath "$CleanName.md"
                
                if (Test-Path $SrcSkillMd) {
                    Copy-Item -Path $SrcSkillMd -Destination $DestSkillMd -Force
                    Write-Host "  已安裝技能描述: $CleanName.md" -ForegroundColor Green
                }
                
                $DestSkillFolder = Join-Path $GlobalSkillsPath "$CleanName-v1"
                Copy-Item -Path $dir.FullName -Destination $DestSkillFolder -Recurse -Force | Out-Null
            }
        }
    } else {
        Write-Host "  [提示] 未能在倉庫中找到 $folder 目錄。" -ForegroundColor Gray
    }
}

if ($SkillsFound) {
    $Phase2Pass = $true
} else {
    Write-Host "  [提示] 倉庫中沒有需要部署的技能。" -ForegroundColor Gray
    $Phase2Pass = $true
}

# 驗證第二階段
if (Test-Path $GlobalSkillsPath) {
    Write-Host "[✔] 第二階段完成！自定義技能已部署至: $GlobalSkillsPath" -ForegroundColor Green
}

# ---------------------------------------------------------
# 第三階段：安裝 MCP
# ---------------------------------------------------------
Write-Host "`n=========================================" -ForegroundColor Magenta
Write-Host " 第三階段：配置與安裝 MCP 服務" -ForegroundColor Magenta
Write-Host "=========================================" -ForegroundColor Magenta

# 1. 寫入全域設定檔 .antigravity\mcp.json (適用於某些系統元件)
Write-Host "正在寫入全域 MCP 設定檔 (mcp.json)..." -ForegroundColor Cyan
$McpGlobalConfig = @{
    mcpServers = @{
        "notebooklm" = @{
            command = "nlm"
            args = @("mcp")
            disabled = $false
        }
        "firebase" = @{
            command = "npx.cmd"
            args = @("-y", "firebase-tools@latest", "mcp")
            disabled = $false
        }
    }
}
$McpJsonPath = Join-Path $AntigravityGlobalPath "mcp.json"
$McpGlobalConfig | ConvertTo-Json -Depth 5 | Set-Content -Path $McpJsonPath -Encoding utf8
Write-Host "  已寫入: $McpJsonPath" -ForegroundColor Green

# 寫入全域 argv.json
$ArgvConfig = @{
    "enable-crash-reporter" = $true
    locale = "zh-cn"
}
$ArgvJsonPath = Join-Path $AntigravityGlobalPath "argv.json"
$ArgvConfig | ConvertTo-Json -Depth 5 | Set-Content -Path $ArgvJsonPath -Encoding utf8

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

# 2. 下載與編譯 WPS 擴充
Write-Host "`n正在下載與編譯 WPS Office MCP 服務..." -ForegroundColor Cyan
$WpsSkillsPath = Join-Path $GeminiScratch "wps-skills"
$WpsCompileSuccess = $false
try {
    if (Test-Path $WpsSkillsPath) {
        Write-Host "  WPS skills 目錄已存在，正在拉取最新代碼..." -ForegroundColor Gray
        $p = Start-Process "git" -ArgumentList "-C `"$WpsSkillsPath`" pull" -PassThru -Wait -NoNewWindow
    } else {
        Write-Host "  正在克隆 wps-skills 儲存庫..." -ForegroundColor Cyan
        $p = Start-Process "git" -ArgumentList "clone https://github.com/lc2panda/wps-skills.git `"$WpsSkillsPath`"" -PassThru -Wait -NoNewWindow
    }

    $WpsMcpPath = Join-Path $WpsSkillsPath "wps-office-mcp"
    if (Test-Path $WpsMcpPath) {
        Write-Host "  進入 wps-office-mcp 安裝依賴並編譯..." -ForegroundColor Cyan
        $p = Start-Process "cmd.exe" -ArgumentList "/c cd /d `"$WpsMcpPath`" && npm install && npm run build" -PassThru -Wait -NoNewWindow
        if ($p.ExitCode -eq 0) {
            Write-Host "  [✔] WPS Office MCP 編譯成功！" -ForegroundColor Green
            $WpsCompileSuccess = $true
        } else {
            Write-Host "  [!] WPS 編譯失敗。" -ForegroundColor Yellow
        }
    }
} catch {
    Write-Host "  [!] 配置 WPS Office MCP 發生例外錯誤：$_" -ForegroundColor Yellow
}

# 3. 安裝 Node 全域 MCP (firecrawl-mcp)
Write-Host "`n正在安裝 firecrawl-mcp..." -ForegroundColor Cyan
$FirecrawlSuccess = $false
try {
    $p = Start-Process "cmd.exe" -ArgumentList "/c npm install -g firecrawl-mcp" -PassThru -Wait -NoNewWindow
    if ($p.ExitCode -eq 0) {
        Write-Host "  [✔] firecrawl-mcp 安裝完成。" -ForegroundColor Green
        $FirecrawlSuccess = $true
    }
} catch { Write-Host "  [!] 安裝 firecrawl-mcp 發生異常。" -ForegroundColor Yellow }

# 4. 安裝 Python 全域 MCP (notebooklm-mcp)
Write-Host "`n正在安裝 NotebookLM MCP..." -ForegroundColor Cyan
$NotebookLmSuccess = $false
try {
    $p = Start-Process "cmd.exe" -ArgumentList "/c python -m pip install --upgrade pip && python -m pip install notebooklm-mcp-cli notebooklm-mcp" -PassThru -Wait -NoNewWindow
    if ($p.ExitCode -eq 0) {
        Write-Host "  [✔] NotebookLM MCP CLI 安裝完成。" -ForegroundColor Green
        $NotebookLmSuccess = $true
    }
} catch { Write-Host "  [!] 安裝 NotebookLM MCP 發生異常。" -ForegroundColor Yellow }

# 5. 寫入自定義 MCP 配置 (mcp_config.json)
Write-Host "`n正在寫入 Antigravity 自定義 MCP 註冊檔 (mcp_config.json)..." -ForegroundColor Cyan
$FirecrawlApiKey = Read-Host "請輸入您的 Firecrawl API Key (若無請直接按回車跳過)"
if ([string]::IsNullOrWhiteSpace($FirecrawlApiKey)) {
    $FirecrawlApiKey = ""
}

$McpConfig = @{
    mcpServers = @{
        "notebooklm" = @{
            command = "notebooklm-mcp"
            args = @()
        }
        "wps-office" = @{
            command = "node"
            args = @(
                "$env:USERPROFILE\.gemini\antigravity\scratch\wps-skills\wps-office-mcp\dist\index.js"
            )
        }
        "firecrawl-mcp" = @{
            command = "node"
            args = @(
                "$env:USERPROFILE\AppData\Roaming\npm\node_modules\firecrawl-mcp\dist\index.js"
            )
            env = @{
                FIRECRAWL_API_KEY = $FirecrawlApiKey
            }
        }
    }
}
$McpConfigPath = Join-Path $GeminiPath "mcp_config.json"
# 使用 ConvertTo-Json 確保所有路徑的反斜線被正確編碼，避免 UI 讀取異常
$McpConfig | ConvertTo-Json -Depth 5 | Set-Content -Path $McpConfigPath -Encoding utf8
Write-Host "  [✔] 已寫入並修復路徑格式: $McpConfigPath" -ForegroundColor Green

# 驗證第三階段
if ($WpsCompileSuccess -and $FirecrawlSuccess -and $NotebookLmSuccess -and (Test-Path $McpConfigPath)) {
    Write-Host "[✔] 第三階段完成！所有 MCP 服務配置無誤。" -ForegroundColor Green
} else {
    Write-Host "[!] 第三階段完成，但有部分服務未能順利編譯或下載，請參考上方日誌排除錯誤。" -ForegroundColor Yellow
}

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
Write-Host "如有任何疑問，請隨時重啟 Antigravity 並向我發问！" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
