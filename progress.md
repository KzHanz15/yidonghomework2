# 进度报告2（第4周·Dart语言基础一）

> 使用方式：在模板上作答，作答完成后将全文复制到雨课堂答题区（图片无法粘贴时在雨课堂编辑器中手工重新上传），并将同一内容存入自己仓库 `lecture2/progress.md`。

## 一、任务理解

本次作业要完成的内容：

1. **案例复现**：按实践指南复现课堂案例 `dart_basics`——创建一个纯 Dart 工程，在 `bin/` 下实现四组演示（变量/插值/空安全、命名参数/箭头函数、分级器/for-in），由 `main` 统一调用并输出，每步一次 Git 提交。
2. **自主实践基本要求**（3 项必做 + 1 组对拍 + AI 使用标注）：
   - 空安全改写：把含隐患的可空代码改写为安全版本并逐处解释；
   - 命名参数设计：为「实验报告生成器」设计函数签名并给出三种调用；
   - 控制流小程序：成绩分级器扩展（处理边界 100/0 与非法输入）；
   - TraeCode 对拍一组：AI 出 5 道「预测输出」题（范围：空安全、命名参数、整除），先手写答案，再对答案、复核分歧；
3. **独立研究任务（选做）**：const 与 final 差异实验、类型提升验证、dart format 规范实践，已全部完成。

**验收标准**：`dart run` 全部输出正确；空安全无编译告警；代码按步骤 Git 提交（≥3 次）；进度报告按十节模板填写完整；仓库 lecture2 含 README；AI 使用记录真实可追溯。

## 二、环境与工具

| 项目 | 内容 |
|------|------|
| 操作系统 | Windows 11（版本 10.0.26200.9550） |
| Dart SDK | 3.13.5（stable） |
| Flutter | 3.47.6（stable，本次仅用 `flutter doctor` 做环境检查，未运行界面） |
| Git | 2.55.0.windows.5 |
| 运行目标 | 纯 Dart 命令行程序（`dart run`），本课不涉及 Web/模拟器/真机 |
| AI 工具 | TraeCode（AI 编码助手）：代码生成、代码审查、对拍出题、错误定位，均在本作业中使用并逐一验证 |

`flutter doctor` 摘要：Flutter/Android toolchain/Chrome/连接设备均正常；Visual Studio（Windows 桌面开发）未安装——本课不需要，不影响本作业。

## 三、过程记录（时间线）

1. `dart create dart_basics` 创建纯 Dart 工程；查看 `bin/dart_basics.dart` 入口；`git commit -m "feat: dart create dart_basics"`。
2. 编写 `bin/types_demo.dart`（变量、插值、空安全四件套）、`bin/func_demo.dart`（enroll 命名参数 + 箭头函数）、`bin/flow_demo.dart`（gradeOf 分级器 + for-in），改造 `bin/dart_basics.dart` 统一调用；`dart run` 全部输出正确。
3. `dart analyze` 发现 2 条告警（dead_code、unnecessary_non_null_assertion），将可空值改为参数传入并展示 `!` 报错实验后消除；`git commit -m "feat: types/func/flow demos all pass"`。
4. 编写 3 项自主实践并逐个运行验证：`null_safety_rewrite.dart`、`report_generator.dart`、`grade_classifier.dart`；`git commit -m "feat: practice tasks (...)"`。
5. TraeCode 对拍：AI 出 5 题 → 本人预测 → AI 参考答案 → `dart run practice/ai_quiz.dart` 运行验证（题 4 出现分歧并复核）；记录见 `docs/ai_quiz_record.md`；`git commit -m "docs: ai quiz round 1 records"`。
6. 独立研究：const vs final 实验（含 `const DateTime.now()` 编译错误）、类型提升验证、dart format 前后 diff；`flutter doctor` 环境检查。
7. 编写 README、progress.md，全部提交；`git commit -m "docs: research experiments + progress report"`。

## 四、关键代码

### 4.1 空安全改写（前后对照，本课重点）

**改写前（含隐患，能编译但运行会崩溃）：**

```dart
String riskyGreeting(String? name, String? nickname) {
  final display = nickname ?? name;      // 隐患1：display 仍是 String?
  return '你好，${display!.toUpperCase()}'; // 隐患2：display 为 null 时崩溃
}
int riskyLength(String? name) {
  return name!.length;                   // 隐患3：name 为 null 时崩溃
}
```

**改写后（安全版本）：**

```dart
String safeGreeting(String? name, String? nickname) {
  final display = nickname ?? name ?? '匿名'; // ?? 连环兜底，保证非空
  return '你好，${display.toUpperCase()}';     // 无需 !
}
int safeLength(String? name) {
  if (name == null) return 0;            // 先判空 → 类型提升为 String
  return name.length;                     // 可直接访问，不用 !
}
```

