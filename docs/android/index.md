
```title="android"
四大组件 - Activity, Service, BroadcastReceiver, ContentProvider
其他组件 - View, Intent, Fragment
存储 - 文件, SharePreference, SQLite
```

```title="BroadcastReceiver"
类型:
	- 标准广播 - 异步执行的广播, 广播发送后所有BroadcastReceiver几乎会在同一时刻收到广播通知
		- sendBroadcast(<Intent>)
	- 有序广播 - 同步执行的广播, BroadcastReceiver以一定的顺序接收到广播, 也可以截断广播
		- sendOrderedBroadcast(<Intent>, <权限>)
注册/接收方式:
	- 静态:
		- 实现BroadcastReceiver的onReceive(<Context>, <Intent>)方法
		- 在<application>的添加标签
			- <receiver android:name="<类名>">
				- <intent-filter>
					- <action android:name="<android...>">
	- 动态:
		- 实现BroadcastReceiver的onReceive(<Context>, <Intent>)方法
		- 注册和注销:
			- <IntentFilter>.addAction("<action>"), action不能自己起名？
			- registerReceiver(<BroadcastReceiver>, <IntentFilter>) - 注册
			- unregisterReceiver(<BroadcastReceiver>) - 注销
方法:
	- onReceive(<Context>, <Intent>) - 接收到广播时回调
```

```title="AsyncTask<Param, Progress, Result>"
// AsyncTask 支持 不定项参数(可变参数) 和 泛型

onPreExecute():
	- 后台任务开始执行之前调用, 在{==主线程==}执行, 用于进行一些界面上的初始化操作
doInBackground(<Param...>):
	- 在子线程中运行，我们应该在这里去处理所有的耗时任务
onProgressUpdate(<Progress...>):
	- 调用publishProgress(<Progress...>)后执行 (比如: 报告下载进度)
onPostExecute(<Result...>):
	- doInBackground(-)执行完后调用, 返回值作为该方法的参数, 在主线程中进行
```

```title="SharedPreferences"

```


```title="Service"

```