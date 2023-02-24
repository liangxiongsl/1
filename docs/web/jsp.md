

```title="jsp初始化"
翻译JSP页面 - JSP translator将JSP翻译为<servlet>.java
编译JSP页面 - complier编译.java文件
加载类 - classloader加载类文件
实例化 - 创建生成的 Servlet 的对象
初始化 - 容器调用 jspInit() 方法
请求处理 - 容器调用 _jspService() 方法
销毁 - 容器调用 jspDestroy() 方法
```


EL隐式变量, jsp隐式变量, Servlet 对比

|EL ${} |jsp `<%= %>`     |Servlet/Object|
|:-:|:-:|:-:|
|pageContext    |pageContext    ||
|applicationScope       |application    |ServletContext|
|sessionScope   |session        |HttpSession|
|requestScope   |request        |HttpServletRequest|
|pageScope      |       ||
|initParam      |       ||
|       |page   ||
|param  |       |Map<String, String>|
|paramValues    |       |`Enumeration<String>`|
|header |       |String|
|headerValues   |       |`Enumeration<String>`|
|cookie |       |HttpCookie|
|       |out    |JSPWriter / PrintWriter|
|       |response       |HttpServletResponse|
|       |config ||
|       |exception      ||

// param, paramValues, header, headerValues, cookie 均是 request能获取的对象

api:

- javax.servlet.jsp
- javax.servlet.jsp.tagext

```title="javax.servlet.jsp包的接口"
JspPage
HttpJspPage
```

```title="javax.servlet.jsp包的类"
JspWriter
PageContext
JspFactory
JspEngineInfo
JspException
JspError
```

```title="常用接口方法(均是回调方法)"
JspPage:
	- jspInit()
	- jspDestroy()
HttpJspPage:
	- _jspService()
```

!!! tip
	- jsp 特有功能: 往字符串里添加 expression`<%= %>`
	- EL 特有功能: 往字符串里添加 EL `${}`

###  ###


## 1.指令元素 ##

```title="指令元素"
page:
	- 定义
	- <%@ page 属性名="属性值" %>
	- 常用属性: contentType, extends, language, {==errorPage==}, isErrorPage, isELIgnored
include:
	- 静态引入任何资源
	- <%@ include file="资源名" %>
taglib:
	- 引入标签库
	- <%@ taglib uri="" prefix="" %>
	- 如: 引入 JSTL, 自定义标签
```

## 2.脚本元素 ##

```title="脚本元素"
declaration - <%! %>
scriptlet - <% %>	- 既能实现逻辑控制, 也能方便地实现 显示html/jsp 的控制
expression - <%= %>
```

!!! note "实现对 jsp 的控制"
	```jsp
	<%if(true){%>
    	statement1
	<%}else{%>
	    statement2
	<%}%>
	
	<%for(int i=1; i<=10; ++i){%>
	    <%=i%>
	<%}%>
	```

## 3.Implicit对象 ##

```title="Implicit对象"
对象			类型	

out			JspWriter
request		HttpServletRequest
response	HttpServletResponse
config		ServletConfig
application	ServletContext
session		HttpSession
{==pageContext==}	PageContext
{==page==}		Object
exception	Throwable
```

!!! tip
	- config的web.xml配置稍有不同: `<jsp-file>` 替代`<servlet-class>`

```title=""
pageContext:
	- pageContext.xxxAttribute("<属性名>", <属性值>, PageContext.XXX_SCOPE)
	- XXX 表示 PAGE(默认)/REQUEST/SESSION/APPLICATION
	- 即pageContext可以管理四个作用域的属性
page:
	- 定义: `Object page=this;`
exception:
	- getMessage()
	- 引入: `<%@ page isErrorPage="true" %>`
```


## 4.异常 ##

```title="异常工作"
web.xml:
	<error-page>
	    <exception-type>转发的异常类(如: java.lang.Exception)</exception-type>
	    <location>/显示错误页.jsp</location>
	</error-page>
显示错误页.jsp:
	- <%@ page isErrorPage="true" %>
引发错误页.jsp:
	- <%@ page errorPage="需要转发的错误页" %>
```

## 5.Action元素 ##

每个 JSP action标记都用于执行某些特定任务 (实际上 指令元素+脚本元素+隐式对象 就能实现大部分功能)

可用于控制 JavaBean