逐行解释：
- 第 1 行 `nickname ?? name ?? '匿名'`：`??` 空感知运算符，左侧为 null 时取右侧；连环 `??` 保证 `display` 一定是非空 `String`，此后可直接调用方法。
- 第 2 行：因为 `display` 已保证非空，不再需要 `!`，避免「为 null 时抛 Null check operator used on a null value」的运行时错误。
- 第 4-5 行：`if (name == null) return 0;` 先判空，之后局部变量 `name` 被**类型提升**为 `String`，可直接 `.length`；这是比 `!` 更安全的写法。
- 原则：优先 `?.` 与 `??`，`!` 只在确定非空时用（或避免）。
- 验证方式：`dart run practice/null_safety_rewrite.dart`，输出中 `riskyLength(null)` / `riskyGreeting(null, null)` 被 try/catch 捕获并打印错误类型，安全版本全部正常返回。（AI 生成改写方案，本人逐行复核并运行验证。）

### 4.2 命名参数设计（实验报告生成器）

```dart
String generateReport({
  required String title,          // 必填
  required String studentName,    // 必填
  String course = 'Dart语言基础', // 默认值
  int experimentNo = 1,           // 默认值
  String? conclusion,             // 可空，用 ?? 兜底
}) { ... }

generateReport(title: '空安全实验', studentName: '李华');              // 调用1：只传必填
generateReport(title: '函数实验', studentName: '李华', experimentNo: 2, conclusion: '命名参数可缺省'); // 调用2
generateReport(title: '控制流实验', studentName: '李华', course: '移动软件开发', experimentNo: 3);      // 调用3
```

说明：`required` 保证必填参数漏传即编译报错；带默认值的参数可省略；可空参数用 `??` 兜底。三种调用均运行验证输出正确（见 `practice/report_generator.dart`）。（AI 生成，本人校验语义后运行验证。）

### 4.3 成绩分级器扩展（边界与非法输入）

```dart
String classify(int score) {
  if (score < 0 || score > 100) return '非法输入（成绩需在 0~100）'; // 越界拦截
  return gradeOf(score); // 复用基础分级
}
String classifyInput(String? input) {
  final parsed = int.tryParse(input ?? '');
  if (parsed == null) return '非法输入（不是数字）'; // 非数字拦截
  return classify(parsed);
}
```

验证：`100->优`、`90->优`、`89->良`、`80->良`、`79->中`、`60->中`、`59->不及格`、`0->不及格`、`101/-1->非法`、`abc/空->非法`，全部正确。（AI 生成扩展逻辑，本人设计 12 组用例运行验证。）

## 五、检查点结果

**检查点 1：`dart run` 全部输出正确。** 在 `dart_basics` 目录执行 `dart run`，四组演示全部按预期输出（节选）：

```
===== types_demo =====
count=10, year=2026, score=92.5, pi=3.14159, now=2026
你好，李华，成绩97.5
--- null 情形 ---
?. 安全调用 => null
?? 默认值   => 未填写
!  空断言抛错 => Null check operator used on a null value
--- 赋值后 ---
?. 安全调用 => 2
?? 默认值   => hu
!  空断言   => 2
late 延迟初始化 => abc123
===== func_demo =====
报名：李华，年龄 18，班级 2班
报名：小明，年龄 20，班级 未指定
报名：小红，年龄 18，班级 未指定
add2(7, 2) = 9
===== flow_demo =====
第1题
第2题
第3题
85分 -> 良
59分 -> 不及格
7 ~/ 2 = 3, 7 / 2 = 3.5
```

**检查点 2：空安全无编译告警。** `dart analyze` 输出：

```
Analyzing dart_basics...
No issues found!
```

另外按指南做了「故意实验」：对 null 值使用 `!` 抛出的错误类型为 `Null check operator used on a null value`（已捕获观察，见上方输出），以后再看到该报错可直接定位。口头解释 `??`（null 时取默认值）与 `!`（断言非 null，为 null 抛错）的区别已在上文第 4.1 节说明。

## 六、问题与调试

**问题 1：`dart analyze` 出现 2 条告警，不满足「空安全无编译告警」。**
- 现象：`types_demo.dart` 报 `dead_code`（`String? nickname;` 未赋值、静态为 null，`nickname?.length` 被判定为死代码）与 `unnecessary_non_null_assertion`（赋值后仍用 `!`）。
- 定位过程：先 `dart analyze` 得到告警行号，逐行检查；发现原因是把「可空变量声明后直接使用」写在了同一函数内，分析器能静态推断出 null。
- 解决方案：把可空值改为**函数参数传入**（分析器无法静态判定为 null），并对 `!` 的崩溃场景用 `try/catch` 展示错误类型（这正是指南要求的「故意实验」）；再次 `dart analyze` 为 No issues found。
- 验证：`dart analyze` 无告警，`dart run` 输出正确。

