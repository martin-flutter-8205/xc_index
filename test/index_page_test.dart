// Flutter 自带的 Action 与框架的 Action 重名，这里只隐藏 Flutter 那个
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_test/flutter_test.dart';
import 'package:xc_index/src/route/index/index_page_com.dart';
import 'package:xc_platform/xc_platform.dart';

void main() {
  late IndexModel model;
  late Dispatcher dispatch;

  setUp(() {
    model = createIndexModel();
    dispatch = createIndexModelDispatcher(model);
  });

  tearDown(() => model.dispose());

  test('tab 切换与全部已读都走 dispatch', () {
    expect(model.currentIndex, 0);
    expect(model.unreadCount, 2);

    dispatch(IndexModelIntents.tabChanged(2));
    expect(model.currentIndex, 2);

    // 点当前 tab：状态不动（不触发无意义重建）
    dispatch(IndexModelIntents.tabChanged(2));
    expect(model.currentIndex, 2);

    dispatch(IndexModelIntents.readAll());
    expect(model.unreadCount, 0);

    // 已读之后再点一次：幂等
    dispatch(IndexModelIntents.readAll());
    expect(model.unreadCount, 0);
  });

  test('payload 类型对不上：落到 default 抛错，不会被当成字符串下标', () {
    expect(
      () => dispatch(const Action('IndexModel.onTabChanged', <Object?>['2'])),
      throwsArgumentError,
    );
    expect(model.currentIndex, 0);
  });

  test('参数个数对不上：同样抛错', () {
    expect(
      () => dispatch(const Action('IndexModel.onTabChanged', <Object?>[1, 2])),
      throwsArgumentError,
    );
  });

  testWidgets('点 tab 换内容：只换 IndexedStack 的显示项，不重建整页', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: IndexView(model: model, dispatch: dispatch)),
    );
    await tester.pump();

    // 默认首页
    expect(model.currentIndex, 0);
    expect(find.text('今晚的星空电台').hitTestable(), findsOneWidget);
    expect(find.text('发现新的声音').hitTestable(), findsNothing);

    await tester.tap(find.text('发现'));
    await tester.pump();

    expect(model.currentIndex, 1);
    expect(find.text('发现新的声音').hitTestable(), findsOneWidget);
    expect(find.text('今晚的星空电台').hitTestable(), findsNothing);
  });

  testWidgets('消息 tab：角标来自 Model，全部已读后角标消失', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: IndexView(model: model, dispatch: dispatch)),
    );
    await tester.pump();

    // 角标是 Model 的 unreadCount
    expect(find.text('2'), findsOneWidget);

    await tester.tap(find.text('消息'));
    await tester.pump();
    expect(find.text('消息中心').hitTestable(), findsOneWidget);

    await tester.tap(find.byKey(const Key('message-read-all')));
    await tester.pump();

    expect(model.unreadCount, 0);
    expect(find.text('2'), findsNothing);
    expect(find.text('消息都读完啦').hitTestable(), findsOneWidget);
    expect(find.byKey(const Key('message-read-all')), findsNothing);
  });
}
