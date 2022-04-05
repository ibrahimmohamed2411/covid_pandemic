// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:date_format/date_format.dart';
// import 'package:covid_pandemic/data/models/news.dart';
//
// class NewsItem extends StatelessWidget {
//   final Article article;
//   const NewsItem({Key? key, required this.article}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           article.urlToImage.isNotEmpty
//               ? FadeInImage.assetNetwork(
//                   placeholder: 'assets/images/loading.gif',
//                   image: article.urlToImage,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   height: 250,
//                   imageErrorBuilder: (BuildContext context, Object ob,
//                       StackTrace? stakeTrace) {
//                     return Image.asset('assets/images/error.gif');
//                   },
//                 )
//               : Image.asset('assets/images/error.gif'),
//           Text(
//             article.title,
//             style: const TextStyle(
//               fontSize: 25,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//             overflow: TextOverflow.ellipsis,
//             maxLines: 2,
//             textAlign: TextAlign.start,
//           ),
//           const Divider(
//             color: Colors.grey,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 article.source.name,
//                 textAlign: TextAlign.start,
//               ),
//               Text(
//                 formatDate(article.publishedAt, [yyyy, '-', mm, '-', dd]),
//                 textAlign: TextAlign.start,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
