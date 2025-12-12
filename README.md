# 头像生成器 Avatar Generator

一个基于 React + TypeScript + Vite 构建的现代化头像生成器，使用 [boring-avatars](https://github.com/boringdesigners/boring-avatars) 库生成精美的抽象头像。

## ✨ 功能特性

- 🎨 **多种风格**：支持 Marble、Beam、Pixel、Sunset、Ring、Bauhaus 等多种风格
- 🎯 **实时预览**：输入文字即时生成头像预览
- ⚙️ **自定义选项**：
  - 自定义名称/文字
  - 选择头像风格
  - 调整尺寸（24-160px）
  - 方形/圆形切换
  - 自定义调色板
- 💾 **多格式下载**：支持 SVG 和 PNG 格式下载
- 📱 **响应式设计**：完美适配桌面端和移动端

## 🚀 快速开始

### 安装依赖

```bash
npm install
```

### 开发模式

```bash
npm run dev
```

### 构建生产版本

```bash
npm run build
```

### 预览生产构建

```bash
npm run preview
```

## 📦 技术栈

- **React 19** - UI 框架
- **TypeScript** - 类型安全
- **Vite** - 构建工具
- **boring-avatars** - 头像生成库

## 🌐 在线演示

访问 [GitHub Pages](https://your-username.github.io/avatar-generator) 查看在线演示

## 🚀 部署

### 快速部署到 GitHub Pages

1. **创建 GitHub 仓库**
   ```bash
   # 在 GitHub 上创建新仓库（例如：avatar-generator）
   ```

2. **更新配置**
   - 编辑 `vite.config.ts`，将 `base` 路径改为你的仓库名称：
     ```typescript
     base: process.env.NODE_ENV === 'production' ? '/你的仓库名/' : '/',
     ```
   - 编辑 `package.json`，更新 `homepage` 字段

3. **推送代码**
   ```bash
   git remote add origin https://github.com/你的用户名/你的仓库名.git
   git branch -M main
   git push -u origin main
   ```

4. **启用 GitHub Pages**
   - 进入仓库 Settings > Pages
   - Source 选择 **GitHub Actions**
   - 保存后会自动部署

### 其他部署方式

查看 [DEPLOY.md](./DEPLOY.md) 了解详细的部署指南，包括：
- GitHub Pages（自动部署）
- Vercel
- Netlify
- 其他静态托管服务

## 📄 许可证

MIT License
