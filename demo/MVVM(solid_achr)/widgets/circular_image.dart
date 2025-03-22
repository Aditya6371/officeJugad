import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularProfileImage extends StatelessWidget {
  const CircularProfileImage({
    super.key,
    required this.imageLink,
    this.height,
    this.width,
  });

  final String imageLink;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Theme.of(context).hintColor.withOpacity(0.1),
        ),
        child: CachedNetworkImage(
          imageUrl: imageLink,
          fit: BoxFit.fill,
          placeholder: (context, url) =>
              const CircularProgressIndicator.adaptive(),
          errorWidget: (context, url, error) => Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).hintColor),
              borderRadius: BorderRadius.circular(100),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Icon(
              Icons.person_rounded,
              size: 22,
              color: Theme.of(context).hintColor,
            ),
          ),
        ),
      ),
    );
  }
}
