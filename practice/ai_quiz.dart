// ============================================================
// TraeCode 对拍练习：AI 出 5 道「预测输出」题（范围：空安全、命名参数、整除）
// 本人手写答案 → AI 参考答案与讲解 → 逐题复核 → 运行验证
// 本文件把 5 道题写成可运行代码，运行结果即标准答案（对拍证据）
// ============================================================

void main() {
  print('===== 题 1（空安全 ?? 与 ?.）=====');
  String? a; // 未赋值 → null
  String b = 'ok';
  print('a ?? b   => ${a ?? b}'); // 预测：ok
  print('a?.length => ${a?.length}'); // 预测：null

  print('');
  print('===== 题 2（空安全 + 类型提升）=====');
  print('f(null)  => ${f(null)}'); // 预测：-1
  print('f(\'dart\') => ${f('dart')}'); // 预测：4

  print('');
  print('===== 题 3（命名参数 required + 默认值）=====');
  greet(name: '小明'); // 预测：同学小明!
  greet(name: '李华', title: '老师', suffix: '，你好'); // 预测：老师李华，你好

  print('');
  print('===== 题 4（整除 ~/ 与 / 的区别）=====');
  print('7 ~/ 2   => ${7 ~/ 2}'); // 预测：3
  print('7 / 2    => ${7 / 2}'); // 预测：3.5
  print('-7 ~/ 2  => ${-7 ~/ 2}'); // 预测：初猜 -4，复核后 -3（向零截断）

  print('');
  print('===== 题 5（字符串插值 + ?? 兜底）=====');
  String? nick;
  int score = 92;
  final line = '成绩：$score，昵称：${nick ?? '匿名'}';
  print(line); // 预测：成绩：92，昵称：匿名
}

int f(String? s) {
  if (s == null) return -1;
  return s.length; // 判空后类型提升，s 提升为 String
}

void greet({required String name, String title = '同学', String? suffix}) {
  print('$title$name${suffix ?? '!'}');
}
