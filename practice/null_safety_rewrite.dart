// ============================================================
// 任务 1：空安全改写（自主实践基本要求）
// 给定含隐患的可空代码 → 改写为安全版本，并逐处解释
// ============================================================

// ---- 改写前（含隐患的代码，能编译但运行时有崩溃风险）----
// 隐患点：
//  1. `display` 由 `nickname ?? name` 推导为 String?（仍可空）
//  2. 用 `!` 强行断言后调用 .toUpperCase()，display 为 null 时运行时报错
//  3. 对可能为 null 的 name 直接使用 `!`，name 为 null 时运行时报错
String riskyGreeting(String? name, String? nickname) {
  final display = nickname ?? name; // 隐患 1：display 仍是 String?
  return '你好，${display!.toUpperCase()}'; // 隐患 2：崩溃点
}

int riskyLength(String? name) {
  return name!.length; // 隐患 3：崩溃点
}

// ---- 改写后：安全版本 ----
String safeGreeting(String? name, String? nickname) {
  // 修复 1&2：用 ?? 连环兜底，display 保证为非空 String
  final display = nickname ?? name ?? '匿名';
  return '你好，${display.toUpperCase()}';
}

int safeLength(String? name) {
  // 修复 3：先判空再访问（局部变量判空后发生类型提升，name 提升为 String）
  if (name == null) return 0;
  return name.length;
}

void main() {
  print('===== 空安全改写：演示 =====');
  print('-- 改写前的问题（可空值未处理时）--');
  print('nickname=null, name=null 时 riskyLength 抛错：');
  try {
    riskyLength(null);
  } catch (e) {
    print('  -> $e');
  }
  print('display 为 null 时 riskyGreeting 抛错：');
  try {
    riskyGreeting(null, null);
  } catch (e) {
    print('  -> $e');
  }

  print('');
  print('-- 改写后（安全版本）--');
  print('safeGreeting(null, null)   => ${safeGreeting(null, null)}');
  print('safeGreeting(\'张三\', null)  => ${safeGreeting('张三', null)}');
  print('safeGreeting(null, \'阿花\') => ${safeGreeting(null, '阿花')}');
  print('safeLength(null)           => ${safeLength(null)}');
  print('safeLength(\'李华\')        => ${safeLength('李华')}');

  print('');
  print('-- 逐处解释 --');
  print('1) `final display = nickname ?? name ?? \'匿名\';`');
  print('   ?? 空感知运算符：左侧为 null 时取右侧；连环 ?? 保证 display 一定非空。');
  print('2) 对 display 直接 .toUpperCase()：因为 display 已被保证非空，不再需要 !。');
  print('3) `if (name == null) return 0;`：先判空，之后 name 被类型提升为 String，');
  print('   可直接 .length，避免使用危险的空断言 !。');
  print('4) 原则：优先用 ?. 与 ?? 处理可空，! 只在确定非空时才用（或彻底避免）。');
}
