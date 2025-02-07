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
  // final Size buttonSize = renderBox.size;
  //
  //
  //

  // フェードアニメーション用のAnimationControllerを動的に作成
  final AnimationController animationController =
      AnimationController(vsync: Navigator.of(context), duration: fadeDuration);

  final CurvedAnimation curvedAnimation = CurvedAnimation(parent: animationController, curve: Curves.easeInOut);

  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (BuildContext context) {
      return Positioned(
        left: buttonOffset.dx,
        top: buttonOffset.dy - 15,
        child: Material(
          color: Colors.transparent,
          child: FadeTransition(
            opacity: curvedAnimation,
            child: Text(
              message,
              style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    },
  );

  // Overlayに挿入 → フェードイン
  overlayState.insert(overlayEntry);
  animationController.forward();

  // 一定時間表示 → フェードアウト → entry を除去
  // ignore: always_specify_types
  Future.delayed(displayDuration, () async {
    await animationController.reverse();
    overlayEntry.remove();
    animationController.dispose();
  });
}
