# 课堂作业2（第4周·Dart语言基础一）— TraeCode 对拍记录

范围：空安全、命名参数、整除（按实践指南指定范围出题）
方式：AI（TraeCode）出 5 道「预测输出」题 → 本人手写预测 → AI 参考答案与讲解 → 逐题复核 → 用 `dart run` 运行验证（验证代码见 `practice/ai_quiz.dart`）

## 题目与对拍结果

| # | 题目代码 | 我的预测 | AI 参考答案 | 运行验证 | 复核结论 |
|---|----------|----------|-------------|----------|----------|
| 1 | `String? a; String b='ok';` print `a ?? b` 和 `a?.length` | `ok` / `null` | `ok` / `null` | `ok` / `null` | 一致：`??` 为 null 时取右侧；`?.` 为 null 时短路返回 null |
| 2 | `int f(String? s){ if(s==null) return -1; return s.length; }` 调用 `f(null)`、`f('dart')` | `-1` / `4` | `-1` / `4` | `-1` / `4` | 一致：判空后局部变量类型提升 |
| 3 | `greet({required String name, String title='同学', String? suffix})` 调用 `greet(name:'小明')`、`greet(name:'李华',title:'老师',suffix:'，你好')` | `同学小明!` / `老师李华，你好` | 同左 | `同学小明!` / `老师李华，你好` | 一致：默认值与 `??` 兜底 |
| 4 | `print(7 ~/ 2)`、`print(7 / 2)`、`print(-7 ~/ 2)` | `3` / `3.5` / 初猜 `-4` | `3` / `3.5` / `-3` | `3` / `3.5` / `-3` | **分歧**：`~/` 是向零截断，不是向下取整，负数时 `-7 ~/ 2 == -3` |
| 5 | `String? nick; int score=92;` print `'成绩：$score，昵称：${nick ?? '匿名'}'` | `成绩：92，昵称：匿名` | 同左 | `成绩：92，昵称：匿名` | 一致：插值 + `??` 兜底 |

## 分歧复核记录

- 唯一分歧在题 4 的负数整除：我初猜 `-7 ~/ 2 == -4`（按数学向下取整直觉），
  AI 参考答案为 `-3`。运行验证确认 Dart 的 `~/` 是**向零截断**（truncating division）：
  `-7 / 2 == -3.5`，截断后为 `-3`。这纠正了一个容易踩坑的认知。

## 验证方式

- 把 5 道题写成可运行代码 `practice/ai_quiz.dart`，`dart run practice/ai_quiz.dart`
  输出即标准答案，全部与复核结论一致。
