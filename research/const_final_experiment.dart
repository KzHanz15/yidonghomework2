// ============================================================
// 独立研究任务 1：const 与 final 差异实验
// 结论：final 是「运行时确定一次」；const 是「编译期常量」。
// 所以 const 不能接收 DateTime.now()（运行时值）——见 const_error_demo.dart 的编译错误。
// ============================================================

void main() {
  print('===== const vs final 实验 =====');

  // final：运行时确定一次，可以接收运行时值
  final now = DateTime.now();
  print('final now = DateTime.now()  => OK，now=${now.year}-${now.month}-${now.day}');

  // const：编译期常量，只能接收常量表达式
  const pi = 3.14159;
  print('const pi = 3.14159         => OK，pi=$pi');

  // const 字面量与运算也是编译期常量
  const double goldenRatio = (1 + 5.0) / 2;
  print('const goldenRatio = (1+5.0)/2 => OK，goldenRatio=$goldenRatio');

  print('');
  print('-- 关键差异 --');
  print('final：变量在运行时首次赋值后不可再改（同一对象只赋值一次）。');
  print('const：值在编译期就已确定，且 const 变量本身不可变；');
  print('       不能用 const 接收 DateTime.now() 等运行时计算结果。');
  print('       详见 const_error_demo.dart（dart analyze 报 compile error）。');
}
