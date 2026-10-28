# reladraw 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/reladraw/reladraw/blob/main/README.md
# 更新日期：2026-10-28
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }
if (-not (Get-Command node -ErrorAction SilentlyContinue)) { throw '需要先安装 Node.js' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

node -e "const a=+process.versions.node.split('.')[0]; if(a<18){console.error('需要 Node.js 18 或更高，当前 '+process.versions.node);process.exit(1)}"
npm install -g reladraw
if (-not (Get-Command reladraw -ErrorAction SilentlyContinue)) { throw '安装后没找到 reladraw，请检查 npm 全局 bin 是否在 PATH' }
Write-Host '安装完成：reladraw render diagram.reladraw -o diagram.svg'

Write-Host ''

Write-Host '安装完成：写一个 .reladraw 文件，运行 reladraw render diagram.reladraw -o diagram.svg'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/reladraw/reladraw/blob/main/README.md'
