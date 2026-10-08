/// 类型与变量演示：变量声明、字符串插值、空安全四件套
void typesDemo() {
  // 1) 变量声明：var 类型推断 / 显式类型 / final / const
  var count = 10; // 由编译器推断为 int，之后不能再赋字符串
  int year = 2026;
  double score = 92.5;
  final now = DateTime.now(); // 运行时确定一次
  const pi = 3.14159; // 编译期常量
  print('count=$count, year=$year, score=$score, pi=$pi, now=${now.year}');

  // 2) 字符串插值：变量直接 $，表达式加花括号 ${}
  String name = '李华';
  print('你好，$name，成绩${score + 5}');

  // 3) 空安全四件套：?. / ?? / ! / late
  // 可空值从参数传入，展示 null 与赋值后的两种行为
  print('--- null 情形 ---');
  showNullSafety(null);
  print('--- 赋值后 ---');
  showNullSafety('hu');
}

void showNullSafety(String? nickname) {
  // ?. 安全调用：null 则短路，整个表达式返回 null
  print('?. 安全调用 => ${nickname?.length}');
  // ?? 空默认值：为 null 时改用默认值
  print('?? 默认值   => ${nickname ?? '未填写'}');
  // ! 空断言：断言非 null；若仍为 null，运行时会抛错（慎用）
  try {
    print('!  空断言   => ${nickname!.length}');
  } catch (e) {
    print('!  空断言抛错 => $e');
  }
  // late 延迟初始化：承诺使用前必赋值
  late String token;
  token = 'abc123';
  print('late 延迟初始化 => $token');
}
