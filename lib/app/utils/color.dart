import 'package:flutter/material.dart';

const primary = Color(0xFF8332A6);
const secondary = Color(0XFFBF2C98);
const background = Color(0XFFFBF2FF);
const clr_white = Colors.white;
const black = Colors.black;
const blue = Colors.blue;
const red = Colors.red;


// import 'package:flutter/material.dart';
// import 'package:flutter_vibrate/flutter_vibrate.dart';
// import 'package:get/get.dart';
// import 'package:mosq/app/modules/color.dart';
// import 'package:mosq/app/modules/tasbih/controllers/tasbih_controller.dart';
// import 'package:nb_utils/nb_utils.dart';

// class TasbihBiasa extends GetView<TasbihController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: MediaQuery.of(context).orientation == Orientation.portrait
//             ? Container(
//                 width: Get.width, height: Get.height, child: TasbihBiasaView())
//             : SingleChildScrollView(child: TasbihBiasaView()));
//   }
// }

// class TasbihBiasaView extends GetView<TasbihController> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               InkWell(
//                   onTap: () async {
//                     await showDialog(
//                         context: context,
//                         builder: (context) {
//                           return SimpleDialog(
//                             children: [
//                               Container(
//                                 width: 220,
//                                 height: 210,
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 8.0),
//                                   child: Column(
//                                     children: [
//                                       Align(
//                                         alignment: Alignment.topRight,
//                                         child: InkWell(
//                                           onTap: () => Get.back(),
//                                           child: Icon(Icons.cancel),
//                                         ),
//                                       ),
//                                       Text(
//                                         "Ubah Target Dzikir",
//                                         style: TextStyle(
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       10.height,
//                                       Text(
//                                           "Masukkan target dzikir yang anda inginkan"),
//                                       Form(
//                                         key: controller.form,
//                                         child: AppTextField(
//                                           textFieldType: TextFieldType.PHONE,
//                                           controller: controller.targetC,
//                                         ),
//                                       ),
//                                       15.height,
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.end,
//                                         children: [
//                                           InkWell(
//                                             onTap: () =>
//                                                 controller.targetC.clear(),
//                                             child: Icon(
//                                               Icons.cancel,
//                                               color: black,
//                                               size: 40,
//                                             ),
//                                           ),
//                                           5.width,
//                                           InkWell(
//                                             onTap: () {
//                                               if (controller.form.currentState!
//                                                   .validate()) {
//                                                 controller.target.value =
//                                                     int.parse(controller
//                                                         .targetC.text);
//                                                 Get.back();
//                                               }
//                                             },
//                                             child: Icon(
//                                               Icons.check_circle_rounded,
//                                               color: black,
//                                               size: 40,
//                                             ),
//                                           ),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ],
//                           );
//                         });
//                   },
//                   child: Container(
//                       height: 35,
//                       width: 35,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(35 / 2),
//                           border: Border.all(color: clr_primary, width: 2)),
//                       child: Center(
//                           child: Obx(() => SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: Text(
//                                 "${controller.target.value}",
//                                 style:
//                                     TextStyle(color: clr_primary, fontSize: 17),
//                               )))))),
//               10.width,
//               Obx(
//                 () => controller.efek.value == "suara"
//                     ? InkWell(
//                         onTap: () => controller.efek.value = "getar",
//                         child: Container(
//                             height: 35,
//                             width: 35,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(35 / 2),
//                                 border:
//                                     Border.all(color: clr_primary, width: 2)),
//                             child: Center(
//                                 child:
//                                     Icon(Icons.volume_up, color: clr_primary))))
//                     : controller.efek.value == "getar"
//                         ? InkWell(
//                             onTap: () => controller.efek.value = "diam",
//                             child: Container(
//                                 height: 35,
//                                 width: 35,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(35 / 2),
//                                     border: Border.all(
//                                         color: clr_primary, width: 2)),
//                                 child: Center(
//                                     child: Icon(Icons.vibration,
//                                         color: clr_primary))))
//                         : InkWell(
//                             onTap: () => controller.efek.value = "suara",
//                             child: Container(
//                                 height: 35,
//                                 width: 35,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(35 / 2),
//                                     border: Border.all(
//                                         color: clr_primary, width: 2)),
//                                 child: Center(
//                                     child: Icon(Icons.volume_off,
//                                         color: clr_primary)))),
//               ),
//               10.width,
//               InkWell(
//                   onTap: () => Get.defaultDialog(
//                         title: "Reset Total Hitung",
//                         middleText: "Apakah Anda Yakin?",
//                         textCancel: "Cancel",
//                         textConfirm: "Iya",
//                         confirmTextColor: white,
//                         buttonColor: black,
//                         cancelTextColor: black,
//                         onConfirm: () async {
//                           await controller.resettotal();
//                           Get.back();
//                         },
//                       ),
//                   child: Container(
//                       height: 35,
//                       width: 35,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(35 / 2),
//                           border: Border.all(color: clr_primary, width: 2)),
//                       child: Center(
//                           child: Icon(Icons.refresh, color: clr_primary)))),
//               10.width,
//               InkWell(
//                 onTap: () => controller.pilihWarna(context),
//                 child: Container(
//                     height: 35,
//                     width: 35,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(35 / 2),
//                         border: Border.all(color: clr_primary, width: 2)),
//                     child:
//                         Center(child: Icon(Icons.palette, color: clr_primary))),
//               ),
//               10.width,
//             ],
//           ),
//         ),
//         25.height,
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Obx(
//               () => Text(
//                 "${controller.angka}",
//                 style: TextStyle(fontSize: 40, color: clr_primary),
//               ),
//             ),
//             Text(
//               " / ",
//               style: TextStyle(fontSize: 25),
//             ),
//             InkWell(
//               onTap: () async {
//                 await showDialog(
//                     context: context,
//                     builder: (context) {
//                       return SimpleDialog(
//                         children: [
//                           Container(
//                             width: 220,
//                             height: 210,
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 8.0),
//                               child: Column(
//                                 children: [
//                                   Align(
//                                     alignment: Alignment.topRight,
//                                     child: InkWell(
//                                       onTap: () => Get.back(),
//                                       child: Icon(Icons.cancel),
//                                     ),
//                                   ),
//                                   Text(
//                                     "Ubah Target Dzikir",
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   10.height,
//                                   Text(
//                                       "Masukkan target dzikir yang anda inginkan"),
//                                   Form(
//                                     key: controller.form,
//                                     child: AppTextField(
//                                       textFieldType: TextFieldType.PHONE,
//                                       controller: controller.targetC,
//                                     ),
//                                   ),
//                                   15.height,
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       InkWell(
//                                         onTap: () => controller.targetC.clear(),
//                                         child: Icon(
//                                           Icons.cancel,
//                                           color: black,
//                                           size: 40,
//                                         ),
//                                       ),
//                                       5.width,
//                                       InkWell(
//                                         onTap: () {
//                                           if (controller.form.currentState!
//                                               .validate()) {
//                                             controller.target.value = int.parse(
//                                                 controller.targetC.text);
//                                             Get.back();
//                                           }
//                                         },
//                                         child: Icon(
//                                           Icons.check_circle_rounded,
//                                           color: black,
//                                           size: 40,
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           )
//                         ],
//                       );
//                     });
//               },
//               child: Obx(() => Text(
//                     "${controller.target.value}",
//                     style: TextStyle(fontSize: 25),
//                   )),
//             ),
//           ],
//         ),
//         Obx(() => Text(
//               "Total : ${controller.total}",
//               style: TextStyle(
//                 fontSize: 18,
//                 color: clr_primary,
//               ),
//             )),
//         5.height,
//         MediaQuery.of(context).orientation == Orientation.portrait
//             ? Expanded(
//                 child: InkWell(
//                     onTap: () async {
//                       if (controller.angka.value < controller.target.value) {
//                         controller.tambah();
//                         controller.efek.value == "suara"
//                             ? controller.player.play('audiotasbih.mp3')
//                             : InkWell();
//                         controller.efek.value == "getar"
//                             ? Vibrate.feedback(FeedbackType.medium)
//                             : InkWell();
//                       } else {
//                         controller.efek.value == "suara"
//                             ? Vibrate.vibrateWithPauses(controller.pauses)
//                             : InkWell();
//                         controller.efek.value == "getar"
//                             ? Vibrate.vibrateWithPauses(controller.pauses)
//                             : InkWell();
//                         await Get.defaultDialog(
//                           title: "Mulai Ulang",
//                           middleText: "Mulai dari nol lagi?",
//                           textCancel: "Cancel",
//                           textConfirm: "Iya",
//                           confirmTextColor: white,
//                           buttonColor: black,
//                           cancelTextColor: black,
//                           onConfirm: () async {
//                             await controller.resetangka();
//                             Get.back();
//                           },
//                         );
//                       }
//                     },
//                     child: Obx(() => Image.asset(
//                           "assets/tasbih_besar.png",
//                           alignment: Alignment.center,
//                           color: controller.currentColor.value,
//                         ))),
//               )
//             : Container(
//                 height: Get.height,
//                 width: Get.width,
//                 child: InkWell(
//                     onTap: () async {
//                       if (controller.angka.value < controller.target.value) {
//                         controller.tambah();
//                         controller.efek.value == "suara"
//                             ? controller.player.play('audiotasbih.mp3')
//                             : InkWell();
//                         controller.efek.value == "getar"
//                             ? Vibrate.feedback(FeedbackType.medium)
//                             : InkWell();
//                       } else {
//                         controller.efek.value == "suara"
//                             ? Vibrate.vibrateWithPauses(controller.pauses)
//                             : InkWell();
//                         controller.efek.value == "getar"
//                             ? Vibrate.vibrateWithPauses(controller.pauses)
//                             : InkWell();
//                         await Get.defaultDialog(
//                           title: "Mulai Ulang",
//                           middleText: "Mulai dari nol lagi?",
//                           textCancel: "Cancel",
//                           textConfirm: "Iya",
//                           confirmTextColor: white,
//                           buttonColor: black,
//                           cancelTextColor: black,
//                           onConfirm: () async {
//                             await controller.resetangka();
//                             Get.back();
//                           },
//                         );
//                       }
//                     },
//                     child: Obx(() => Image.asset(
//                           "assets/tasbih_besar.png",
//                           alignment: Alignment.topCenter,
//                           color: controller.currentColor.value,
//                         ))),
//               )
//       ],
//     );
//   }
// }
