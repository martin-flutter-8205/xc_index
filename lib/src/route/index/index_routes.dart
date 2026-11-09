/// 跨包跳转只认这里的常量，页面类本身不外泄。
class IndexRoutes {
  IndexRoutes._();

  /// 主框架：启动页结束后 replace 到这里，之后一直是 App 的根。
  static const String page = 'index-page';
}
