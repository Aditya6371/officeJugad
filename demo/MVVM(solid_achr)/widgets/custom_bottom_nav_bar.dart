import 'package:flutter/material.dart';

class CustomBottmNavBar extends StatelessWidget {
  const CustomBottmNavBar({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1,
            blurRadius: 30,
            offset: Offset(0, -1),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      child: BottomAppBar(
        color: Colors.transparent,
        shape: const CircularNotchedRectangle(),
        child: child,
      ),
    );
  }
}
