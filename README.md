# lecture2 — 课堂作业2（第4周 · Dart语言基础一）

本仓库为第 4 周课堂作业的独立项目仓库，内容对应实践指南二：Dart 语言基础一
（变量、类型、函数与控制流）。

## 目录结构

```
lecture2/
├── dart_basics/          # 课堂案例复现：dart create dart_basics 工程
│   └── bin/
│       ├── dart_basics.dart    # main：统一调用四组演示
│       ├── types_demo.dart     # 变量/插值/空安全四件套
│       ├── func_demo.dart      # 命名参数 + 箭头函数
│       └── flow_demo.dart      # 成绩分级器 + for-in
├── practice/            # 自主实践基本要求
│   ├── null_safety_rewrite.dart  # 任务1：空安全改写（前/后对照）
│   ├── report_generator.dart     # 任务2：命名参数设计（实验报告生成器）
│   ├── grade_classifier.dart     # 任务3：成绩分级器扩展（边界/非法输入）
│   └── ai_quiz.dart              # 任务4：TraeCode 对拍 5 题（可运行验证）
├── research/            # 独立研究任务（选做，已全部完成）
│   ├── const_final_experiment.dart # const vs final 实验
│   ├── const_error_demo.dart        # 故意 const DateTime.now() 编译错误演示
│   ├── type_promotion.dart          # 类型提升验证
│   └── format_demo.dart             # dart format 格式化前后对比
├── docs/
│   └── ai_quiz_record.md  # 对拍记录（题目/预测/AI答案/复核/运行验证）
├── progress.md          # 进度报告二（十节完整填写）
└── README.md
```

## 运行方式

```bash
# 案例复现：四组演示
cd dart_basics && dart run

# 自主实践
dart run practice/null_safety_rewrite.dart
dart run practice/report_generator.dart
dart run practice/grade_classifier.dart
dart run practice/ai_quiz.dart

# 独立研究
dart run research/const_final_experiment.dart
dart run research/type_promotion.dart
dart run research/format_demo.dart
```

## 环境

- Dart SDK 3.13.5（stable）
- Flutter 3.47.6（stable，本次仅用于环境检查 flutter doctor）
- Git 2.55.0

## 提交记录

按实践指南要求逐步提交：创建工程 → 四组演示通过 → 自主实践 → 对拍记录 → 研究报告与进度报告。
