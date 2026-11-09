import 'package:flutter/widgets.dart';
import 'package:xc_index/gen/generated_routes.g.dart' as r;
import 'package:xc_platform/xc_platform.dart';

import '../widget/global_pop_up_view.dart';

/// Module：业务包对外唯一出口。
class IndexModule extends Module {
  @override
  final String name = 'xc_index';

  /// 路由表由 @GRoute 注解生成，新增页面只需重跑 `dart run xc_codegen`。
  @override
  Map<String, ComponentBuilder> get routes => r.routes;

  /// 全局浮层：主壳把所有 Module 的 overlay 叠在页面之上。
  @override
  Widget? get overlay => const GlobalPopUpView();

  @override
  Future<void>? get syncTask => _warmUp();

  /// 启动期同步任务：写在业务包内部，主壳不用知道具体做了什么。
  Future<void> _warmUp() async {
    await Future<void>.delayed(const Duration(milliseconds: 10));
  }
}
