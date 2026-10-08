// ============================================================
// 任务 3：控制流小程序——成绩分级器扩展（自主实践基本要求）
// 在基础 gradeOf 上扩展：处理边界 100/0 与非法输入
// ============================================================

// 基础分级（本课案例）
String gradeOf(int score) {
  if (score >= 90) return '优';
  if (score >= 80) return '良';
  if (score >= 60) return '中';
  return '不及格';
}

// 扩展版：先拦截非法范围（<0 或 >100），再分级
String classify(int score) {
  if (score < 0 || score > 100) return '非法输入（成绩需在 0~100）';
  return gradeOf(score);
}

// 输入可能是字符串（例如控制台输入）：用 int.tryParse 处理非数字
String classifyInput(String? input) {
  final parsed = int.tryParse(input ?? '');
  if (parsed == null) return '非法输入（不是数字）';
  return classify(parsed);
}

void main() {
  print('===== 成绩分级器（扩展版）=====');
  final cases = ['100', '90', '89', '80', '79', '60', '59', '0', '101', '-1', 'abc', ''];
  for (final c in cases) {
    final result = classifyInput(c);
    print('输入 "${c.padRight(5)}" -> $result');
  }

  print('');
  print('-- 边界说明 --');
  print('100 -> 优（含上边界）；0 -> 不及格（含下边界）；');
  print('101 / -1 -> 非法（越界）；abc / 空串 -> 非法（不是数字）。');
}
