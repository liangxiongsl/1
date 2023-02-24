
- Servlet -> GenericServlet -> HttpServlet
- (Xxx)ServletRequest, (Xxx)ServletResponse -> RequestDispatcher
- ServletConfig, ServletContext
- Filter, FilterConfig, FilterChain
- event, listener
- HttpSession; Cookie

|对象   |作用域 |参数   |属性|	获取
|:-:|:-:|:-:|:-:|:-:|
|ServletContext        |application    |init   |y|	getServletContext()|
|HttpSession        |session        |       |y|	`<request>.getSession()`|
|HttpServletRequest        |request        |请求   |y|	自然存在|
|HttpCookie	|浏览器缓存|	|	y|`<request>.getCookies()` / Cookie()|
|Servletconfig |app/servlet?       |init   |n|	getServletConfig()|
|FilterConfig	|app	|	init|	n|	Filter.init(-)的参数中|

## 1.Servlet, GenericServlet, HttpServlet ##

```title="Servlet 接口方法"
{==
init(<ServletConfig>)
service(<ServletRequest>, <ServletResponse>)
destroy()
==}

{==getServletConfig()==} ServletConfig
{==getServletInfo()==} String
```

```title="GenericServlet 方法"
// GenericServlet <- Servlet
service(<ServletRequest>, <ServletResponse>) - 抽象方法

init()
{==getServletContext()==} ServletContext
{==getInitParameter(<str>)==} String
getInitParameters() Enumeration
{==getServletName()==} String
log(<消息>[, <Throwable>])
```

```title="HttpServIet 方法"
// HttpServIet <= GenericServlet
service(<ServletRequest>, <ServletResponse>)
service(-, -)
{==doGet(-, -)==}
{==doPost(-, -)==}
doHead(-, -)
doOptions(-, -)
doPut(-, -)
doTrace(-, -)
doDelete(-, -)
getLastModified(-) long
// - 代表 <HttpServletRequest> 或 <HttpServletResponse>
```

可获得的信息:
	- servlet名&信息, {==config, context, 初始化参数==}, 打印日志, 上一次修改时间


## 2.ServletRequest, ServletResponse ##

```title="1.ServletRequest 接口方法"
{==getParameter(-)==} String
getParameterValues(-) String[]
getParameterNames() Enumeration
getContentLength() int
getContentType() String
getCharacterEncoding() String
{==getInputStream()==} ServletInputStream
getServerName() String - 抽象方法
getServerPort() int
{==getRequestDispatcher(<资源url>)==} RequestDispatcher

getSession([-]) - HttpSession
setAttribute(-, -)
getAttribute(-) Object
removeAttribute(-)
```

可获得的信息:
	- **request参数map**, 内容长度&**类型**, 字符集, **输入流**, 主机名&端口, **RequestDispatcher**
	- **HttpSession**, **set/get/remove属性**

```title="2.ServletResponse 接口方法"
sendRedirect(<str>) - 重定向
```

## 3.转发 ##

```title="1.RequestDispacher"
获取 RequestDispacher:
	- <ServletRequest>.getRequestDispatcher(<资源url>)
RequestDispacher 方法:
	- forward(-, -) - 保留request, 抛弃response; 可回溯; 运行在服务端
	- include(-, -) - 保留request&response; 可回溯; 运行在服务端
```

```title="2.sendRedirect(-)"
<ServletResponse>.sendRedirect(-):
	- 抛弃request&response？重新发送请求; 运行在客户端
```

## 4.ServIetConfig ##

```title="ServIetConfig"
获取:
	- <Servlet>.getServletConfig()
方法:
	- getInitParameter(-) String
	- getInitParameterNames() Enumeration
	- getServletName() String
	- getServletContext() ServletContext
配置:
	- servlet初始化参数map:
		- <servlet> -> <init-param> -> <param-name>, <param-value>
	
```

- 可获得的信息: **servlet初始化参数map**, servlet名, **ServletContext**

