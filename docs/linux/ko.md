应知应会

# 重点 #


3、	了解Linux系统产生、创始人（之父）、特点、版本；


Linus Torvalds, 开源免费, lsb_release -a;

重点掌握系统的组成、功能及作用。

```
kernel - 操作系统的核心，具有很多最基本功能，如虚拟内存、多任务、共享库
shell - 提供了用户与内核进行交互操作的一种接口
file system - 提供文件存放在磁盘等存储设备上的组织方法
application - 应用程序的程序集，如文本编辑器、编程语言、XWindow、数据库
```

7、掌握shell字符界面：SSH端口（22）；普通用户和超级用户默认的提示符（$、#），PS1、PS2变量设置方法及作用，命令补齐键（Tab）；多个命令分隔符（；）等


```

```


11、理解文件系统的概念、重要性（一切皆文件）。


重点掌握Linux文件系统建立和使用的步骤（分区fdisk、格式化分区mkfs、挂载mount）。

```sh
硬盘分区 - fdisk -l (查看系统上的硬盘, 找到需要分区的硬盘); fdisk <硬盘> (新建分区, 设置分区类型, 保存分区)
格式化分区 - mkfs -t <文件系统类型, 如ext3> <设备, 如/dev/sd5>
挂载 - mount <设备> <目录>
```

了解umount命令的使用方法，自动加载文件（/etc/fstab）的作用及配置方法。


14、掌握linux文件的类型（-/d/l/b/等）、属性（r、w、x）；10位文件权限的含义和内容；


重点掌握ls -l查询出的文件属性的每一个字段的含义。

```sh
第1列 - 10个字符, 第一个字母表示文件类型, 往后9个字符为用户权限
	- 第一组 - 文件所有者的用户的读, 写, 执行权限
	- 第二组 - 文件所有者的用户组的读, 写, 执行权限
	- 第三组 - 其他用户的读, 写, 执行权限
第2列 - 指向当前文件的链接数
第3列 - 文件所有者用户
第4列 - 文件所有者用户组
第5列 - 文件大小(字节)
第6列 - 最后修改时间
第7列 - 文件/目录名
```

15、掌握文件及文件夹相关的操作命令：cat（包括</<</>/>>的区别）、more(less)、head（tail）、echo（双引号、单引号的区别）、ls、pwd、cd（.，..，~）、touch、rm(-r)、mkdir(rmdir)、cp(-rf)、mv、tar(cvzfx)，包括命令使用场景、常用选项等

16掌握权限管理命令：chgrp、chown、chmod（符号模式、绝对模式），包括命令使用场景、常用选项（-R）等。

17、掌握find、grep命令的使用场景、常用参数、会使用简单的正则表达式和通配符。

18、掌握标准输入、输出概念，输入重定向（<,<<）、输出重定向（>,>>）

19、重点掌握管道（|）的概念、作用以及使用方法，以及与定向符的异同点。

```sh
管道 - 是命令之间协同工作的一种机制, 通过`|`分隔的多个命令中, `|`左侧命令的输出结果作为`|`右侧命令的输入
重定向符号 - 是命令与文件交换数据的一种机制
	- `>`, `>>`, `2>`, `2>>` 用于将命令的标准输出或标准错误 输出到文件
	- `<`, `<<` 用于将文件输入到命令中
异同
	- 相同点 - 都有改变数据输入输出的作用
	- 不同点 - 管道是将命令与文件连接起来, 而定向符是将命令与命令连接起来
```

20、了解链接的两种方式及区别。

21、重点掌握用户的概念、分类及特点，了解用户组的。

```sh
用户 - 权限的集合
	- 管理员用户(root) - 拥有所有权限, uid = 0 
	- 系统用户 - 保证整个系统正常运行，没有密码，系统运行时自动调用，uid = 1~499
	- 普通用户 - 权限受限, uid = 500~60000
用户组 - 用户的容器
	- 系统组 - 存放系统用户
	- 私有组 - 创建普通用户时自动创建的同名组 (组内仅有一个用户)
	- 普通用户组 - 存放普通用户 (组内可包含多个用户)
```

22、掌握用户和用户组相关文件(4个文件），管理命令（useradd（-s/-d/-m/-g）、passwd、usermod、userdel(-r)、groupadd、groupmod、groupdel、gpasswd）的使用场景、格式、常用选项等

28、掌握vi编辑器三种工作模式（命令行模式、输入模式、末行模式）以及模式之间切换的方法；掌握三种模式下常用的操作。

29、重点掌握shell脚本的基本格式，执行方式（三种）、脚本变量（系统（位置参数）变量、环境变量以及自定义变量）。

```
shell基本格式 - #!/bin/bash开头，脚本有可执行权限，文件格式为 .sh
shell执行方式 - sh解析器, bash解释器, 仅路径执行方式
shell脚本变量
	- 环境变量 - 可用export定义; 可通过env查看所有环境变量
	- 系统变量(位置参数+预定义变量) - 执行shell脚本时为程序提供的操作参数 (如：$n, $0, $*, $@, $#, $$, $?)
	- 自定义变量 - 
(set可查看所有shell变量)
```

30、掌握shell脚本的编程步骤，会写简单的shell脚本：参数的输入及判断、输出echo，运算符（数值、文件、字符串比较），算数运算符，特殊字符，控制语句（test、if、while、for）。


# 非重点 #

1、	了解虚拟机的含义、功能
2、	了解vmware workstation创建Ubuntu虚拟机的步骤，了解常见分区要求、四种网络类型
5、了解Ubuntu Linux默认的图形界面、默认的应用及功能。
6、了解ubuntu图形界面、字符界面的优缺点；

8、了解常用命令date、who、alias，history的功能、使用场景和使用方法
9、了解软件更新、安装的命令（apt-get、dpkg、yum、rpm）的使用场景、区别和用法
10、了解字符界面下关机和重启的命令shutdown -h/-r/-c，halt，reboot，poweroff和shutdown的区别。

12、了解Linux常见的文件系统格式、特点；当前主流的、默认的文件系统格式。
13、了解Linux下文件与目录的结构，了解常见的/etc、/dev、/home、/lib等等目录的功能
23、了解su、sudo命令的作用和使用方法
24、了解ubuntu下硬盘的分区和命名方式，主分区、扩展分区、逻辑分区；
26、了解进程管理的常用命令：ps（静态）、top（动态）、kill（杀）

