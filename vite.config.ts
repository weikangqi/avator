import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  // 如果部署到 GitHub Pages，请将 '/avatar-generator/' 改为你的仓库名称
  // 例如：如果仓库名是 'my-avatar-generator'，则改为 '/my-avatar-generator/'
  base: process.env.NODE_ENV === 'production' ? '/avatar-generator/' : '/',
})
