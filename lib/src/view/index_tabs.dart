import 'package:flutter/material.dart';

/// 主框架四个 tab 的内容视图。
///
/// 这里全是纯展示：不建 Model、不拿 dispatch。需要交互的地方由外层把回调传进来
/// —— tab 之间没有共享状态，没必要每屏都起一套三件套。
///
/// 真正需要独立状态的子页（列表刷新、分页、表单）再按约定写 `xxx_page_com.dart`，
/// 由生成器接管；「代码不做过度细化」不等于「什么都塞进一个类」。

// ===========================================================================
// 首页
// ===========================================================================
class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('晚上好', style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant)),
                    const SizedBox(height: 4),
                    Text(
                      '星际旅人',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: scheme.onSurface),
                    ),
                  ],
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none_rounded)),
            ],
          ),
          const SizedBox(height: 20),
          const _HeroCard(),
          const SizedBox(height: 26),
          const _SectionTitle('正在热播'),
          const SizedBox(height: 12),
          const _TrackTile(index: 0, title: '银河回声', subtitle: '环境音 · 42 分钟'),
          const _TrackTile(index: 1, title: '午夜低频', subtitle: '助眠 · 1 小时 08 分'),
          const _TrackTile(index: 2, title: '远方的雨', subtitle: '白噪音 · 35 分钟'),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      height: 168,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[scheme.primary, const Color(0xFF2B1F5E)],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(color: scheme.primary.withValues(alpha: 0.25), blurRadius: 26, offset: const Offset(0, 12)),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            right: -18,
            bottom: -26,
            child: Icon(
              Icons.graphic_eq_rounded,
              size: 132,
              color: Colors.white.withValues(alpha: 0.12),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                '今晚的星空电台',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
              ),
              const SizedBox(height: 6),
              Text(
                '12 首 · 38 分钟',
                style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.75)),
              ),
              const Spacer(),
              Row(
                children: <Widget>[
                  FilledButton.icon(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF161B3D),
                    ),
                    icon: const Icon(Icons.play_arrow_rounded, size: 20),
                    label: const Text('立即收听'),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '每晚 22:00 更新',
                    style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.7)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Row(
      children: <Widget>[
        Container(
          width: 3,
          height: 14,
          decoration: BoxDecoration(color: scheme.primary, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: scheme.onSurface),
        ),
      ],
    );
  }
}

class _TrackTile extends StatelessWidget {
  const _TrackTile({required this.index, required this.title, required this.subtitle});

  final int index;
  final String title;
  final String subtitle;

  static const List<List<Color>> _covers = <List<Color>>[
    <Color>[Color(0xFF5B6CFF), Color(0xFF2A2470)],
    <Color>[Color(0xFF8E5BFF), Color(0xFF3A1D5E)],
    <Color>[Color(0xFF33C3C0), Color(0xFF173F4A)],
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: <Widget>[
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: LinearGradient(colors: _covers[index % _covers.length]),
            ),
            child: Icon(Icons.music_note_rounded, color: Colors.white.withValues(alpha: 0.8)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: scheme.onSurface),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant)),
              ],
            ),
          ),
          Icon(Icons.play_circle_outline_rounded, color: scheme.onSurfaceVariant),
        ],
      ),
    );
  }
}

// ===========================================================================
// 发现
// ===========================================================================
class DiscoverTabView extends StatelessWidget {
  const DiscoverTabView({super.key});

  static const List<String> _filters = <String>['全部', '电台', '白噪音', '助眠', '清晨', '深夜'];

