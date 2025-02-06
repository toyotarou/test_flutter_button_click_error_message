// error_overlay.dart
import 'package:flutter/material.dart';

/// ボタンの位置に合わせてエラーをOverlay表示する関数
///
/// [buttonKey] : エラーを表示したいボタンのGlobalKey
/// [message]   : 表示するメッセージ
/// [displayDuration] : 表示している時間
/// [fadeDuration]    : フェードイン・アウトにかける時間
void showButtonErrorOverlay({
  required BuildContext context,
  required GlobalKey buttonKey,
  required String message,
  Duration displayDuration = const Duration(seconds: 1),
  Duration fadeDuration = const Duration(milliseconds: 300),
}) {
  // Overlayを取得
  final OverlayState overlayState = Overlay.of(context);

  // ボタンのRenderBoxから位置を取得
  final RenderBox? renderBox = buttonKey.currentContext?.findRenderObject() as RenderBox?;
  if (renderBox == null) {
    return;
  }

  final Offset buttonOffset = renderBox.localToGlobal(Offset.zero);
  final Size buttonSize = renderBox.size;

  // フェードアニメーション用のAnimationControllerを動的に作成
  final AnimationController controller = AnimationController(
    vsync: Navigator.of(context), // or 'TickerProviderStateMixin'を持つStateクラス
    duration: fadeDuration,
  );
  final CurvedAnimation fadeAnimation = CurvedAnimation(
    parent: controller,
    curve: Curves.easeInOut,
  );

  late OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (BuildContext context) {
      return Positioned(
        // ボタンを基準に、少し上に表示
        // （中央揃えにしたければwidth計算などを調整）
        left: buttonOffset.dx + (buttonSize.width / 2) - 70,
        top: buttonOffset.dy - 40,
        child: Material(
          color: Colors.transparent,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: Container(
              width: 140, // エラー表示の横幅を固定する例
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
    },
  );

  // Overlayに挿入 → フェードイン
  overlayState.insert(overlayEntry);
  controller.forward();

  // 一定時間表示 → フェードアウト → entry を除去
  // ignore: always_specify_types
  Future.delayed(displayDuration, () async {
    await controller.reverse();
    overlayEntry.remove();
    controller.dispose();
  });
}