**问题 2：改写前的空安全代码 `display.toUpperCase()` 直接编译报错。**
- 现象：`String? display` 上调用方法报 `Method 'toUpperCase' cannot be called on 'String?'`。
- 定位：这是 Dart 空安全在**编译期**就拦截可空值调用，属于正常保护机制。
- 解决：用 `?? '匿名'` 兜底保证非空后再调用（见 4.1），并记录在改写对照中。
- 验证：安全版本运行正常。

**问题 3：`dart run` 报 PathAccessException（Pub 缓存临时目录创建失败）。**
- 现象：`Creation of temporary directory failed, path = ...\Pub\Cache\_temp`（Access is denied, errno = 5）。
- 定位：pub 需要写入用户目录下的缓存临时目录，被权限限制。
- 解决：调整命令运行环境权限后重新执行，`dart run` / `dart pub get` 恢复正常。
- 验证：`dart pub get` 成功（Changed 48 dependencies），`dart run` 正常输出。

## 七、AI 使用记录（TraeCode 清单）

| 用途 | 指令摘要 | AI 输出 | 本人验证方式 |
|------|----------|---------|--------------|
| 生成四组 demo | 按指南在 bin/ 生成 types/func/flow 演示并统一 main 调用 | 4 个 .dart 文件 | `dart run` 输出正确；`dart analyze` 无告警 |
| 空安全改写 | 把含隐患可空代码改写为安全版本并解释 | 改写前后对照 + 逐行解释 | 运行输出错误类型与安全结果对比 |
| 命名参数设计 | 为实验报告生成器设计签名并给 3 种调用 | generateReport + 3 调用 | `dart run` 输出 3 份报告正确 |
| 成绩分级器扩展 | 处理边界 100/0 与非法输入 | classify/classifyInput | 12 组用例运行全部正确 |
| 对拍出题与批改 | 出 5 道预测输出题 + 参考答案讲解 | 5 题 + 参考答案 | 本人先预测，再 `dart run practice/ai_quiz.dart` 验证（题 4 分歧：-7~/2 为 -3） |
| 编译错误定位 | 分析 dead_code 等告警原因 | 根因分析与修改建议 | 修改后 `dart analyze` No issues found |

对拍全过程记录见 `docs/ai_quiz_record.md`；所有 AI 生成代码均经本人运行验证后才提交。

## 八、证据截图

（本人已将真实运行输出作为文本证据写入本报告；此处截图在提交前补充拍摄，每图配一句话说明。）

1. `dart run` 四组演示输出截图 —— 全部输出正确，空安全实验显示 `Null check operator used on a null value` 错误类型。
2. `dart analyze` 输出截图 —— `No issues found!`，空安全无编译告警。
3. `flutter doctor` 输出截图 —— 环境检查：Flutter/Android toolchain/Chrome/设备正常。
4. `git log` 提交记录截图 —— 按指南步骤多次提交（见下）。

`git log --oneline` 文本证据：

```
docs: research experiments + progress report
docs: ai quiz round 1 records
feat: practice tasks (null safety rewrite, named params, grade classifier)
feat: types/func/flow demos all pass
feat: dart create dart_basics
```

## 九、自评（对照作业要求逐项自查）

| 要求 | 完成情况 |
|------|----------|
| 案例复现 dart_basics（代码与指南一致、可运行） | ✅ 四组演示齐全，`dart run` 输出正确 |
| 检查点：dart run 全部输出正确 | ✅ 见第五节 |
| 检查点：空安全无编译告警 | ✅ `dart analyze` No issues found |
| Git 规范（按步骤 ≥3 次提交） | ✅ 5 次提交，commit message 规范 |
| 报告记录（十节模板） | ✅ 本文件 |
| 空安全改写 + 逐处解释 | ✅ 4.1 前后对照 + 解释 |
| 命名参数设计（签名 + 三种调用） | ✅ 4.2 |
| 控制流小程序：分级器扩展（边界/非法） | ✅ 4.3 + 12 用例 |
| TraeCode 对拍一组（题目/预测/AI答案/分歧复核） | ✅ 5 题，1 处分歧已复核（见 docs/ai_quiz_record.md） |
| AI 使用标注（真实可追溯） | ✅ 第七节 + 各代码注明 |
| 独立研究（选做）：const/final、类型提升、dart format | ✅ 三项均完成并有运行/编译证据 |
| 仓库：lecture2 独立仓库含 README | ✅ |

## 十、一句话收获与下一步计划

**一句话收获**：Dart 空安全四件套（`?.`、`??`、`!`、`late`）配合类型提升，能把大量「运行时崩溃」前移到编译期；同时记住 `~/` 整除是向零截断（`-7 ~/ 2 == -3`）。

**下一步计划**：第 3 课将学习集合（List/Map/Set）与回调函数，需要提前预习 `for-in` 遍历、集合字面量与函数作为一等公民的用法；遗留问题：`late` 的惰性初始化与 `final` 组合的边界行为，将在后续课程继续验证。
