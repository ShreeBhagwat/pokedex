import 'package:flutter/widgets.dart';

class RotatingImage extends StatefulWidget {
  const RotatingImage({
    super.key,
    this.image = 'images/pokeball.png',
  });

  final String image;

  @override
  State<RotatingImage> createState() => _RotatingImageState();
}

class _RotatingImageState extends State<RotatingImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
            angle: _controller.value * 3.14 * 2,
            child: Image.asset(widget.image, height: 250, width: 250));
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
