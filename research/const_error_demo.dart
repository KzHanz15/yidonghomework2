// ============================================================
// 独立研究任务 1（续）：故意使用 const 接收运行时值 → 编译错误
// 运行 `dart analyze research/const_error_demo.dart` 观察报错：
//   Error: Invalid constant value ... (DateTime.now() 不是常量表达式)
// 这个文件刻意保留错误，用于展示 const 的约束。
// ============================================================
const DateTime wrongConst = DateTime.now();
void main() {
  print(wrongConst);
}
