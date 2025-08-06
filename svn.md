# 版本控制工具svn

## 示例
假设你有一个项目位于 `/home/user/my_project`，想备份到SVN仓库 `/var/svn/my_repo`  
### 1.创建仓库目录
```svn
#创建仓库目录
mkdir -p /var/svn
#创建svn仓库
svnadmin create /var/svn/my_repo
```
### 2.导入项目到svn
```bash
cd /home/user
svn import my_project file:///var/svn/my_repo/trunk -m "初始导入项目"
```
### 3.检出工作副本
```bash
svn checkout file:///var/svn/my_repo/trunk my_project
```
### 4.日常备份操作
```bash
cd /home/user/my_project
#查看修改状态
svn status
#添加新文件
svn add new.txt
#删除文件
svn remove old.txt
#恢复未提交的修改
svn revert README.md
svn revert -R sim
#提交更改
svn commit -m "20250728 添加新功能"
```
### 5.创建备份标签
```bash
mkdir file:///var/svn/my_repo/tags
svn copy file:///var/svn/my_repo/trunk \
         file:///var/svn/my_repo/tags/backup-20250728 \
         -m "创建20250728备份点"
```
### 6.从备份恢复代码
```bash
svn checkout file:///var/svn/my_repo/tags/backup-20250728 my_project_restore
```
### 7.查看文件信息
```bash
svn info file:///var/svn/my_repo/trunk my_project
svn info file:///var/svn/my_repo/tags
```
### 8.版本回退
```bash
svn merge -r 8:7 README.me
```
### 9.查看历史信息
```bash
svn log
svn diff
```
### 10.分支
```bash
svn merge ../branches/my_branch/
svn status
svn commit -m "添加"
```