## 5.ServletContext ##

```title="ServletContext"
获取:
	- <GenericServlet>.getServletContext()
	- <Servlet>.getServletConfig().getServletContext()
方法:
	- getInitParameter(-) String
	- getInitParameterNames() Enumeration
	- setAttribute(-, -)
	- getAttribute(-) Object
	- removeAttribute(-)
配置:
	- Context初始化参数:
		- <context-param> -> <param-name>, <param-value>
```

- 可获得的信息: **context初始化参数map**, **set/get/remove属性**


## 6.session跟踪/管理 ##

### 1.Cookie ###

Cookie 理论上是一个 JavaBean

```title="Cookie"
获取:
	- Cookie(-, -) - 构造方法
方法:
	- setMaxAge(-) - 可用于销毁/注销cookie
	- name & value 的 getter/setter
相关方法:
	- <HttpServletResponse>.addCookie(<Cookie>)
	- <HttpServletRequest>.getCookies() Cookie[]
应用:
	- 获取客户端的cookie - <Request>.getCookies()
	- 发送cookie给客户端 - <response>.addCookie(new Cookie(<cookie名>, <cookie值>))
	- 删除客户端的cookie:
		Cookie ck=new Cookie("<Cookie名>", "");
		ck.setMaxAge(0);
		response.addCookie(ck);
作用域: 浏览器缓存时 一直存在
```

### 2.HttpSession ###

```title="HttpSession"
获取:
	- <HttpServletRequest>.getSession([-])
方法:
	- getId() String
	- getCreationTime() long
	- getLastAccessedTime() long
	- invalidate()
	- (get|set|remove)Attribute(...)
作用域: 浏览器开启时 一直存在 (指的是 session)
```

## 7.Event&Listener ##

```title="逻辑事件"
request:
	- ServletRequest - 侦听请求的 初始化 / 销毁
	- ServletRequestAttribute - 侦听请求参数的 添加 / 删除 / 替换
session:
	- HttpSession - 创建 / 销毁
	- HttpSessionAttribute - 参数的 添加 / 删除 / 替换
	- HttpSessionBinding - 绑定 / 解绑
	- HttpSessionActivation - 即将钝化 / 即将激活
context:
	- ServletContext - 侦听web app 部署 / 关闭
	- ServletContextAttribute - 参数的 添加 / 删除 / 替换
```

```title="应用"
ServletContext - web app 部署时 创建数据库连接
```

## 8.Filter, FilterChain, FilterConfig ##

筛选器是在请求的 预处理, 处理后 调用的对象, 它主要用于执行过滤任务

```title="Filter, FilterChain, FilterConfig"
Filter方法:
	- init(<FilterConfig>)
	- doFilter(<HttpServletRequest>, <HttpServletResponse>, <FilterChain>)
	- destroy()
FilterChain方法:
	- doFilter(<HttpServletRequest>, <HttpServletResponse>)
FilterConfig方法:
	- init(FilterConfig config)
	- getServletContext() ServletContext
	- getInitParameter(-) String
	- getInitParameters(-) Enumeration
```

```title="filter配置"
<filter>
	<filter-name>...</filter-name>  
	<filter-class>...</filter-class>
	
	<init-param>
		<param-name>初始化参数名</param-name>
		<param-value>初始化参数值</param-value>
	</init-param> 
</filter>

<filter-mapping>  
	<filter-name>...</filter-name>  
	<url-pattern>...</url-pattern>  
</filter-mapping>
```

## 9.CRUD ##

```title="CRUD"
数据库api的.jar包
	- 如: mysql-connector-java-8.0.29.jar
加载Driver:
	- Class.forName(<Driver>)
	- <Driver> : com.mysql.jdbc 或 com.mysql.cj.jdbc
获取连接:
	- `DriverManager.getConnection(<url>, <用户名>, <密码>)`
	- `<url>` - 如java-mysql: `jdbc:mysql://localhost:3306/<数据库名>`
```