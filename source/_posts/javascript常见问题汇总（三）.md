title: javascript常见问题汇总（三）
date: 2018-02-22
categories: javascript
tags:
- javascript

---

Who said javascript was easy ?

<!-- more -->

## 数组排序
js默认使用字典序来排序，因此 [1,2,5,10].sort()排序的结果是[1,10,2,5]。
如果你想正确的排序，应该这样做：[1,2,5,10].sort((a, b) => a - b)。

## new Date()
new Date()的使用方法有：
- 不接收任何参数：返回当前时间；
- 接收一个参数x: 返回1970年1月1日 + x毫秒的值。
- new Date(1, 1, 1)返回1901年2月1号。
然而，new Date(2016, 1, 1)不会在1900年的基础上加2016，而只是表示2016年。

## 替换函数没有真的替换
```javascript
let s = 'b2b';
const replaced = s.replace('b', 'c');
replaced === "l2b" // 只会替换掉第一个b
s === "b2b" // 并且s的值不会变
```
如果你想把所有的b都替换掉，要使用正则：
```javascript
"b2b".replace(/b/g, 'c') === 'c2c';
```

## Math.min()比Math.max()大
```javascript
Math.min() < Math.max() // false
```
因为Math.min() 返回 Infinity, 而 Math.max()返回 -Infinity。

## new关键字
我们把那些用new调用的函数叫做构造函数。

使用了new的函数到底做了什么事情呢？
- 创建一个新的对象
- 将对象的prototype设置为构造函数的prototype
- 执行构造函数，this执行新构造的对象
- 返回该对象。如果构造函数返回对象，那么返回该构造对象。

```javascript
// 为了更好地理解底层，我们来定义new关键字
function myNew(constructor, ...arguments) {
  var obj = {}
  Object.setPrototypeOf(obj, constructor.prototype);
  return constructor.apply(obj, arguments) || obj
}
```

那么使用new关键字和不使用有什么区别呢？
```javascript
function Bird() {
  this.wings = 2;
}
/* 普通的函数调用 */
let fakeBird = Bird();
console.log(fakeBird);    // undefined
/* 使用new调用 */
let realBird= new Bird();
console.log(realBird)     // { wings: 2 }
```

## 原型和继承
原型(Prototype)是JavaScript中最容易搞混的概念，其中一个原因是prototype可以用在两个不同的情形下。

- 原型关系
每一个对象都有一个prototype对象，里面包含了所有它的原型的属性。
.__proto__是一个不正规的机制(ES6中提供)，用来获取一个对象的prototype。你可以理解为它指向对象的parent。
所有普通的对象都继承.constructor属性，它指向该对象的构造函数。当一个对象通过构造函数实现的时候，__proto__属性指向构造函数的构造函数的.prototype。Object.getPrototypeOf()是ES5的标准函数，用来获取一个对象的原型。

- 原型属性
每一个函数都有一个.prototype属性，它包含了所有可以被继承的属性。该对象默认包含了指向原构造函数的.constructor属性。每一个使用构造函数创建的对象都有一个构造函数属性。

```javascript
function Dog(breed, name) {
    this.breed = breed,
    this.name = name
}

Dog.prototype.describe = function() {
  console.log(`${this.name} is a ${this.breed}`)
}

const rusty = new Dog('Beagle', 'Rusty');

/* .prototype 属性包含了构造函数以及构造函数中在prototype上定义的属性。*/
console.log(Dog.prototype)  // { describe: ƒ , constructor: ƒ }

/* 使用Dog构造函数构造的对象 */
console.log(rusty)   //  { breed: "Beagle", name: "Rusty" 

/* 从构造函数的原型中继承下来的属性或函数 */
console.log(rusty.describe())   // "Rusty is a Beagle"

/* .__proto__ 属性指向构造函数的.prototype属性 */
console.log(rusty.__proto__)    // { describe: ƒ , constructor: ƒ }

/* .constructor 属性指向构造函数 */
console.log(rusty.constructor)  // ƒ Dog(breed, name) { ... }
```

## 原型链
原型链是指对象之间通过prototype链接起来，形成一个有向的链条。当访问一个对象的某个属性的时候，JavaScript引擎会首先查看该对象是否包含该属性。如果没有，就去查找对象的prototype中是否包含。以此类推，直到找到该属性或则找到最后一个对象。最后一个对象的prototype默认为null。

## 拥有 vs 继承
一个对象有两种属性，分别是它自身定义的和继承的。
```javascript
function Car() { }
Car.prototype.wheels = 4;
Car.prototype.airbags = 1;

var myCar = new Car();
myCar.color = 'black';

/*  原型链中的属性也可以通过in来查看:  */
console.log('airbags' in myCar)  // true
console.log(myCar.wheels)        // 4
console.log(myCar.year)          // undefined

/*  通过hasOwnProperty来查看是否拥有该属性:  */
console.log(myCar.hasOwnProperty('airbags'))  // false — Inherited
console.log(myCar.hasOwnProperty('color'))    // true
```

Object.create(obj) 创建一个新的对象，prototype指向obj。
```javascript
var dog = { legs: 4 };
var myDog = Object.create(dog);

console.log(myDog.hasOwnProperty('legs'))  // false
console.log(myDog.legs)                    // 4
console.log(myDog.__proto__ === dog)       // true
```

## 继承是引用传值
继承属性都是通过引用的形式。我们通过例子来形象理解：
```javascript
var objProt = { text: 'original' };
var objAttachedToProt = Object.create(objProt);
console.log(objAttachedToProt.text)   // original

// 我们更改objProt的text属性，objAttachedToProt的text属性同样更改了
objProt.text = 'prototype property changed';
console.log(objAttachedToProt.text)   // prototype property changed

// 但是如果我们讲一个新的对象赋值给objProt，那么objAttachedToProt的text属性不受影响
objProt = { text: 'replacing property' };
console.log(objAttachedToProt.text)   // prototype property changed
```

