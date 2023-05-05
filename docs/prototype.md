# Prototype

## **工厂模式**
缺点：没办法解决对象识别问题（不知道这个对象类型是啥），所以出现了构造函数模式

```javascript
function createPerson(name, age, job){
  var o = new Object();
  o.name = name;
  o.age = age;
  o.job = job;
  o.sayName = function () {
    alert(this.name)
  }
  return o
}

const person1 = createPerson('Nicholas', 29, "software engineer");
const person2 = createPerson("Creg", 27, "Doctor");
```

## **构造函数模式**

可以创建**特定类型**的对象（统一了对象的类型）

```javascript
function Person(name, age, job){
  this.name = name;
  this.age = age;
  this.job = job;
  this.sayName = function () {
    alert(this.name);
  }
}
const person1 = new Person('Nicholas', 29, "software engineer");
const person2 = new Person("Creg", 27, "Doctor");
```
特点：
1. 没有显式地创建对象
2. 直接把属性和方法赋值给了`this`对象；
3. 没有return语句

注意：
1. 构造函数的函数名第一个字母大写

new一个实例，调用构造函数会经历以下4步：
1. 创建一个新对象
2. 讲构造函数的作用域赋值给新对象（this就指向了新对象）
3. 执行构造函数中的代码（为这个新对象添加属性）
4. 返回新对象

令一种解释
1. 创建一个新对象
2. 这个新对象会被执行[[prototype]] 连接， 新对象的__proto__指向构造函数的prototype
3. 讲构造函数的作用域赋值给新对象（this就指向了新对象）
4. 执行构造函数中的代码（为这个新对象添加属性）
5. 如果函数没有返回其他对象，那么new表达式中的函数会自动返回这个新对象


构造函数（使用new） / 普通函数（不使用new)
```javascript
const person = new Person('Nicholas', 29, "software engineer");
person.sayName(); // "Nicholas"
```

```javascript
Person("Creg", 27, "Doctor"); // 属性方法都添加到了window
window.sayName(); // "Grge" 
```

```javascript
const o = new Object();
Person.call(o, "K", 25, "Nurse"); // 添加到对象 o
o.sayName(); // "K"
```


可是构造函数还有缺点，特么的，就是那个sayName的问题
```javascript
console.log(person1.sayName === person2.sayName) // false 这两个函数是在调用构造函数的时候各自生成的，所以是不同的函数。啧
```

那要在`Person`外面定义`sayName`，然后构造函数的时候把`sayName`赋值给实例
```javascript
function Person(name, age, job){
  this.name = name;
  this.age = age;
  this.job = job;
  this.sayName = sayName;
}
function sayName {
    alert(this.name);
}
const person1 = new Person('Nicholas', 29, "software engineer");
const person2 = new Person("Creg", 27, "Doctor");
```

but还有问题
sayName只被这个对象调用，却在全局作用域中，这有点尴尬了。so出现了下个模式————原型模式

## **原型模式** 对，就是那个我找了半天的 prototype

+ prototype中文名字就是 原型
+ 每个函数都有一个prototype属性
+ prototype属性指向一个对象，对象包含所有实例共享的属性和方法。

```javascript
function Person () {}
Person.prototype.name = "Nicholas";
Person.prototype.age = 29;
Person.prototype.job = "Software Engineer";
Person.prototype.sayName = function () => {
  console.log(this.name)
}
let person1 = new Person();
person1.sayName() // "Nicholas"
let person2 = new Person();
person2.sayName();

console.log(person1.sayName === person2.sayName) // true
```

## 理解原型
