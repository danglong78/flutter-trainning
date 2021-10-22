import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({required this.height, required this.width, Key? key})
      : super(key: key);
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text("Loading", style: Theme.of(context).textTheme.headline6),
          ],
        ),
      ),
    );
  }
}
