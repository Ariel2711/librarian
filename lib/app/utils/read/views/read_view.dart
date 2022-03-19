// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:librarian/app/data/models/book_model.dart';
// import 'package:librarian/app/routes/app_pages.dart';
// import 'package:librarian/app/utils/color.dart';
// import '../controllers/read_controller.dart';

// class ReadView extends GetView<ReadController> {
//   Book book = Get.arguments ?? Book();
//   RxBool showEdit = false.obs;
//   @override
//   Widget build(BuildContext context) {
//     controller.modelToController(book);
//     return Scaffold(
//       backgroundColor: background,
//       body: NestedScrollView(
//         headerSliverBuilder: (context, innerBoxIsScrolled) => [
//           SliverAppBar(
//             expandedHeight: 240,
//             flexibleSpace: FlexibleSpaceBar(
//               background: controller.imagePath.value != ''
//                   ? Container(
//                       width: 600,
//                       height: 350,
//                       child: Center(
//                           child:
//                               Image(image: AssetImage("assets/default.png"))),
//                       decoration: BoxDecoration(
//                         color: white,
//                       ),
//                     )
//                   : book.image != null
//                       ? Container(
//                           width: 600,
//                           height: 200,
//                           child: Image.network(
//                             book.image!,
//                             fit: BoxFit.cover,
//                           ),
//                           decoration: BoxDecoration(
//                             color: white,
//                           ),
//                         )
//                       : Container(
//                           width: 600,
//                           height: 350,
//                           child: Center(
//                               child: Image(
//                                   image: AssetImage("assets/default.png"))),
//                           decoration: BoxDecoration(
//                             color: white,
//                           ),
//                         ),
//             ),
//           )
//         ],
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(children: [
//               SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     controller.judulC != ''
//                         ? Text(
//                             book.judul!,
//                             style: TextStyle(color: white, fontSize: 30),
//                           )
//                         : book.judul != null
//                             ? Text(
//                                 book.judul!,
//                                 style: TextStyle(color: white, fontSize: 30),
//                               )
//                             : Text("Judul"),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                         "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque fringilla tempor sollicitudin. Maecenas cursus sapien vitae eros rutrum tincidunt. Proin felis sapien, cursus ac neque eu, vulputate posuere nulla. In nunc elit, consectetur eu sem et, rutrum lacinia lorem. Pellentesque ut lorem at ante convallis vulputate ac id nisl. Donec accumsan justo augue, sed porttitor metus commodo vehicula. Morbi varius, orci ut faucibus viverra, turpis libero egestas augue, sed aliquam mi elit et enim. Phasellus hendrerit nisi sit amet porta tincidunt. In purus nisi, dictum eu pellentesque luctus, tincidunt a lectus Maecenas dui purus, fringilla et auctor eu, efficitur a nislLorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque fringilla tempor sollicitudin. Maecenas cursus sapien vitae eros rutrum tincidunt. Proin felis sapien, cursus ac neque eu, vulputate posuere nulla. In nunc elit, consectetur eu sem et, rutrum lacinia lorem. Pellentesque ut lorem at ante convallis vulputate ac id nisl. Donec accumsan justo augue, sed porttitor metus commodo vehicula. Morbi varius, orci ut faucibus viverra, turpis libero egestas augue, sed aliquam mi elit et enim. Phasellus hendrerit nisi sit amet porta tincidunt. In purus nisi, dictum eu pellentesque luctus, tincidunt a lectus Maecenas dui purus, fringilla et auctor eu, efficitur a nislLorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque fringilla tempor sollicitudin. Maecenas cursus sapien vitae eros rutrum tincidunt. Proin felis sapien, cursus ac neque eu, vulputate posuere nulla. In nunc elit, consectetur eu sem et, rutrum lacinia lorem. Pellentesque ut lorem at ante convallis vulputate ac id nisl. Donec accumsan justo augue, sed porttitor metus commodo vehicula. Morbi varius, orci ut faucibus viverra, turpis libero egestas augue, sed aliquam mi elit et enim. Phasellus hendrerit nisi sit amet porta tincidunt. In purus nisi, dictum eu pellentesque luctus, tincidunt a lectus Maecenas dui purus, fringilla et auctor eu, efficitur a nislLorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque fringilla tempor sollicitudin. Maecenas cursus sapien vitae eros rutrum tincidunt. Proin felis sapien, cursus ac neque eu, vulputate posuere nulla. In nunc elit, consectetur eu sem et, rutrum lacinia lorem. Pellentesque ut lorem at ante convallis vulputate ac id nisl. Donec accumsan justo augue, sed porttitor metus commodo vehicula. Morbi varius, orci ut faucibus viverra, turpis libero egestas augue, sed aliquam mi elit et enim. Phasellus hendrerit nisi sit amet porta tincidunt. In purus nisi, dictum eu pellentesque luctus, tincidunt a lectus Maecenas dui purus, fringilla et auctor eu, efficitur a nislLorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque fringilla tempor sollicitudin. Maecenas cursus sapien vitae eros rutrum tincidunt. Proin felis sapien, cursus ac neque eu, vulputate posuere nulla. In nunc elit, consectetur eu sem et, rutrum lacinia lorem. Pellentesque ut lorem at ante convallis vulputate ac id nisl. Donec accumsan justo augue, sed porttitor metus commodo vehicula. Morbi varius, orci ut faucibus viverra, turpis libero egestas augue, sed aliquam mi elit et enim. Phasellus hendrerit nisi sit amet porta tincidunt. In purus nisi, dictum eu pellentesque luctus, tincidunt a lectus Maecenas dui purus, fringilla et auctor eu, efficitur a nisl.",
//                         style: TextStyle(color: black)),
//                   ],
//                 ),
//               ),
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // class ReadBook extends GetView<ReadController> {
// //   ReadBook({required this.book});
// //   Book book;
// //   @override
// //   Widget build(BuildContext context) {
// //     return SingleChildScrollView(
// //       child: Column(
// //         children: [
// //           controller.judulC != ''
// //               ? Text("")
// //               : book.image != null
// //                   ? Text(book.judul!, style: TextStyle(color: white,fontSize: 30),)
// //                   : Text("data"),
// //           SizedBox(
// //             height: 20,
// //           ),
// //           controller.imagePath.value != ''
// //               ? Padding(
// //                   padding: const EdgeInsets.all(10),
// //                   child: Container(
// //                     width: 400,
// //                     height: 200,
// //                     child: Image.file(
// //                       File(controller.imagePath.value),
// //                       fit: BoxFit.cover,
// //                     ),
// //                     decoration: BoxDecoration(
// //                       color: white,
// //                       borderRadius: BorderRadius.circular(20),
// //                     ),
// //                   ),
// //                 )
// //               : book.image != null
// //                   ? Padding(
// //                       padding: const EdgeInsets.all(10),
// //                       child: Container(
// //                         width: 400,
// //                         height: 200,
// //                         child: Image.network(
// //                           book.image!,
// //                           fit: BoxFit.cover,
// //                         ),
// //                         decoration: BoxDecoration(
// //                           color: white,
// //                           borderRadius: BorderRadius.circular(20),
// //                         ),
// //                       ),
// //                     )
// //                   : Padding(
// //                       padding: const EdgeInsets.all(10),
// //                       child: Container(
// //                         width: 400,
// //                         height: 200,
// //                         child: Center(
// //                             child:
// //                                 Image(image: AssetImage("assets/default.png"))),
// //                         decoration: BoxDecoration(
// //                           color: white,
// //                           borderRadius: BorderRadius.circular(20),
// //                         ),
// //                       ),
// //                     ),
// //           Text("Lorem"),
// //         ],
// //       ),
// //     );
// //   }
// // }
