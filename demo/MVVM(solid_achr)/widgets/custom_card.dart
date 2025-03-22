// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:zero/models/models.dart';
// import 'package:zero/res/res.dart';
// import 'package:zero/utils/utils.dart';

// class ProductTile extends StatelessWidget {
//   const ProductTile({
//     super.key,
//     this.prod,
//     this.onTap,
//   });
//   final Function()? onTap;
//   final Product? prod;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: SizedBox(
//         width: Dimens.percentWidth(.45),
//         child: Card(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: ClipRRect(
//                   borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(12),
//                       topRight: Radius.circular(12)),
//                   // BorderRadius.circular(12),
//                   child: CachedNetworkImage(
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                     imageUrl: prod?.image?.isNotEmpty == true
//                         ? '${prod?.image?[0].image}'
//                         : '',
//                     errorWidget: (context, url, error) => SvgPicture.asset(
//                       AssetConstants.wediumlogo,
//                       height: 20,
//                       colorFilter: ColorFilter.mode(
//                         Colors.black.withOpacity(.4),
//                         BlendMode.dstIn,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Dimens.boxHeight10,
//               Padding(
//                 padding: Dimens.edgeInsets8_0,
//                 child: Text(
//                   prod?.name ?? "",
//                   style: Styles.black14.copyWith(
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: Dimens.edgeInsets8_0,
//                 child: Row(
//                   children: [
//                     Text(
//                       Utility.formatPrice(prod?.finalPrice ?? 0),
//                       style: Styles.black16w500
//                           .copyWith(color: Theme.of(context).primaryColor),
//                     ),
//                     if (prod?.discount != 0 ||
//                         prod?.discountPercentage != 0) ...[
//                       Dimens.boxWidth8,
//                       Text(
//                         Utility.formatPrice(prod?.price ?? 0),
//                         style: Styles.black14w500.copyWith(
//                             decoration: TextDecoration.lineThrough,
//                             color: Theme.of(context).disabledColor),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//               if (prod?.discount != 0 || prod?.discountPercentage != 0) ...[
//                 // Dimens.boxHeight4,
//                 Padding(
//                   padding: Dimens.edgeInsets8_0,
//                   child: Text(
//                     (prod?.discount ?? 0) > 0
//                         ? "Flat ${Utility.formatPrice(prod!.discount!)}"
//                         : "${prod?.discountPercentage}% off",
//                     style: Styles.black12w500
//                         .copyWith(color: ColorsValue.grey696969),
//                   ),
//                 ),
//               ],
//               Dimens.boxHeight10,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