  static const List<String> _topics = <String>['星际电台', '深空白噪', '雨夜车厢', '晨光序曲', '山谷回声', '低频宇宙'];

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
        children: <Widget>[
          Text(
            '发现新的声音',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: scheme.onSurface),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              for (final String filter in _filters)
                ChoiceChip(
                  label: Text(filter),
                  selected: filter == '全部',
                  showCheckmark: false,
                  onSelected: (_) {},
                ),
            ],
          ),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.92,
            children: <Widget>[
              for (int i = 0; i < _topics.length; i++) _TopicCard(index: i, title: _topics[i]),
            ],
          ),
        ],
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  const _TopicCard({required this.index, required this.title});

  final int index;
  final String title;

  static const List<List<Color>> _covers = <List<Color>>[
    <Color>[Color(0xFF5B6CFF), Color(0xFF1B1B4B)],
    <Color>[Color(0xFF8E5BFF), Color(0xFF2A1640)],
    <Color>[Color(0xFF33C3C0), Color(0xFF123238)],
    <Color>[Color(0xFFFF8A65), Color(0xFF4A1F1B)],
    <Color>[Color(0xFF7C8CFF), Color(0xFF232A55)],
    <Color>[Color(0xFF4DB6AC), Color(0xFF14332F)],
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _covers[index % _covers.length],
              ),
            ),
            child: Icon(
              Icons.graphic_eq_rounded,
              size: 36,
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: scheme.onSurface),
        ),
        const SizedBox(height: 2),
        Text(
          '${(index + 1) * 7} 个节目',
          style: TextStyle(fontSize: 11, color: scheme.onSurfaceVariant),
        ),
      ],
    );
  }
}

// ===========================================================================
// 消息
// ===========================================================================
class MessageTabView extends StatelessWidget {
  const MessageTabView({super.key, required this.unread, required this.onReadAll});

  /// 未读数由 Model 给，View 不自己算。
  final int unread;

  /// 「全部已读」的动作由外层 dispatch，View 不碰状态。
  final VoidCallback onReadAll;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  '消息中心',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: scheme.onSurface),
                ),
              ),
              if (unread > 0)
                TextButton(
                  key: const Key('message-read-all'),
                  onPressed: onReadAll,
                  child: const Text('全部已读'),
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (unread == 0)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 64),
              child: Center(
                child: Text(
                  '消息都读完啦',
                  style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
                ),
              ),
            )
          else ...<Widget>[
            const _MessageTile(
              title: '系统通知',
              body: '欢迎来到响彻星空，去发现属于你的声音。',
              unread: true,
            ),
            const _MessageTile(
              title: '节目更新',
              body: '《银河回声》更新了第 12 期。',
              unread: true,
            ),
            const _MessageTile(
              title: '收听提醒',
              body: '你订阅的深夜电台今晚 22:00 开播。',
              unread: false,
            ),
          ],
        ],
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({required this.title, required this.body, required this.unread});

  final String title;
  final String body;
  final bool unread;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.22)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 6, right: 10),
            child: Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: unread ? scheme.primary : Colors.transparent,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: unread ? FontWeight.w600 : FontWeight.w400,
                    color: scheme.onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                Text(body, style: TextStyle(fontSize: 12, height: 1.4, color: scheme.onSurfaceVariant)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// 我的
// ===========================================================================
class ProfileTabView extends StatelessWidget {
  const ProfileTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[scheme.primary, const Color(0xFF2B1F5E)],
                  ),
                ),
                child: const Icon(Icons.person_rounded, size: 34, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '星际旅人',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: scheme.onSurface),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '已连续收听 12 天',
                      style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: scheme.surface.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.22)),
            ),
            child: const Row(
              children: <Widget>[
                _StatCell(value: '36', label: '收藏'),
                _StatCell(value: '8', label: '关注'),
                _StatCell(value: '214', label: '收听'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const _ProfileTile(icon: Icons.bookmark_border_rounded, title: '我的收藏'),
          const _ProfileTile(icon: Icons.history_rounded, title: '收听历史'),
          const _ProfileTile(icon: Icons.headphones_rounded, title: '音质与下载'),
          const _ProfileTile(icon: Icons.settings_outlined, title: '设置'),
        ],
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: scheme.onSurface),
          ),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 11, color: scheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon, size: 20, color: scheme.onSurfaceVariant),
          title: Text(title, style: TextStyle(fontSize: 14, color: scheme.onSurface)),
          trailing: Icon(Icons.chevron_right_rounded, size: 20, color: scheme.onSurfaceVariant),
          onTap: () {},
        ),
        Divider(color: scheme.outlineVariant.withValues(alpha: 0.2), height: 1),
      ],
    );
  }
}
