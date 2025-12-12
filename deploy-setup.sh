#!/bin/bash

# 头像生成器 - GitHub 部署设置脚本

echo "🚀 头像生成器部署设置"
echo "===================="
echo ""

# 检查是否已配置远程仓库
if git remote -v | grep -q "origin"; then
    echo "⚠️  远程仓库已配置"
    git remote -v
    echo ""
    read -p "是否要更新远程仓库地址？(y/n) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        read -p "请输入新的仓库地址: " repo_url
        git remote set-url origin "$repo_url"
        echo "✅ 远程仓库地址已更新"
    fi
else
    echo "📝 请先创建 GitHub 仓库，然后运行以下命令："
    echo ""
    echo "git remote add origin https://github.com/你的用户名/你的仓库名.git"
    echo "git branch -M main"
    echo "git push -u origin main"
    echo ""
fi

echo ""
echo "📋 部署步骤："
echo "1. 在 GitHub 上创建新仓库"
echo "2. 更新 vite.config.ts 中的 base 路径（改为你的仓库名称）"
echo "3. 更新 package.json 中的 homepage 字段"
echo "4. 运行上面的 git 命令推送代码"
echo "5. 在仓库 Settings > Pages 中启用 GitHub Actions"
echo ""
echo "📖 详细说明请查看 DEPLOY.md"

