# xc_index

主框架业务包（独立 git 仓库）：底部 TabBar + 四个 tab 页，App 的常驻外壳。

## 对外出口

- `IndexModule`：路由表（`@GRoute` 生成）+ 全局浮层（`GlobalPopUpView`）+ 启动期预热
- `IndexRoutes.*`：路由名常量

## 依赖

- `xc_platform` / `xc_ui`：独立 git 仓库，`git: { url, ref: main }` 接入

## 被谁引用

- `xc_app_module`（App 装配层）通过 git 依赖接入本仓库
- `xc_launch`（启动完成后跳转到主框架）以 path/git 依赖本仓库

```yaml
xc_index:
  git:
    url: <本仓库地址>
    ref: main
```

## 开发

```bash
flutter pub get
flutter analyze
flutter test
```
