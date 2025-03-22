// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:zero/res/res.dart';
// import 'package:zero/widgets/widgets.dart';

// class ProductShimmer extends StatelessWidget {
//   const ProductShimmer({
//     super.key,
//     required this.showList,
//   });

//   final bool showList;

//   @override
//   Widget build(BuildContext context) {
//     return showList
//         ? Shimmer.fromColors(
//             baseColor: Colors.grey.shade300,
//             highlightColor: Colors.white,
//             child: ListView.builder(
//               padding: Dimens.edgeInsets8_0,
//               scrollDirection: Axis.horizontal,
//               itemCount: 6,
//               itemBuilder: (context, index) {
//                 return const ProductTile();
//               },
//             ),
//           )
//         : Shimmer.fromColors(
//             baseColor: Colors.grey.shade300,
//             highlightColor: Colors.white,
//             child: GridView.builder(
//               padding: Dimens.edgeInsets8,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 4,
//                 crossAxisSpacing: 4,
//               ),
//               itemCount: 4,
//               itemBuilder: (context, index) {
//                 return const ProductTile();
//               },
//             ),
//           );
//   }
// }