```title="Action元素"
jsp:forward
	- 将请求和响应转发到另一个资源
jsp:include
	- 包含另一个资源
jsp:param
	- 设置参数值, 主要用于 jsp:forword 或 jsp:include

jsp:useBean
	- 创建或定位 Bean 对象
	- <jsp:useBean id="" class="" scope=""/>
jsp:setProperty
	- 设置 Bean 对象的属性值
	- 如: (前两者依赖于request参数)
		- <jsp:setProperty name="" property="*"/>
		- <jsp:setProperty name="" property="属性名" param="参数名"/>
		- <jsp:setProperty name="" property="属性名" value="属性值" />
jsp:getProperty
	- 获取 Bean 对象的属性值
	- <jsp：getProperty name="" property="属性名" />

jsp:plugin
	- 嵌入另一个component, 如applet (applet是core java的api)
jsp:fallback
	- 用于在plugin正常工作时打印消息
```

## 6.EL ##

${}

EL的位置 和 脚本元素expression的位置 一样？

```title="EL隐式对象"
pageScope - 返回 page scope内属性的map
requestScope
sessionScope
applicationScope
param
paramValues
header
headerValues
cookie
initParam - 返回 所有初始化参数的map
pageContext - 返回 page/request/session/application 四个 scope内属性的map
```


!!! tip
	- EL可以以句点的方式访问对象
	- 搜索范围: pageContext > applicationScope > sessionScope > requestScope > pageScope
	- EL不能放入 指令元素 或 脚本元素 中
	- `${}` 类似于 `<%= %>`, 而对于EL内部的隐式变量, 后者是无法访问的
	- EL 访问不了 局部变量

## 7.JSTL ##

JSTL用于简化 jsp 开发

```title="引入"
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="前缀" %>
```

```title="core 标签"
<c:out value="字符串 | EL表达式"/>
    - 用于输出字符串 (不会转换为html, 否则需要用EL表达式)
<c:import var="变量名" url="资源url"/>
    - 向资源url发送请求, 将返回的内容赋值给 var
<c:set var="" scope="" value=""/>
    - 它用于设置在"scope"中计算的表达式的结果。<c：set> 标记很有用，因为它计算表达式并使用结果设置 java.util.Map 或 JavaBean 的值 ？
<c:remove var="变量名" scope="作用域" />
    - 删除特定作用域的变量
<c:catch var ="异常变量">
    - 可能出现异常的内容</c:catch> - 捕获异常, 并选择性地公开异常
<c:if test="逻辑表达式">语句</c:if>
    - 仅当test="true"时, 执行语句 (通常使用EL表达式作为 test的内容)
<c:choose>子句<c:choose> - 用于互斥的控制结构 (即 if-else 结构)
    - <c:when test="逻辑表达式">语句</c:when> - 通常有多个这样的语句
    - <c:otherwise>语句</c:otherwise> - 但 c:when 不满足条件时执行此语句
c:forEach:
    - <c:forEach var="迭代器" begin="" end="" step="步长">语句</c:forEach> - 用于代替循环
    - <c:forEach items="" ></c:forEach>
<c:forTokens var="迭代器" items="字符串" delims="分隔符">语句</c:forTokens>
    - 用于将字符串按分隔符分割为多个块, 迭代所有的块
<c:param name="参数名" value="参数值"/>
    - 为 s:import的url属性 或 s:url的value属性 或 s:redirect的url属性 添加参数
<c:url> - 用于定制url (以替代response.encodeURL() 的功能; 如: 添加参数, 网址格式, 网址编码)
    - <c:url value="url"></c:url> - 输出一个url
    - <c:url value="url" var="变量"></c:url> - 将url输出重定向到指定变量

```

```title=" 标签"
boolean fn:contains(<字符串>, <模式串>) - 判断文本串能否匹配模式串
boolean fn:containsIgnoreCase(<字符串>, <模式串>) - 判断文本串能否匹配模式串 (大小写不敏感)
boolean fn:endsWith(<字符串>, <模式串>) - 判断模式串是否为文本串的后缀
String fn:escapeXml(<字符串>) - 将字符串进行转换, 使内容不会被浏览器渲染为xml格式应有的表现 (如: 小于号`<` 会转换为`&lt;`)
int fn:indexOf(<字符串>, <模式串>) - 返回模式串首次出现的下标
String fn:trim(<字符串>) - 删除两端空格
String fn:toLowerCase(<字符串>) - 转小写
String fn:toUpperCase(<字符串>) - 转大写
String fn:substring(<字符串>, <start>, <end>) - 取子串
String fn:substringAfter(<字符串>, <模式串>) - 删除第一次匹配到的模式串及其前缀 (简言之就是设计来匹配字符串的所有模式串的)
String fn:substringBefore(<字符串>, <模式串>) - 删除最后一次匹配到的模式串及其前缀
int fn:length(<Object>) - 返回 字符数 或 集合元素个数

```

