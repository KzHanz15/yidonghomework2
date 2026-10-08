// ============================================================
// 独立研究任务 2：类型提升（Type Promotion）验证
// 结论：可空局部变量在 if (x != null) 判空后，会被提升为非空类型，
// 可直接当作非空使用；但类字段不会提升（见 _Box 类）。
// ============================================================

// 局部变量：判空后类型提升，可直接 .length
int localDemo(String? s) {
  if (s == null) return -1;
  return s.length; // 提升：s 在这里是 String
}

// 类字段：不会提升，即使判空后仍需 ! 或 ?. （字段可能在别处被修改）
class _Box {
  String? value;
}

int fieldDemo(_Box box) {
  if (box.value == null) return -1;
  return box.value!.length; // 字段不提升，必须 !（null 时崩溃）或 ?.
}

void main() {
  print('===== 类型提升验证 =====');
  print('localDemo(null)     => ${localDemo(null)}');
  print('localDemo(\'dart\')   => ${localDemo('dart')}'); // 提升后 s.length

  final box = _Box();
  box.value = 'hello';
  print('fieldDemo(box=hello) => ${fieldDemo(box)}'); // 字段场景仍需 ! 

  print('');
  print('-- 结论 --');
  print('1) 可空局部变量：if (s == null) return ...; 之后 s 被提升为 String，');
  print('   可直接 s.length，无需 !。');
  print('2) 类字段：即使判空，字段仍被视为可空（编译器无法保证期间未被修改），');
  print('   需要 ! 或 ?. 处理。');
}
