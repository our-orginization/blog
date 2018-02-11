title: javascript常见问题汇总（二）
date: 2018-01-16
categories: javascript
tags:
- javascript
- HTML
- 调试

---

本文为日常开发过程中HTML和JS基本调试方法汇总。

<!-- more -->
## 快速进入对着页面任何元素(Elements)
- 点击右键，选择“检查”
- 使用Ctrl+Shift+I(Mac:cmd+option+i)打开开发者面板，选择元素(Elements)标签。Element标签的方法

## 尝试适配各种机型屏幕大小
如果你拥有各种型号的手机那么测试会相对简单，但是现实可不会这样。其实，你可以直接在浏览器你们改变viewport的大小来查看效果。谷歌浏览器提供了非常强大的功能。在谷歌开发者面板，点击toogle device mode按钮，就可以选择不同的设备大小了。

## 元素(Elements)标签的左侧
### DOM树
DOM树可以通过点击左边的小三角展开或收起，便于查看DOM元素树。
点击鼠标右键，会有更多的选择：
- Add attribute - 对选中的元素添加新的属性
- Edit attribute - 编辑某个属性，当你鼠标在某个属性上方点击右键时方才显示。
- Edit as HTML — 你可以编辑整个HTML；如果你想把元素的一部分拷贝使用，这样操作也很方便。
- Copy outerHTML — 将整个标签及其内容拷贝。
- Copy selector — 拷贝CSS选择器(div > span > #id)
- Copy XPath — 拷贝XPath 
- Cut element — 剪切元素
- Copy element — 拷贝元素
- Hide element — 通过添加display:none来临时性地隐藏元素；(cmd+H/Ctrl+H)
- Delete element — 删除元素，可以使用cmd+z来取消删除
- Expand all — 将所有节点展开
- Collapse all — 将所有节点折叠
- :active — 将元素设置为active状态*
- :hover — 将元素设置为hover状态*
- :focus — 将元素设置为focus状态*
- :visited — 将元素设置为已访问状态*
- Scroll into view — 将网页快速滑动到元素所在位置
- Break on... ->subtree modification — 在子节点被修改的时候中断执行
- Break on... ->attribute modification — 在属性被修改的时候中断执行
### 元素快速定位
<img src="https://p0.meituan.net/dpnewvc/ecba775f4acec4e87c97e13be34672ff478.png">
点击该图标，然后在页面上选中元素，DOM tree就会快速定位到该元素的源代码位置。
### 捕获节点截图
一个很酷的技巧就是你可以将选中的节点生成一张png图片：
点击鼠标左键选中元素，使用 Cmd+Shift+P/Ctrl+Shift+P打开命令输入窗口，输入node screenshot，选中 Capture node screenshot，将会生成一张PNG图片。
### 通过字符串、CSS选择器、XPath快速查找
当元素标签打开，输入Cmd+f，将会打开一个输入窗口。
<img src="https://p0.meituan.net/dpnewvc/1c6d741d8ecf8ce6b21ec45a7c4c336e9787.png">
### 直接编辑源文件
打开source标签，选中并打开你想要编辑的文件并编辑，然后右键，在MacOS下，你可以将整个文件夹拖动到你本地的目录。你也可以右键选择Add folder to workspace，接下来你所有的更改都会自动反应到对应的本地代码。

## 元素标签的右侧区域
### 样式（style）
选中Element中DOM树下的某个元素，对应的样式及其他属性也会在右边显示。
<img src="https://p0.meituan.net/dpnewvc/b6ddeb691214e910855c5dd8462579997791.png">
- :hov 当你展开:hov，其提供的选项可以让你激活元素的不同状态，比如hover, focus。在DOM tree上也可以直接对元素进行这样的操作。
- .cls 对选中的元素添加class
- '+' 添加新的style到该元素
在Styles标签，你可以找到对应元素适配的所有的style:
- 黄色的警告标识表面样式的名字或则值格式不正确
- 被划掉意味着被其它样式覆盖
- 灰色背景的样式文件是有效但不可编辑。这些样式文件来自于浏览器。
### 样式的计算结果
<img src="https://p0.meituan.net/dpnewvc/e47d5f2da69ad3f183ca18192933f8e717090.png">
上图所示的矩形框可视化地展示了padding, border和margin的效果以及其值。
对于非静态定位的元素，top、right、bottom、left属性会显示出来。所有的值都可以左键双击，然后修改。
### Event Listeners
<img src="https://p0.meituan.net/dpnewvc/9fe9a6dd1a76cfad5078e42c7807a78937091.png">
在该标签页可以看到所有的事件监听函数:
- 位于左侧的刷新按钮:刷新所有监听事件
- 父元素(Ancestors)选择框:显示/隐藏所有元素的父元素的监听函数

## js调试
### debugger
1.除了console.log之外，debugger;是我最喜欢的快速debug的工具。一旦在代码中加入了这行语句，Chrome在执行的时候会自动在该行停下来。你甚至可以和条件语句配合使用，仅仅在你需要它的时候开启。
2.还有一个不常用的方式是使用控制台(console)，使用debug(funcName)，脚本会在那行函数处暂停。使用这个方法可以很快定位函数，但是对于私有和匿名函数不适用。(注意：debug和console.debug不是同一个事情！)
```javascript
var func1 = function() {
  func2();
};
 
var Car = function() {
  this.funcX = function() {
    this.funcY();
  }
 
  this.funcY = function() {
    this.funcZ();
  }
}
 
var car = new Car();
```
在控制台输入debug(car.funcY)，脚本会在函数调用car.funcY处进入debug模式。
3.个性化console.log信息
在一些很复杂的Debug中，我们需要输出很多行的日志，使用Console.log，console.debug，console.warn，console.info和console.error。你可以使用过滤器来查看特定的消息，但是有时候你会发现这样并不够。我们可以使用更加富有创造力的方法，使用CSS来个性化定义Console.log打印的消息：
```javascript
console.todo = function(msg) {
  console.log(‘ % c % s % s % s‘, ‘color: yellow; background - color: black;’, ‘–‘, msg, ‘–‘);
}
 
console.important = function(msg) {
  console.log(‘ % c % s % s % s’, ‘color: brown; font - weight: bold; text - decoration: underline;’, ‘–‘, msg, ‘–‘);
}
 
console.todo(“This is something that’ s need to be fixed”);
console.important(‘This is an important message’);
```
可以用%s来输出字符串，%i来输出数字，%c来自定义格式。

### 将对象以表格的形式展示
有时候，你需要查看一个复杂的对象元素。通常，我们都会使用console.log将其打印出来然后查看。其实，你还可以使用console.table，让对象更加美观地呈现出来。
### 使用console.time()和console.timeEnd()来记录时间
了解代码的执行时间是非常有用的，特别是调试耗时的for循环。你可以通过定义不同的名字来设置多个timer。
```javascript
console.time('Time1');
var items = [];
for(var i=0; i<10000; i++) {
    items.push(index: i);
}
console.endTime('Time1');
// Time1: 12.31ms
```
### 将minify的代码还原
有时候，生产环境的代码出现问题，然而source map并没有和压缩的代码绑定在一起，所有无法看到还原的代码。不用担心，谷歌浏览器可以将JavaScript代码还原到一个可读的样式。尽管还是比不上真实的代码，但是可以很好的帮助你去分析问题了。点击{}来结构化代码：