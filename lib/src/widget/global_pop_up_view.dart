import 'package:flutter/widgets.dart';

/// 主框架包的全局 overlay：挂在主壳的 Stack 最上层（示例留空）。
///
/// 这里是「全局弹窗/浮层」的落点：不在任何页面里，切 tab 也不会掉。
class GlobalPopUpView extends StatelessWidget {
  const GlobalPopUpView({super.key});

  @override
  Widget build(BuildContext context) => const IgnorePointer(child: SizedBox.shrink());
}
