/// 函数演示：命名参数 + required + 默认值 + 箭头函数
void enroll({required String name, int age = 18, String? className}) {
  print('报名：$name，年龄 $age，班级 ${className ?? '未指定'}');
}

// 箭头函数：单表达式简写
int add2(int a, int b) => a + b;

void funcDemo() {
  enroll(name: '李华', className: '2班'); // 命名参数，age 用默认值 18
  enroll(name: '小明', age: 20); // className 可空，缺省
  enroll(name: '小红'); // 只给必填的 name
  print('add2(7, 2) = ${add2(7, 2)}');
}
