puts "请确保github上已创建仓库"
print "请输入仓库名："
name = gets


system('git init')
system('git add .')
system('git commit -m "first commit"')
system("git remote add origin https://github.com/liangxiongsl/#{name}.git")
system('git branch -M main')
system('git push -u origin main')

system('mkdocs gh-deploy')
