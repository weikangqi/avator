# GitHub Pages 部署脚本
Write-Host "🚀 GitHub Pages 部署助手" -ForegroundColor Cyan
Write-Host "========================" -ForegroundColor Cyan
Write-Host ""

# 检查 Git 状态
Write-Host "📋 检查 Git 状态..." -ForegroundColor Yellow
$gitStatus = git status --porcelain
if ($gitStatus) {
    Write-Host "⚠️  检测到未提交的更改，请先提交：" -ForegroundColor Yellow
    Write-Host $gitStatus
    exit 1
}

# 检查是否已配置远程仓库
$remoteUrl = git remote get-url origin 2>$null
if ($remoteUrl) {
    Write-Host "✅ 已配置远程仓库: $remoteUrl" -ForegroundColor Green
    Write-Host ""
    $update = Read-Host "是否要更新配置？(y/n)"
    if ($update -ne "y") {
        Write-Host "跳过配置更新" -ForegroundColor Yellow
        exit 0
    }
} else {
    Write-Host "ℹ️  尚未配置远程仓库" -ForegroundColor Yellow
    Write-Host ""
}

# 获取用户输入
Write-Host "📝 请输入 GitHub 信息：" -ForegroundColor Yellow
$username = Read-Host "GitHub 用户名"
$repoName = Read-Host "仓库名称（例如：avatar-generator）"

if (-not $username -or -not $repoName) {
    Write-Host "❌ 用户名和仓库名不能为空" -ForegroundColor Red
    exit 1
}

$repoUrl = "https://github.com/$username/$repoName.git"
$homepageUrl = "https://$username.github.io/$repoName"

Write-Host ""
Write-Host "📦 配置信息：" -ForegroundColor Cyan
Write-Host "  仓库地址: $repoUrl"
Write-Host "  网站地址: $homepageUrl"
Write-Host ""

$confirm = Read-Host "确认配置？(y/n)"
if ($confirm -ne "y") {
    Write-Host "已取消" -ForegroundColor Yellow
    exit 0
}

# 更新 vite.config.ts
Write-Host ""
Write-Host "🔧 更新 vite.config.ts..." -ForegroundColor Yellow
$viteConfig = Get-Content "vite.config.ts" -Raw
$viteConfig = $viteConfig -replace "'/avatar-generator/'", "'/$repoName/'"
Set-Content "vite.config.ts" -Value $viteConfig -NoNewline
Write-Host "✅ vite.config.ts 已更新" -ForegroundColor Green

# 更新 package.json
Write-Host "🔧 更新 package.json..." -ForegroundColor Yellow
$packageJson = Get-Content "package.json" -Raw | ConvertFrom-Json
$packageJson.homepage = $homepageUrl
$packageJson | ConvertTo-Json -Depth 10 | Set-Content "package.json"
Write-Host "✅ package.json 已更新" -ForegroundColor Green

# 提交更改
Write-Host ""
Write-Host "💾 提交配置更改..." -ForegroundColor Yellow
git add vite.config.ts package.json
git commit -m "Configure for GitHub Pages deployment" 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ 配置已提交" -ForegroundColor Green
} else {
    Write-Host "⚠️  没有新的更改需要提交" -ForegroundColor Yellow
}

# 配置远程仓库
Write-Host ""
Write-Host "🔗 配置远程仓库..." -ForegroundColor Yellow
if ($remoteUrl) {
    git remote set-url origin $repoUrl
} else {
    git remote add origin $repoUrl
}
Write-Host "✅ 远程仓库已配置: $repoUrl" -ForegroundColor Green

# 重命名分支为 main
Write-Host ""
Write-Host "🌿 检查分支..." -ForegroundColor Yellow
$currentBranch = git branch --show-current
if ($currentBranch -ne "main") {
    git branch -M main
    Write-Host "✅ 分支已重命名为 main" -ForegroundColor Green
} else {
    Write-Host "✅ 当前分支已经是 main" -ForegroundColor Green
}

# 推送代码
Write-Host ""
Write-Host "📤 准备推送代码到 GitHub..." -ForegroundColor Yellow
Write-Host ""
Write-Host "⚠️  请确保已在 GitHub 上创建了仓库: $repoName" -ForegroundColor Yellow
Write-Host ""
$push = Read-Host "是否现在推送代码？(y/n)"
if ($push -eq "y") {
    Write-Host ""
    Write-Host "📤 推送代码..." -ForegroundColor Yellow
    git push -u origin main
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✅ 代码已成功推送！" -ForegroundColor Green
        Write-Host ""
        Write-Host "📋 下一步操作：" -ForegroundColor Cyan
        Write-Host "1. 访问 https://github.com/$username/$repoName/settings/pages"
        Write-Host "2. 在 Source 部分选择 'GitHub Actions'"
        Write-Host "3. 保存设置"
        Write-Host "4. 等待自动部署完成（查看 Actions 标签页）"
        Write-Host "5. 访问网站: $homepageUrl"
    } else {
        Write-Host ""
        Write-Host "❌ 推送失败，请检查：" -ForegroundColor Red
        Write-Host "   - 仓库是否已创建"
        Write-Host "   - 是否有推送权限"
        Write-Host "   - 网络连接是否正常"
    }
} else {
    Write-Host ""
    Write-Host "📋 手动推送命令：" -ForegroundColor Cyan
    Write-Host "   git push -u origin main"
    Write-Host ""
    Write-Host "📋 然后启用 GitHub Pages：" -ForegroundColor Cyan
    Write-Host "   访问 https://github.com/$username/$repoName/settings/pages"
    Write-Host "   选择 Source: GitHub Actions"
}

Write-Host ""
Write-Host "✨ 完成！" -ForegroundColor Green

