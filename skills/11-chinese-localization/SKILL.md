---
name: antigravity-chinese-localization
description: 離線一鍵漢化與還原 Antigravity 桌面端，提供 Web 漢化管理面板。說「漢化主程式」「中文界面漢化」「還原英文原版」時載入。
---

# 離線一鍵漢化與還原管理面板 (Offline Chinese Localization)

這個技能已完整整合進您的專屬懶人包倉庫中，為您提供最安全的離線「一鍵中文漢化」與「一鍵還原官方英文原版」的功能，並配有精美的本機網頁控制台面板。

---

## 📂 模組檔案說明

本模組的所有核心檔案均已整合於您的倉庫目錄下：
* `skills/11-chinese-localization/localize.js` — 漢化與還原的核心 Node.js 服務腳本。
* `skills/11-chinese-localization/index.html` — 本地漢化管理網頁控制台（提供可視化按鈕）。
* `skills/11-chinese-localization/双击运行汉化.bat` — 雙擊即可一鍵啟動服務的 Windows 批處理檔案。

---

## 🚀 漢化與還原使用說明

### 第一步：啟動本機漢化管理服務
1. 進入您的懶人包目錄底下的 `skills\11-chinese-localization\`。
2. 雙擊執行 **`双击运行汉化.bat`**。
3. 系統將在背景啟動 Node.js 服務，並**自動在您的預設瀏覽器中開啟控制台面板**：
   👉 **`http://localhost:3388`**

### 第二步：在網頁面板中進行操作
開啟網頁後，您將看到以下直觀的操作選項：

* **一鍵漢化 (Localize App)**：
  * 自動檢測並安全關閉運行中的 Antigravity 進程。
  * 自動為您現有的 `app.asar` 建立名為 `app.asar.bak` 的官方原始安全備份。
  * 自動解包並注入高精度中文 UI DOM 翻譯引擎，完成重包與部署。
  * 漢化完成後，會提供「啟動程式」按鈕。

* **一鍵還原官方英文 (Restore English)**：
  * 當程式有新版本需要升級，或者您想恢復官方原版時，在網頁上點擊「還原英文」即可。
  * 它會自動將 `app.asar.bak` 覆蓋回 `app.asar`，軟體立即恢復原版狀態，100% 安全無殘留。

---

## 🛡️ 安全保護與升級防護
1. **安全備份**：本工具在執行任何修改前，必定會先建立 `app.asar.bak` 原始備份，確保任何時候都可以 100% 秒速還原。
2. **升級相容**：當 Antigravity 推出官方更新並覆蓋 `app.asar` 時，漢化會被暫時重置為英文。此時您只需再次雙擊 `双击运行汉化.bat`，即可一鍵為最新版本注入漢化，實現無縫相容！
