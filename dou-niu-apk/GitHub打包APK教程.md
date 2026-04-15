# GitHub Actions 免费打包 APK 教程

> 完全免费，无需安装任何软件，用 GitHub 云端服务器帮你编译 APK

---

## 前提条件

1. 有一个 [GitHub](https://github.com) 账号（没有的话去注册一个）
2. 项目文件在 `dou-niu-apk` 文件夹中（已生成好，包含 `.github/workflows/build-apk.yml`）

---

## 第一步：在 GitHub 创建仓库

1. 打开 https://github.com/new
2. 填写信息：
   - **Repository name**：`dou-niu-game`（随便取）
   - **Description**：斗牛H5小游戏（选填）
   - **Public** 或 **Private** 都可以（Private 仓库每月 2000 分钟免费额度，足够了）
3. **不要勾选** "Add a README file"（保持空仓库）
4. 点击 **Create repository**

---

## 第二步：上传项目文件

### 方式 A：网页上传（最简单，文件少的情况推荐）

1. 在刚创建的仓库页面，点击 **uploading an existing file** 链接
2. 把电脑上的 `dou-niu-apk` 文件夹里**所有文件和文件夹**拖进去
   - 关键文件结构必须是：
     ```
     .github/workflows/build-apk.yml   ← 这个必须要有！
     app/src/main/AndroidManifest.xml
     app/src/main/java/com/douniu/game/MainActivity.java
     app/build.gradle
     build.gradle
     settings.gradle
     gradle/wrapper/gradle-wrapper.properties
     gradlew
     gradlew.bat
     gradle.properties
     app/proguard-rules.pro
     app/src/main/res/...（所有资源文件）
     ```
   - ⚠️ 注意 `.github` 文件夹是隐藏文件夹，确保它被上传了
3. 点击 **Commit changes**

### 方式 B：用 Git 命令上传（如果熟悉 Git）

```bash
# 进入 dou-niu-apk 目录
cd dou-niu-apk

# 初始化 Git
git init
git add -A
git commit -m "斗牛游戏 Android 工程"

# 关联远程仓库（替换成你的用户名）
git remote add origin https://github.com/你的用户名/dou-niu-game.git
git branch -M main
git push -u origin main
```

---

## 第三步：等待自动打包

上传代码后，GitHub 会**自动触发**打包流程：

1. 打开你的仓库页面
2. 点击顶部的 **Actions** 标签
3. 你会看到一个名为 **"斗牛游戏 APK 自动打包"** 的工作流正在运行（黄色圆圈转圈）
4. 大约 **3~5 分钟**后变为绿色 ✅

### 如果没有自动触发？

点击左侧 **"斗牛游戏 APK 自动打包"** → 右侧 **"Run workflow"** → 选 `main` 分支 → 点击绿色 **"Run workflow"** 按钮

---

## 第四步：下载 APK

1. 在 Actions 页面，点击最新的那条**成功（绿色✅）**的运行记录
2. 滚动到页面底部，找到 **Artifacts** 区域
3. 点击 **"斗牛游戏-debug.apk"** 下载
4. 下载的是一个 `.zip` 文件，解压后得到 `app-debug.apk`

---

## 第五步：安装到手机

1. 把 `app-debug.apk` 发到手机（微信发文件、QQ传文件、USB数据线都可以）
2. 手机上点击 APK 文件
3. 如果提示"未知来源"，去 **设置 → 安全 → 允许安装未知应用** 开启权限
4. 点击安装，完成！

---

## 常见问题

### ❌ Actions 运行失败，红色 ❌

点击进去查看是哪一步报错：
- **Gradle 同步失败** → 检查 `build.gradle` 和 `settings.gradle` 是否上传正确
- **编译错误** → 检查 `MainActivity.java` 是否完整上传
- **找不到文件** → 确保所有文件夹结构完整，尤其是 `.github/workflows/build-apk.yml`

### ❌ Actions 标签页为空

说明 `.github/workflows/build-apk.yml` 文件没有被上传。回去检查一下，这个文件必须存在于仓库根目录。

### ❌ 构建成功但下载不到 APK

在 Actions 运行记录页面，等所有步骤都跑完后，往下滚找到 **Artifacts** 区域。Artifact 只有保留 **30天**，过期会被自动删除。

### 💡 如何更新服务器地址？

编辑 `app/src/main/java/com/douniu/game/MainActivity.java` 第 17 行：

```java
private static final String GAME_URL = "http://124.223.6.177:3002";
```

改成新地址，然后 push 到 GitHub，Actions 会自动重新打包。

### 💡 想打正式签名版？

正式版需要 Keystore 签名文件，流程更复杂。调试版（debug）足够日常测试使用。如果需要正式版，后续可以帮你配置签名流程。

---

## 免费额度说明

| 账号类型 | 每月免费额度 | 说明 |
|---------|------------|------|
| Public 仓库 | 无限 | 公开仓库完全免费 |
| Private 仓库 | 2000 分钟/月 | 一次打包约 3~5 分钟，够打 400+ 次 |

---

## 总结流程图

```
创建 GitHub 仓库
       ↓
上传 dou-niu-apk 全部文件
       ↓
GitHub 自动开始打包（Actions）
       ↓
等待 3~5 分钟
       ↓
下载 Artifacts 中的 APK
       ↓
发到手机 → 安装 → 开玩！
```
