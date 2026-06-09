# Antigravity 環境強制清理與重置指令檔
# 適用系統: Windows 10 / Windows 11
# 警告：此操作將刪除所有 Antigravity 相關的設定、自定義技能與 MCP 快取資料。

$ErrorActionPreference = "Stop"

Write-Host "=========================================" -ForegroundColor Red
Write-Host "   Antigravity 系統環境強制清理與重置工具   " -ForegroundColor Red
Write-Host "=========================================" -ForegroundColor Red
Write-Host "此指令檔將為您執行以下操作：" -ForegroundColor Yellow
Write-Host "  1. 嘗試終止可能正在運行的 Node 或 Python MCP 服務" -ForegroundColor White
Write-Host "  2. 刪除 $env:USERPROFILE\.gemini 目錄" -ForegroundColor White
Write-Host "  3. 刪除 $env:USERPROFILE\.antigravity 目錄" -ForegroundColor White
Write-Host "=========================================" -ForegroundColor Red

$Confirmation = Read-Host "您確定要繼續嗎？這將刪除所有的 Antigravity 狀態與暫存資料 (Y/N)"
if ($Confirmation -notmatch "^[Yy]$") {
    Write-Host "已取消清理操作。" -ForegroundColor Green
    exit 0
}

Write-Host "`n開始清理程序..." -ForegroundColor Cyan

# 1. 終止進程 (可選)
Write-Host "正在嘗試終止相關 MCP 服務 (忽略錯誤)..." -ForegroundColor Gray
# 不強制殺死所有 node/python，避免影響使用者的其他開發任務
# 若有需要，可以讓使用者手動關閉 Antigravity 桌面端
Write-Host "請確保您已關閉 Antigravity 應用程式。" -ForegroundColor Yellow

# 2. 刪除 .gemini 目錄
$GeminiPath = Join-Path $env:USERPROFILE ".gemini"
if (Test-Path $GeminiPath) {
    try {
        Remove-Item -Path $GeminiPath -Recurse -Force -ErrorAction Stop
        Write-Host "[✔] 已成功刪除 $GeminiPath" -ForegroundColor Green
    } catch {
        Write-Host "[!] 刪除 $GeminiPath 失敗，可能有文件被佔用：$_" -ForegroundColor Red
    }
} else {
    Write-Host "[-] 找不到 $GeminiPath，跳過。" -ForegroundColor Gray
}

# 3. 刪除 .antigravity 目錄
$AntigravityGlobalPath = Join-Path $env:USERPROFILE ".antigravity"
if (Test-Path $AntigravityGlobalPath) {
    try {
        Remove-Item -Path $AntigravityGlobalPath -Recurse -Force -ErrorAction Stop
        Write-Host "[✔] 已成功刪除 $AntigravityGlobalPath" -ForegroundColor Green
    } catch {
        Write-Host "[!] 刪除 $AntigravityGlobalPath 失敗，可能有文件被佔用：$_" -ForegroundColor Red
    }
} else {
    Write-Host "[-] 找不到 $AntigravityGlobalPath，跳過。" -ForegroundColor Gray
}

Write-Host "`n=========================================" -ForegroundColor Cyan
Write-Host "   清理完成！                            " -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "您可以重新執行 setup_antigravity.ps1 以進行全新安裝部署。" -ForegroundColor Yellow
