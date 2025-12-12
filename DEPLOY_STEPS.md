# GitHub Pages 部署步骤

## 快速部署指南

### 步骤 1: 创建 GitHub 仓库

1. 访问 https://github.com/new
2. 仓库名称：输入你想要的名称（例如：`avatar-generator`）
3. 选择 **Public**（公开）
4. **不要**勾选任何初始化选项（README、.gitignore、license）
5. 点击 **Create repository**

### 步骤 2: 更新配置文件

在推送代码前，需要更新以下文件：

#### 更新 `vite.config.ts`

将第 9 行的 `/avatar-generator/` 改为你的实际仓库名称：

```typescript
base: process.env.NODE_ENV === 'production' ? '/你的仓库名/' : '/',
```

#### 更新 `package.json`

将第 6 行的 URL 改为你的实际地址：

```json
"homepage": "https://你的GitHub用户名.github.io/你的仓库名"
```

### 步骤 3: 推送代码到 GitHub

在项目目录运行以下命令（替换为你的实际信息）：

```bash
# 添加远程仓库
git remote add origin https://github.com/你的用户名/你的仓库名.git

# 重命名分支为 main
git branch -M main

# 推送代码
git push -u origin main
```

### 步骤 4: 启用 GitHub Pages

1. 进入你的 GitHub 仓库页面
2. 点击 **Settings**（设置）标签
3. 在左侧菜单找到 **Pages**
4. 在 **Source** 部分：
   - 选择 **GitHub Actions**（推荐）
   - 或者选择 **Deploy from a branch**，分支选择 `gh-pages`，目录选择 `/root`
5. 点击 **Save**（保存）

### 步骤 5: 等待自动部署

- 如果使用 **GitHub Actions**：
  - 推送代码后会自动触发部署
  - 点击仓库的 **Actions** 标签页查看部署进度
  - 部署完成后，访问 `https://你的用户名.github.io/你的仓库名`

- 如果使用 **Deploy from a branch**：
  - 需要手动运行 `npm run deploy` 创建 `gh-pages` 分支

### 步骤 6: 访问你的网站

部署完成后，访问：
```
https://你的用户名.github.io/你的仓库名
```

## 常见问题

### Q: 部署后显示 404？
A: 检查 `vite.config.ts` 中的 `base` 路径是否正确，必须与仓库名称一致。

### Q: 资源加载失败？
A: 确保 `base` 路径配置正确，清除浏览器缓存后重试。

### Q: GitHub Actions 部署失败？
A: 检查 Actions 标签页的错误信息，通常是配置问题。

### Q: 如何更新网站？
A: 每次推送代码到 `main` 分支，GitHub Actions 会自动重新部署。

## 示例

假设你的 GitHub 用户名是 `john`，仓库名是 `avatar-generator`：

1. **vite.config.ts**:
   ```typescript
   base: process.env.NODE_ENV === 'production' ? '/avatar-generator/' : '/',
   ```

2. **package.json**:
   ```json
   "homepage": "https://john.github.io/avatar-generator"
   ```

3. **远程仓库**:
   ```bash
   git remote add origin https://github.com/john/avatar-generator.git
   ```

4. **网站地址**:
   ```
   https://john.github.io/avatar-generator
   ```

