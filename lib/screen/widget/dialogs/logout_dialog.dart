import 'package:flutter/material.dart';

class LogoutDialog {
  static void show(BuildContext context) {
    debugPrint("🔔 [LogoutDialog] show() dipanggil");

    showGeneralDialog(
      context: context,
      barrierLabel: "Logout Dialog",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => const SizedBox(),
      transitionBuilder: (context, animation, _, __) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );

        return ScaleTransition(
          scale: curved,
          child: FadeTransition(
            opacity: animation,
            child: const _LogoutDialogContent(),
          ),
        );
      },
    );
  }
}

class _LogoutDialogContent extends StatelessWidget {
  const _LogoutDialogContent();

  @override
  Widget build(BuildContext context) {
    debugPrint("🧩 [LogoutDialog] UI dibangun");

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.logout, size: 56, color: Colors.red.shade500),
              const SizedBox(height: 16),
              const Text(
                "Keluar dari Akun?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Anda akan keluar dari akun COCOA-SENSE",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _AnimatedButton(
                      text: "Batal",
                      color: Colors.green,
                      onTap: () {
                        debugPrint("❎ [LogoutDialog] Batal ditekan");
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _AnimatedButton(
                      text: "Keluar",
                      color: Colors.red,
                      onTap: () {
                        debugPrint("✅ [LogoutDialog] Keluar ditekan");
                        Navigator.pop(context);
                        _showSuccess(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedButton extends StatefulWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;

  const _AnimatedButton({
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  State<_AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton> {
  double scale = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => scale = 0.95),
      onTapUp: (_) {
        setState(() => scale = 1);
        widget.onTap();
      },
      onTapCancel: () => setState(() => scale = 1),
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 120),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _showSuccess(BuildContext context) {
  debugPrint("🎉 [LogoutDialog] Menampilkan dialog sukses");

  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.3),
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (_, __, ___) => const SizedBox(),
    transitionBuilder: (context, animation, _, __) {
      return ScaleTransition(
        scale: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: FadeTransition(
          opacity: animation,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.green.shade600,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                "Berhasil keluar",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
    },
  );

  Future.delayed(const Duration(seconds: 2), () {
    debugPrint("⏱️ [LogoutDialog] Dialog sukses ditutup otomatis");
    Navigator.of(context, rootNavigator: true).pop();
  });
}
