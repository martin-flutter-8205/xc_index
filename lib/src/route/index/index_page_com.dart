// Flutter 自带的 Action 与框架的 Action 重名，这里只隐藏 Flutter 那个
import 'package:flutter/material.dart' hide Action;
import 'package:xc_platform/xc_platform.dart';
import 'package:xc_ui/xc_ui.dart';

import '../../view/index_tabs.dart';
import 'index_routes.dart';

part 'index_page_com.g.dart';

// ===========================================================================
// Model：一个类装完三段 —— ① 状态 ② 业务(@gaction) ③ 普通方法
// 意图工厂不写在 Model 里：由 .g.dart 按 @gaction 签名生成（IndexModelIntents）
// ===========================================================================
class IndexModel extends WModel {
  // ① 状态：一行一个字段
  /// 当前选中的 tab 下标，同时是 IndexedStack 的 index。
  var currentIndex = 0;

  /// 未读消息数：tab 角标与消息页共用一个来源。
  var unreadCount = 2;

  @override
  void init() {
    // 主框架没有首屏请求：tab 内容各自按需加载，这里显式写空方法
  }

  // ② 业务：@gaction() 方法，生成的 switch 按签名强匹配到这里
  @gaction()
  void onTabChanged(int index) {
    if (index == currentIndex) {
      return; // 点当前 tab 不触发重建
    }
    currentIndex = index;
  }

  @gaction()
  void onReadAll() {
    if (unreadCount == 0) {
      return;
    }
    unreadCount = 0;
  }
}

// ===========================================================================
// View：只收 model（只读）+ dispatch（只写）
// ===========================================================================
class IndexView extends StatelessWidget {
  const IndexView({super.key, required this.model, required this.dispatch});

  final IndexModel model;
  final Dispatcher dispatch;

  @override
  Widget build(BuildContext context) {
    final PageState pageState = model.pageState;
    return Obs(
      builder: (BuildContext context) => switch (pageState.status) {
        PageStatus.loading => const Scaffold(body: LoadingView()),
        PageStatus.empty => Scaffold(
            body: EmptyHintView(
              text: pageState.message ?? '暂无内容',
              onRetry: () => dispatch(IndexModelIntents.tabChanged(0)),
            ),
          ),
        PageStatus.error => Scaffold(
            body: ErrorHintView(message: pageState.message ?? '加载失败'),
          ),
        PageStatus.content => _frame(context),
      },
    );
  }

  /// 内容态：tab 内容区 + 底部 tab 栏。
  ///
  /// 用 IndexedStack 而不是按 index 只 build 一个：四个 tab 一次建好、切换只换
  /// 显示哪一个，滚动位置和输入内容都不会丢（比 KeepAliveWrapper 更省事）。
  Widget _frame(BuildContext context) => Scaffold(
        body: IndexedStack(
          index: model.currentIndex,
          children: <Widget>[
            const HomeTabView(),
            const DiscoverTabView(),
            MessageTabView(
              unread: model.unreadCount,
              onReadAll: () => dispatch(IndexModelIntents.readAll()),
            ),
            const ProfileTabView(),
          ],
        ),
        bottomNavigationBar: XcBottomTabBar(
          currentIndex: model.currentIndex,
          onChanged: (int index) => dispatch(IndexModelIntents.tabChanged(index)),
          items: <XcTabItem>[
            const XcTabItem(icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: '首页'),
            const XcTabItem(icon: Icons.explore_outlined, activeIcon: Icons.explore, label: '发现'),
            XcTabItem(
              icon: Icons.forum_outlined,
              activeIcon: Icons.forum,
              label: '消息',
              badge: model.unreadCount,
            ),
            const XcTabItem(icon: Icons.person_outline, activeIcon: Icons.person, label: '我的'),
          ],
        ),
      );
}

// ===========================================================================
// Component：建 Model、拿 dispatch、吐 View
// ===========================================================================
@GRoute(IndexRoutes.page)
class IndexComponent extends Component<IndexModel> {
  const IndexComponent({super.key, super.route});

  /// 生成的接管实现：状态才具备响应式
  @override
  IndexModel createModel() => createIndexModel();

  /// 生成的 dispatch：switch 按签名强匹配 Action
  @override
  Dispatcher dispatcher(IndexModel model) => createIndexModelDispatcher(model);

  @override
  Widget buildView(BuildContext context, IndexModel model, Dispatcher dispatch) =>
      IndexView(model: model, dispatch: dispatch);
}
