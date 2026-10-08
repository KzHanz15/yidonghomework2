// ============================================================
// 独立研究任务 3：dart format 规范实践
// 这是「格式化前」的乱版（格式混乱但语法正确）。
// 用 `dart format research/format_demo.dart` 格式化后与下方乱版对比。
// ============================================================
void main(){
print('===== dart format 演示 =====');
var items=[1,2,3];
var total=0;
for(final i in items){
total+=i;
}
print('total=$total');
int add(int a,int b){
return a+b;
}
print('add(3,4)=${add(3,4)}');
}
