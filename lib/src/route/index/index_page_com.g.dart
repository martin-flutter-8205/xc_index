// GENERATED CODE - DO NOT MODIFY BY HAND
// 由 xc_codegen 生成：dart run xc_codegen
part of 'index_page_com.dart';

/// IndexModel 的状态接管实现：Model 里声明的每个状态字段
/// 在这里被 Atom 接管（读走 getter 订阅、写走 setter 通知）。
/// 标了 @gignore 的字段不生成，保持声明原样、天然只读。
class _$IndexModelImpl extends IndexModel {
  late final Atom<int> _currentIndex = atom<int>(0);
  late final Atom<int> _unreadCount = atom<int>(2);

  @override
  int get currentIndex => _currentIndex.value;
  @override
  set currentIndex(int value) => _currentIndex.value = value;

  @override
  int get unreadCount => _unreadCount.value;
  @override
  set unreadCount(int value) => _unreadCount.value = value;
}

/// 供 Component.createModel 使用：返回状态接管实现。
IndexModel createIndexModel() => _$IndexModelImpl();

/// IndexModel 的意图工厂：按 @gaction 方法签名生成，参数顺序 = payload 顺序。
///
/// View 只从这里拿 Action：`dispatch(IndexModelIntents.submit(...))`；
/// Model 里不写 static Action（写了生成器会报 [ERROR]）。
abstract final class IndexModelIntents {
  static Action tabChanged(int index) => Action('IndexModel.onTabChanged', <Object?>[index]);
  static Action readAll() => Action('IndexModel.onReadAll', <Object?>[]);
}

/// IndexModel 的 dispatch：switch 按 Action 名 + payload 列表做签名强匹配。
///
/// 只有标注 @gaction 的业务方法才生成分支；普通方法不进 switch。
/// payload 是位置参数列表，顺序与 @gaction 方法的参数声明顺序一致；
/// 名字、个数或类型对不上都会落到 default 抛错，不会静默穿透。
/// 由 Component 持有（`Component.dispatcher`），Model 自己拿不到 dispatch。
Dispatcher createIndexModelDispatcher(IndexModel model) => (Action action) {
      switch (action) {
        case Action(name: 'IndexModel.onTabChanged', payload: [final int index]):
          model.onTabChanged(index);
        case Action(name: 'IndexModel.onReadAll', payload: []):
          model.onReadAll();
        default:
          throw ArgumentError.value(action.name, 'action', '未注册的 Action');
      }
    };
