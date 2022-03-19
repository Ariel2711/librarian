// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:librarian/app/data/models/book_model.dart';
// import 'package:librarian/app/modules/home/controllers/home_controller.dart';
// import 'package:librarian/app/routes/app_pages.dart';
// import 'package:librarian/app/utils/color.dart';
// import '../controllers/allbook_controller.dart';

// class AllbookView extends GetView<AllbookController> {
//   Book? book;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: NestedScrollView(
//         headerSliverBuilder: (context, innerBoxIsScrolled) => [
//           SliverAppBar(
//             title: Text("Book List"),
//             centerTitle: true,
//             expandedHeight: 186,
//             flexibleSpace: FlexibleSpaceBar(
//                 background: Container(
//               width: Get.width,
//               height: Get.height,
//               child: Center(
//                   child: Image(
//                 image: AssetImage("assets/library.jpg"),
//                 fit: BoxFit.cover,
//               )),
//               decoration: BoxDecoration(
//                 color: white,
//               ),
//             )),
//           )
//         ],
//         body: Container(
//           height: Get.height,
//           width: Get.width,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(colors: <Color>[
//               secondary,
//               primary,
//             ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
//             // borderRadius: BorderRadius.vertical(top: Radius.circular(20))
//           ),
//           padding: EdgeInsets.zero,
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(children: [
//                 Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: TextField(
//                       showCursor: true,
//                       cursorColor: white,
//                       style: TextStyle(color: white),
//                       textInputAction: TextInputAction.next,
//                       decoration: InputDecoration(
//                         hintText: "Input book name",
//                         hintStyle: TextStyle(color: white),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: white)),
//                         enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: white)),
//                         disabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: white)),
//                         label: Row(children: [
//                           Icon(
//                             Icons.search,
//                             color: white,
//                           ),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           Text(
//                             "Seacrh",
//                             style: TextStyle(color: white),
//                           ),
//                         ]),
//                         border: OutlineInputBorder(
//                             borderSide: BorderSide(color: white)),
//                       )),
//                 ),
//                 Column(
//                   children: [
//                     Obx(
//                       () => ListView.builder(
//                           shrinkWrap: true,
//                           physics: ScrollPhysics(),
//                           itemCount: controller.books.length,
//                           itemBuilder: (context, index) {
//                             if (controller.books.length > 0) {
//                               return SingleChildScrollView(
//                                   child: BookCard(
//                                       book: controller.books[index],
//                                       index: index));
//                             } else {
//                               return Center(
//                                 child: Image.asset("assets/default.png"),
//                               );
//                             }
//                           }),
//                     ),
//                   ],
//                 ),
//               ]),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class BookCard extends StatelessWidget {
//   int index;
//   Book book;
//   BookCard({required this.book, required this.index});
//   final controller = Get.put(HomeController());
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//           color: white, borderRadius: BorderRadius.circular(10)),
//       child: Container(
//         width: 1600,
//         height: 265,
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: Align(
//                   alignment: Alignment.topCenter,
//                   child: Container(
//                     height: 110,
//                     width: 280,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         image: DecorationImage(
//                             image: NetworkImage(book.image!),
//                             fit: BoxFit.cover)),
//                   )),
//             ),
//             Text(
//               book.judul!,
//               style: TextStyle(color: primary, fontSize: 30),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Card(
//               color: primary,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//                 child: Text(
//                   "${book.kategori}",
//                   style: TextStyle(color: white),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Column(
//                   children: [
//                     Icon(
//                       Icons.remove_red_eye_rounded,
//                       color: primary,
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text("${((index + 1) * 10)}",
//                         style: TextStyle(color: primary)),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Icon(
//                       Icons.thumb_up,
//                       color: primary,
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text("${((index + 1) * 5)}",
//                         style: TextStyle(color: primary)),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Icon(
//                       Icons.menu_book_sharp,
//                       color: primary,
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     // Text(book.page!, style: TextStyle(color: primary)),
//                   ],
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
