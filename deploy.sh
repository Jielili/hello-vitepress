#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

git add -A
git commit -m $1
git push

# 生成静态文件
pnpm run docs:build

# 进入生成的文件夹
cd docs/.vitepress/dist

git add -A
git commit -m $1

# 如果发布到 https://<USERNAME>.github.io/<REPO>
git push

cd -