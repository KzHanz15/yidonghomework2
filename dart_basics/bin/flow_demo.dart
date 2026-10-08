/// 控制流演示：成绩分级器 + for-in 循环
String gradeOf(int score) {
  if (score >= 90) return '优';
  if (score >= 80) return '良';
  if (score >= 60) return '中';
  return '不及格';
}

void flowDemo() {
  for (final i in [1, 2, 3]) {
    print('第$i题');
  }
  print('85分 -> ${gradeOf(85)}');
  print('59分 -> ${gradeOf(59)}');
  print('7 ~/ 2 = ${7 ~/ 2}, 7 / 2 = ${7 / 2}'); // 整除 vs 除
}
