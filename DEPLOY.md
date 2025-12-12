# 部署指南

本项目支持多种部署方式，推荐使用 GitHub Pages（免费且自动部署）。

## 方式一：GitHub Pages（推荐）

### 1. 创建 GitHub 仓库

1. 访问 [GitHub](https://github.com/new) 创建新仓库
2. 仓库名称建议：`avatar-generator`（或你喜欢的名称）
3. 选择 Public（公开）或 Private（私有）
4. **不要**初始化 README、.gitignore 或 license（我们已经有了）

### 2. 更新配置

在推送代码前，需要更新 `vite.config.ts` 中的 `base` 路径：

```typescript
// vite.config.ts
base: process.env.NODE_ENV === 'production' ? '/你的仓库名称/' : '/',
```

例如，如果仓库名是 `avatar-generator`，则改为：
```typescript
base: process.env.NODE_ENV === 'production' ? '/avatar-generator/' : '/',
```

同时更新 `package.json` 中的 `homepage`：
```json
"homepage": "https://你的GitHub用户名.github.io/你的仓库名称"
```

### 3. 推送代码到 GitHub

```bash
# 添加远程仓库（替换为你的仓库地址）
git remote add origin https://github.com/你的用户名/你的仓库名.git

# 重命名分支为 main（如果当前是 master）
git branch -M main

# 推送代码
git push -u origin main
```

### 4. 启用 GitHub Pages

1. 进入仓库的 **Settings**（设置）
2. 在左侧菜单找到 **Pages**
3. 在 **Source** 部分：
   - 选择 **GitHub Actions**（推荐，使用我们配置的自动部署）
   - 或者选择 **Deploy from a branch**，选择 `gh-pages` 分支和 `/root` 目录
4. 保存设置

### 5. 等待部署完成

- 如果使用 GitHub Actions，推送代码后会自动触发部署
- 查看 Actions 标签页可以看到部署进度
- 部署完成后，访问 `https://你的用户名.github.io/你的仓库名` 即可看到网站

## 方式二：Vercel（推荐，更简单）

### 1. 推送代码到 GitHub

按照方式一的步骤 1-3 推送代码到 GitHub

### 2. 部署到 Vercel

1. 访问 [Vercel](https://vercel.com)
2. 使用 GitHub 账号登录
3. 点击 **Add New Project**
4. 导入你的 GitHub 仓库
5. 配置：
   - **Framework Preset**: Vite
   - **Root Directory**: `avatar-demo`（如果项目在子目录）
   - **Build Command**: `npm run build`
   - **Output Directory**: `dist`
6. 点击 **Deploy**

### 3. 更新配置（可选）

如果使用 Vercel，可以移除 `vite.config.ts` 中的 `base` 配置，或设置为 `/`：

```typescript
base: '/',
```

## 方式三：Netlify

### 1. 推送代码到 GitHub

按照方式一的步骤 1-3 推送代码到 GitHub

### 2. 部署到 Netlify

1. 访问 [Netlify](https://www.netlify.com)
2. 使用 GitHub 账号登录
3. 点击 **Add new site** > **Import an existing project**
4. 选择你的 GitHub 仓库
5. 配置：
   - **Base directory**: `avatar-demo`（如果项目在子目录）
   - **Build command**: `npm run build`
   - **Publish directory**: `dist`
6. 点击 **Deploy site**

### 3. 更新配置

如果使用 Netlify，可以移除 `vite.config.ts` 中的 `base` 配置：

```typescript
base: '/',
```

## 方式四：手动部署

### 1. 构建项目

```bash
npm run build
```

### 2. 部署 dist 目录

将 `dist` 目录中的文件上传到任何静态网站托管服务：
- GitHub Pages
- Netlify
- Vercel
- Cloudflare Pages
- 或其他静态托管服务

## 常见问题

### GitHub Pages 显示 404

- 检查 `vite.config.ts` 中的 `base` 路径是否正确
- 确保仓库名称与配置中的路径一致
- 检查 GitHub Pages 设置是否正确

### 资源加载失败

- 确保 `base` 路径配置正确
- 清除浏览器缓存
- 检查构建输出是否正确

### 自动部署不工作

- 检查 GitHub Actions 是否启用
- 查看 Actions 标签页的错误信息
- 确保 `.github/workflows/deploy.yml` 文件存在

## 更新部署

每次推送代码到 `main` 分支后，GitHub Actions 会自动重新部署（如果使用 GitHub Pages + Actions）。

对于其他平台，通常也会自动检测并重新部署。