```title="fmt 标签"
fmt:parseNumber - 它用于解析货币、百分比或数字的字符串表示形式
fmt:timeZone - 它指定嵌套在其正文或时区中的分析操作，用于任何时间格式
fmt:formatNumber - 它用于以特定格式或精度格式化数值
fmt:parseDate - 它分析时间和日期的字符串表示形式
fmt:bundle - 它用于创建将由其标签正文使用的资源包对象
fmt:setTimeZone - 它将时区存储在时区配置变量中
fmt:setBundle - 它加载资源包并将其存储在捆绑包配置变量或命名作用域变量中
fmt:message - 它显示国际化消息
fmt:formatDate - 它使用提供的模式和样式格式化时间和/或日期

```

```title="xml 标签"
x:out - 类似于 <%= ...>标记, 但用于 XPath 表达式
    - 如: 
        - <c:set var="变量名">xml字符串</c:set>
        - <x:out select="$xml变量/标签名[索引]/<标签名1>" /> 
x:parse - 用于解析xml文件的变量, 并传递给指定变量
    - 如: 
        - <c:import var="变量名" url="xxx.xml"/> - 获取xml字符串
        - <x:parse var="变量名1" xml="${变量名}"/>
x:set - 它用于将变量设置为 XPath 表达式的值
    - 如: <x:set var="变量名" select="$xml变量/标签名[索引]/<标签名1>"/>
x:choose, x:when, x:otherwise
    - if-else控制结构, test内部可包含XPath表达式
x:if - if控制结构, test内部可包含XPath表达式
x:transform
    - 它在XML文档中用于提供XSL(可扩展样式表语言)转换
    - 如: <x:transform xml="${xml}" xslt="${xsl}" />
    - 神奇的东西...
X:param
    - 它与 x:transform 标记一起使用, 用于设置 XSLT 样式表中的参数
    - 如: <x:param name="bgColor" value="yellow"/>

```

```title="sql 标签"
sql:setDataSource
    - 用于创建仅适用于原型设计的简单数据源
    - 如: <sql:setDataSource var="db"
           driver="com.mysql.cj.jdbc.Driver"
           url="jdbc:mysql://localhost:3306/tmp"
           user="root"
           password="2147483647"/>
sql:query
    - 用于执行在其 sql 属性或正文中定义的 SQL 查询
    - 如:
        <sql:query var="resultSet" dataSource="${db}">
            select * from tmp
        </sql:query>
sql:update
    - 用于执行在其 sql 属性或标记正文中定义的 SQL DML 查询
    - 如:
        <sql:query var="resultSet" dataSource="${db}">
            INSERT INTO Students VALUES (154,'Nasreen', 'jaha', 25); 
        </sql:query>
sql:param
    - 用于在 SQL 语句中设置参数值 (用于 sql:query, sql:update)
    - 如:
        <sql:update var="count" dataSource="${db}">  
            DELETE FROM Students WHERE Id = ?  
            <sql:param value="${StudentId}" />  
        </sql:update>
sql:dateParam
    - 用于设置 SQL 查询参数的指定日期
    - 如:
        <sql:update dataSource="${db}" var="count">  
           UPDATE Student SET date = ? WHERE Id = ?  
           <sql:dateParam value="<%=new Date("2000/10/16")%>" type="DATE" />  
           <sql:param value="<%=studentId%>" />  
        </sql:update>
sql:transaction
    - 用于事务管理
    - 它用于将多个 sql:update 分组到公共事务中
    - 如果在单个事务中对多个 SQL 查询进行分组，则数据库只会命中一次
    - 如:
        <sql:transaction dataSource="${db}">  
           <sql:update var="count">  
              UPDATE Student SET First_Name = 'Suraj' WHERE Id = 150  
           </sql:update>  
           <sql:update var="count">  
              UPDATE Student SET Last_Name= 'Saifi' WHERE Id = 153  
           </sql:update>  
           <sql:update var="count">  
             INSERT INTO Student VALUES (154,'Supriya', 'Jaiswal', '1995/10/6');  
           </sql:update>  
        </sql:transaction>

```
