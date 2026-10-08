// ============================================================
// 任务 2：命名参数设计（自主实践基本要求）
// 为「实验报告生成器」设计函数签名，并给出三种调用
// ============================================================

// 设计思路：
//  - title / studentName 必填 → required 标记
//  - course / experimentNo 有自然默认值 → 给默认值
//  - conclusion 可能没有 → 可空，缺省时自动生成占位
String generateReport({
  required String title,
  required String studentName,
  String course = 'Dart语言基础',
  int experimentNo = 1,
  String? conclusion,
}) {
  final lines = <String>[
    '实验报告 #$experimentNo',
    '标题：$title',
    '学生：$studentName',
    '课程：$course',
    '结论：${conclusion ?? '（待填写）'}',
  ];
  return lines.join('\n');
}

void main() {
  print('===== 命名参数设计：实验报告生成器 =====');
  print('-- 调用 1：只传必填参数 --');
  print(generateReport(title: '空安全实验', studentName: '李华'));

  print('');
  print('-- 调用 2：缺省 className 场景——只给部分可选参数 --');
  print(generateReport(
    title: '函数与参数实验',
    studentName: '李华',
    experimentNo: 2,
    conclusion: '命名参数可缺省且顺序无关',
  ));

  print('');
  print('-- 调用 3：全部参数 --');
  print(generateReport(
    title: '控制流实验',
    studentName: '李华',
    course: '移动软件开发',
    experimentNo: 3,
    conclusion: '分支与循环运行正常',
  ));

  print('');
  print('-- 说明 --');
  print('required 保证 title/studentName 必填，漏填会编译报错；');
  print('course/experimentNo 带默认值可省略；conclusion 可空用 ?? 兜底。');
}
