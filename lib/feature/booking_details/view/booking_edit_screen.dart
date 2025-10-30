



// import 'package:demandium_serviceman/utils/core_export.dart';
// import 'package:get/get.dart';
// import 'package:demandium_serviceman/helper/booking_helper.dart';
// import 'package:demandium_serviceman/feature/booking_details/model/booking_details_model.dart';
//
// class AdditionalServiceWidget extends StatelessWidget {
//   final Map<String, dynamic> service;
//   final int index;
//   final bool isSubBooking;
//   final BookingEditController controller;
//
//   const AdditionalServiceWidget({
//     Key? key,
//     required this.service,
//     required this.index,
//     required this.isSubBooking,
//     required this.controller,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//         boxShadow: [
//           BoxShadow(
//             color: Theme.of(context).shadowColor.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 5,
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
//       child: Row(
//         children: [
//           // ClipRRect(
//           //   borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//           //   child: CustomImage(
//           //     image: service['service_thumbnail'] ?? '',
//           //     height: 40,
//           //     width: 40,
//           //     fit: BoxFit.cover,
//           //   ),
//           // ),
//           const SizedBox(width: Dimensions.paddingSizeSmall),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   service['service_name'] ?? 'Unknown',
//                   style: robotoMedium.copyWith(
//                     fontSize: Dimensions.fontSizeDefault,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: Dimensions.paddingSizeExtraSmall),
//                 Text(
//                   '${PriceConverter.convertPrice(double.tryParse(service['service_amount'].toString()) ?? 0.0)}',
//                   //' x ${service['quantity'] ?? 1}',
//                   style: robotoRegular.copyWith(
//                     fontSize: Dimensions.fontSizeSmall,
//                     color: Theme.of(context).hintColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             children: [
//               // InkWell(
//               //   onTap: () => controller.decrementServiceQuantity(index),
//               //   child: Container(
//               //     padding: const EdgeInsets.all(2),
//               //     decoration: BoxDecoration(
//               //       border: Border.all(color: Theme.of(context).hintColor),
//               //       borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//               //     ),
//               //     child: Icon(
//               //       Icons.remove,
//               //       size: 16,
//               //       color: Theme.of(context).hintColor,
//               //     ),
//               //   ),
//               // ),
//               // Padding(
//               //   padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
//               //   child: Text(
//               //     service['quantity'].toString(),
//               //     style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
//               //   ),
//               // ),
//               // InkWell(
//               //   onTap: () => controller.incrementServiceQuantity(index),
//               //   child: Container(
//               //     padding: const EdgeInsets.all(2),
//               //     decoration: BoxDecoration(
//               //       border: Border.all(color: Theme.of(context).primaryColor),
//               //       borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//               //     ),
//               //     child: Icon(
//               //       Icons.add,
//               //       size: 16,
//               //       color: Theme.of(context).primaryColor,
//               //     ),
//               //   ),
//               // ),
//               const SizedBox(width: Dimensions.paddingSizeSmall),
//               InkWell(
//                 onTap: () => controller.removeServiceData(index),
//                 child: Icon(
//                   Icons.delete,
//                   color: Theme.of(context).colorScheme.error,
//                   size: 20,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class BookingEditScreen extends StatefulWidget {
//   final bool isSubBooking;
//   const BookingEditScreen({super.key, required this.isSubBooking});
//
//   @override
//   State<BookingEditScreen> createState() => _BookingEditScreenState();
// }
//
// class _BookingEditScreenState extends State<BookingEditScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Get.find<BookingEditController>().initializedControllerValue(
//         Get.find<BookingDetailsController>()
//             .bookingDetails
//             ?.bookingContent
//             ?.bookingDetailsContent);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: "edit_booking".tr),
//       body: GetBuilder<BookingEditController>(builder: (bookingEditController) {
//         final BookingDetailsContent? bookingDetails =
//             Get.find<BookingDetailsController>()
//                 .bookingDetails
//                 ?.bookingContent
//                 ?.bookingDetailsContent;
//
//         return Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       //const PaymentStatusButton(),
//                       const SizedBox(height: Dimensions.paddingSizeDefault),
//                       Container(
//                         width: Get.width,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: Dimensions.paddingSizeLarge),
//                         decoration: BoxDecoration(
//                           color:
//                           Theme.of(context).cardColor.withValues(alpha: 0.1),
//                           borderRadius:
//                           BorderRadius.circular(Dimensions.paddingSizeSmall),
//                           border: Border.all(
//                               color: Theme.of(context)
//                                   .primaryColor
//                                   .withValues(alpha: 0.2),
//                               width: 1),
//                         ),
//                         child: DropdownButtonHideUnderline(
//                           child: DropdownButton(
//                             dropdownColor: Theme.of(context).cardColor,
//                             borderRadius: BorderRadius.circular(5),
//                             elevation: 2,
//                             hint: Text(
//                               bookingEditController.selectedBookingStatus == ''
//                                   ? "select_booking_status".tr
//                                   : "${'booking_status'.tr} : ${bookingEditController.selectedBookingStatus.tr}",
//                               style: robotoRegular.copyWith(
//                                   color: bookingEditController
//                                       .selectedBookingStatus ==
//                                       ''
//                                       ? Theme.of(context)
//                                       .textTheme
//                                       .bodyLarge!
//                                       .color!
//                                       .withValues(alpha: 0.6)
//                                       : Theme.of(context)
//                                       .textTheme
//                                       .bodyLarge!
//                                       .color!
//                                       .withValues(alpha: 0.8)),
//                             ),
//                             icon: const Icon(Icons.keyboard_arrow_down),
//                             items: bookingEditController.statusTypeList
//                                 .map((String items) {
//                               return DropdownMenuItem(
//                                 value: items,
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       items.tr,
//                                       style: robotoRegular.copyWith(
//                                         color: Theme.of(context)
//                                             .textTheme
//                                             .bodyLarge!
//                                             .color!
//                                             .withValues(alpha: 0.8),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }).toList(),
//                             onChanged: (String? newValue) {
//                               if (Get.find<BookingDetailsController>()
//                                   .bookingDetails
//                                   ?.bookingContent
//                                   ?.bookingDetailsContent
//                                   ?.bookingStatus ==
//                                   "ongoing" &&
//                                   newValue?.toLowerCase() == "accepted") {
//                                 showCustomSnackBar(
//                                     'service_is_already_ongoing'.tr,
//                                     type: ToasterMessageType.info);
//                                 bookingEditController
//                                     .changeBookingStatusDropDownValue("ongoing");
//                               } else {
//                                 bookingEditController
//                                     .changeBookingStatusDropDownValue(newValue!);
//                               }
//                             },
//                           ),
//                         ),
//                       ),
//                       TextFieldTitle(
//                         title: "service_schedule".tr,
//                         fontSize: Dimensions.fontSizeLarge,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                             color: Theme.of(context)
//                                 .cardColor
//                                 .withValues(alpha: 0.1),
//                             borderRadius: BorderRadius.circular(
//                                 Dimensions.paddingSizeSmall),
//                             border: Border.all(
//                                 color: Theme.of(context)
//                                     .primaryColor
//                                     .withValues(alpha: 0.2),
//                                 width: 1)),
//                         margin: const EdgeInsets.only(
//                             bottom: Dimensions.paddingSizeDefault),
//                         padding: const EdgeInsets.only(
//                             left: Dimensions.paddingSizeDefault),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             (bookingEditController.scheduleTime != null)
//                                 ? Text(
//                               DateConverter.dateMonthYearTime(
//                                   DateTime.tryParse(bookingEditController
//                                       .scheduleTime!)),
//                               style: robotoRegular.copyWith(
//                                   fontSize: Dimensions.fontSizeDefault),
//                               textDirection: TextDirection.ltr,
//                             )
//                                 : const SizedBox(),
//                             const SizedBox(width: Dimensions.paddingSizeDefault),
//                             IconButton(
//                               onPressed: () => bookingEditController.selectDate(),
//                               icon: Icon(
//                                 Icons.calendar_month_outlined,
//                                 color: Theme.of(context)
//                                     .primaryColor
//                                     .withValues(alpha: 0.5),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'service_list'.tr,
//                             style: robotoMedium.copyWith(
//                                 color: Theme.of(context).primaryColor,
//                                 fontSize: Dimensions.fontSizeLarge),
//                           ),
//                           if (!widget.isSubBooking)
//                             TextButton(
//                               onPressed:
//                               bookingEditController.cartList.length == 1 &&
//                                   bookingEditController
//                                       .cartList[0].variantKey ==
//                                       null
//                                   ? null
//                                   : () {
//                                 showModalBottomSheet(
//                                   useRootNavigator: true,
//                                   isScrollControlled: true,
//                                   backgroundColor: Colors.transparent,
//                                   context: context,
//                                   builder: (context) =>
//                                       SubcategoryServiceView(
//                                         categoryId: "",
//                                         subCategoryId: '',
//                                         serviceList: bookingEditController
//                                             .serviceList ??
//                                             [],
//                                       ),
//                                 );
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(
//                                       Dimensions.radiusDefault),
//                                   side: BorderSide(
//                                       color: bookingEditController
//                                           .cartList.length ==
//                                           1 &&
//                                           bookingEditController
//                                               .cartList[0].variantKey ==
//                                               null
//                                           ? Theme.of(context).hintColor
//                                           : Theme.of(context).primaryColor),
//                                 ),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Icon(
//                                     Icons.add,
//                                     color: bookingEditController
//                                         .cartList.length ==
//                                         1 &&
//                                         bookingEditController
//                                             .cartList[0].variantKey ==
//                                             null
//                                         ? Theme.of(context).hintColor
//                                         : Theme.of(context).primaryColor,
//                                     size: Dimensions.fontSizeDefault,
//                                   ),
//                                   const SizedBox(width: 8.0),
//                                   Text(
//                                     "add_service".tr,
//                                     style: robotoMedium.copyWith(
//                                       fontSize: Dimensions.fontSizeDefault,
//                                       color: bookingEditController
//                                           .cartList.length ==
//                                           1 &&
//                                           bookingEditController
//                                               .cartList[0].variantKey ==
//                                               null
//                                           ? Theme.of(context).hintColor
//                                           : Theme.of(context).primaryColor,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                         ],
//                       ),
//                       const SizedBox(height: Dimensions.paddingSizeDefault),
//                       GridView.builder(
//                         key: UniqueKey(),
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisSpacing: Dimensions.paddingSizeLarge,
//                           mainAxisSpacing: ResponsiveHelper.isDesktop(context)
//                               ? Dimensions.paddingSizeLarge
//                               : Dimensions.paddingSizeSmall,
//                           childAspectRatio:
//                           ResponsiveHelper.isMobile(context) ? 5 : 6,
//                           crossAxisCount: 1,
//                           mainAxisExtent: 110,
//                         ),
//                         physics: const NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         itemCount: bookingEditController.cartList.length,
//                         itemBuilder: (context, index) {
//                           bool disableQuantityButton =
//                               bookingEditController.cartList.length == 1 &&
//                                   bookingEditController.cartList[0].variantKey ==
//                                       null;
//                           return CartServiceWidget(
//                             cart: bookingEditController.cartList[index],
//                             cartIndex: index,
//                             disableQuantityButton: disableQuantityButton,
//                             isSubBooking: widget.isSubBooking,
//                           );
//                         },
//                       ),
//                       const SizedBox(height: Dimensions.paddingSizeDefault),
//                       Text(
//                         'additional_services'.tr,
//                         style: robotoMedium.copyWith(
//                             color: Theme.of(context).primaryColor,
//                             fontSize: Dimensions.fontSizeLarge),
//                       ),
//                       const SizedBox(height: Dimensions.paddingSizeSmall),
//                       Obx(() => GridView.builder(
//                         key: UniqueKey(),
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisSpacing: Dimensions.paddingSizeLarge,
//                           mainAxisSpacing: ResponsiveHelper.isDesktop(context)
//                               ? Dimensions.paddingSizeLarge
//                               : Dimensions.paddingSizeSmall,
//                           childAspectRatio:
//                           ResponsiveHelper.isMobile(context) ? 5 : 6,
//                           crossAxisCount: 1,
//                           mainAxisExtent: 110,
//                         ),
//                         physics: const NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         itemCount: bookingEditController.serviceData.length,
//                         itemBuilder: (context, index) {
//                           return AdditionalServiceWidget(
//                             service: bookingEditController.serviceData[index],
//                             index: index,
//                             isSubBooking: widget.isSubBooking,
//                             controller: bookingEditController,
//                           );
//                         },
//                       )),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Card(
//                           elevation: 4.0,
//                           shape: RoundedRectangleBorder(
//                             borderRadius:
//                             BorderRadius.circular(Dimensions.radiusDefault),
//                           ),
//                           child: SingleChildScrollView(
//                             child: Padding(
//                               padding: const EdgeInsets.all(
//                                   Dimensions.paddingSizeDefault),
//                               child: Column(
//                                 children: [
//                                   Obx(() => ListView.builder(
//                                     shrinkWrap: true,
//                                     physics:
//                                     const NeverScrollableScrollPhysics(),
//                                     itemCount: bookingEditController
//                                         .textFieldList.length,
//                                     itemBuilder: (context, index) {
//                                       return Row(
//                                         children: [
//                                           Expanded(
//                                             child: TextField(
//                                               controller: bookingEditController
//                                                   .textFieldList[index]
//                                                   .firstController,
//                                               decoration:
//                                               const InputDecoration(
//                                                 labelText: 'Product',
//                                               ),
//                                               keyboardType:
//                                               TextInputType.multiline,
//                                               maxLines: null,
//                                             ),
//                                           ),
//                                           const SizedBox(width: 10),
//                                           Expanded(
//                                             child: TextField(
//                                               controller: bookingEditController
//                                                   .textFieldList[index]
//                                                   .secondController,
//                                               keyboardType:
//                                               const TextInputType
//                                                   .numberWithOptions(
//                                                   decimal: true),
//                                               decoration:
//                                               const InputDecoration(
//                                                 labelText: 'Amount',
//                                               ),
//                                             ),
//                                           ),
//                                           IconButton(
//                                             icon: const Icon(Icons.delete,
//                                                 color: Colors.red),
//                                             onPressed: () =>
//                                                 bookingEditController
//                                                     .removeTextField(index),
//                                           ),
//                                         ],
//                                       ).paddingAll(8);
//                                     },
//                                   )),
//                                   const SizedBox(
//                                       height: Dimensions.paddingSizeDefault),
//                                   ElevatedButton.icon(
//                                     icon: const Icon(Icons.add),
//                                     onPressed:
//                                     bookingEditController.addTextFields,
//                                     label: const Text('Add Service Data'),
//                                     style: ElevatedButton.styleFrom(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(
//                                             Dimensions.radiusDefault),
//                                         side: BorderSide(
//                                           color: bookingEditController
//                                               .cartList.length ==
//                                               1 &&
//                                               bookingEditController
//                                                   .cartList[0].variantKey ==
//                                                   null
//                                               ? Theme.of(context).hintColor
//                                               : Theme.of(context).primaryColor,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             GetBuilder<BookingEditController>(builder: (bookingEditController) {
//               var bookingDetails = Get.find<BookingDetailsController>()
//                   .bookingDetails
//                   ?.bookingContent
//                   ?.bookingDetailsContent;
//               return Padding(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: Dimensions.paddingSizeDefault,
//                     vertical: Dimensions.paddingSizeSmall),
//                 child: SafeArea(
//                   child: CustomButton(
//                     btnTxt: "update_status".tr,
//                     isLoading: bookingEditController.statusUpdateLoading,
//                     onPressed: () {
//                       List<Map<String, dynamic>> newServiceData = [];
//                       for (var row in bookingEditController.textFieldList) {
//                         if (row.firstController.text.isNotEmpty &&
//                             row.secondController.text.isNotEmpty) {
//                           newServiceData.add({
//                             "service_name": row.firstController.text,
//                             "service_amount": row.secondController.text,
//                             "quantity": "1",
//                             "service_thumbnail": '',
//                           });
//                         }
//                       }
//
//                       // Append new service data to existing serviceData
//                       if (newServiceData.isNotEmpty) {
//                         bookingEditController.appendServiceData(newServiceData);
//                       }
//
//                       // Call updateBooking to save changes
//                       bookingEditController.updateBooking(
//                         bookingId:
//                         bookingDetails?.subBooking?.id ?? bookingDetails?.id,
//                         subBookingId: bookingDetails?.id,
//                         zoneId: bookingDetails?.zoneId ??
//                             bookingDetails?.subBooking?.zoneId ??
//                             "",
//                         isSubBooking: widget.isSubBooking,
//                       );
//
//                       // Clear text fields
//                       bookingEditController.clearTextFields();
//
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ),
//               );
//             }),
//           ],
//         );
//       }),
//     );
//   }
// }



import 'package:demandium_serviceman/utils/core_export.dart';
import 'package:get/get.dart';
import 'package:demandium_serviceman/helper/booking_helper.dart';
import 'package:demandium_serviceman/feature/booking_details/model/booking_details_model.dart';

class AdditionalServiceWidget extends StatelessWidget {
  final Map<String, dynamic> service;
  final int index;
  final bool isSubBooking;
  final BookingEditController controller;

  const AdditionalServiceWidget({
    Key? key,
    required this.service,
    required this.index,
    required this.isSubBooking,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      child: Row(
        children: [
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          //   child: CustomImage(
          //     image: service['service_thumbnail'] ?? '',
          //     height: 40,
          //     width: 40,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  service['service_name'] ?? 'Unknown',
                  style: robotoMedium.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                Text(
                  '${PriceConverter.convertPrice(double.tryParse(service['service_amount'].toString()) ?? 0.0)}',
                  //' x ${service['quantity'] ?? 1}',
                  style: robotoRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              // InkWell(
              //   onTap: () => controller.decrementServiceQuantity(index),
              //   child: Container(
              //     padding: const EdgeInsets.all(2),
              //     decoration: BoxDecoration(
              //       border: Border.all(color: Theme.of(context).hintColor),
              //       borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              //     ),
              //     child: Icon(
              //       Icons.remove,
              //       size: 16,
              //       color: Theme.of(context).hintColor,
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
              //   child: Text(
              //     service['quantity'].toString(),
              //     style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
              //   ),
              // ),
              // InkWell(
              //   onTap: () => controller.incrementServiceQuantity(index),
              //   child: Container(
              //     padding: const EdgeInsets.all(2),
              //     decoration: BoxDecoration(
              //       border: Border.all(color: Theme.of(context).primaryColor),
              //       borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              //     ),
              //     child: Icon(
              //       Icons.add,
              //       size: 16,
              //       color: Theme.of(context).primaryColor,
              //     ),
              //   ),
              // ),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              InkWell(
                onTap: () => controller.removeServiceData(index),
                child: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.error,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BookingEditScreen extends StatefulWidget {
  final bool isSubBooking;
  const BookingEditScreen({super.key, required this.isSubBooking});

  @override
  State<BookingEditScreen> createState() => _BookingEditScreenState();
}

class _BookingEditScreenState extends State<BookingEditScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<BookingEditController>().initializedControllerValue(
        Get.find<BookingDetailsController>()
            .bookingDetails
            ?.bookingContent
            ?.bookingDetailsContent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "edit_booking".tr),
      body: GetBuilder<BookingEditController>(builder: (bookingEditController) {
        final BookingDetailsContent? bookingDetails =
            Get.find<BookingDetailsController>()
                .bookingDetails
                ?.bookingContent
                ?.bookingDetailsContent;

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //const PaymentStatusButton(),
                      const SizedBox(height: Dimensions.paddingSizeDefault),
                      // Container(
                      //   width: Get.width,
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: Dimensions.paddingSizeLarge),
                      //   decoration: BoxDecoration(
                      //     color:
                      //     Theme.of(context).cardColor.withValues(alpha: 0.1),
                      //     borderRadius:
                      //     BorderRadius.circular(Dimensions.paddingSizeSmall),
                      //     border: Border.all(
                      //         color: Theme.of(context)
                      //             .primaryColor
                      //             .withValues(alpha: 0.2),
                      //         width: 1),
                      //   ),
                      //   child: DropdownButtonHideUnderline(
                      //     child: DropdownButton(
                      //       dropdownColor: Theme.of(context).cardColor,
                      //       borderRadius: BorderRadius.circular(5),
                      //       elevation: 2,
                      //       hint: Text(
                      //         bookingEditController.selectedBookingStatus == ''
                      //             ? "select_booking_status".tr
                      //             : "${'booking_status'.tr} : ${bookingEditController.selectedBookingStatus.tr}",
                      //         style: robotoRegular.copyWith(
                      //             color: bookingEditController
                      //                 .selectedBookingStatus ==
                      //                 ''
                      //                 ? Theme.of(context)
                      //                 .textTheme
                      //                 .bodyLarge!
                      //                 .color!
                      //                 .withValues(alpha: 0.6)
                      //                 : Theme.of(context)
                      //                 .textTheme
                      //                 .bodyLarge!
                      //                 .color!
                      //                 .withValues(alpha: 0.8)),
                      //       ),
                      //       icon: const Icon(Icons.keyboard_arrow_down),
                      //       items: bookingEditController.statusTypeList
                      //           .map((String items) {
                      //         return DropdownMenuItem(
                      //           value: items,
                      //           child: Row(
                      //             children: [
                      //               Text(
                      //                 items.tr,
                      //                 style: robotoRegular.copyWith(
                      //                   color: Theme.of(context)
                      //                       .textTheme
                      //                       .bodyLarge!
                      //                       .color!
                      //                       .withValues(alpha: 0.8),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         );
                      //       }).toList(),
                      //       onChanged: (String? newValue) {
                      //         if (Get.find<BookingDetailsController>()
                      //             .bookingDetails
                      //             ?.bookingContent
                      //             ?.bookingDetailsContent
                      //             ?.bookingStatus ==
                      //             "ongoing" &&
                      //             newValue?.toLowerCase() == "accepted") {
                      //           showCustomSnackBar(
                      //               'service_is_already_ongoing'.tr,
                      //               type: ToasterMessageType.info);
                      //           bookingEditController
                      //               .changeBookingStatusDropDownValue("ongoing");
                      //         } else {
                      //           bookingEditController
                      //               .changeBookingStatusDropDownValue(newValue!);
                      //         }
                      //       },
                      //     ),
                      //   ),
                      // ),
                      TextFieldTitle(
                        title: "service_schedule".tr,
                        fontSize: Dimensions.fontSizeLarge,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .cardColor
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(
                                Dimensions.paddingSizeSmall),
                            border: Border.all(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withValues(alpha: 0.2),
                                width: 1)),
                        margin: const EdgeInsets.only(
                            bottom: Dimensions.paddingSizeDefault),
                        padding: const EdgeInsets.only(
                            left: Dimensions.paddingSizeDefault),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (bookingEditController.scheduleTime != null)
                                ? Text(
                              DateConverter.dateMonthYearTime(
                                  DateTime.tryParse(bookingEditController
                                      .scheduleTime!)),
                              style: robotoRegular.copyWith(
                                  fontSize: Dimensions.fontSizeDefault),
                              textDirection: TextDirection.ltr,
                            )
                                : const SizedBox(),
                            const SizedBox(width: Dimensions.paddingSizeDefault),
                            IconButton(
                              onPressed: () => bookingEditController.selectDate(),
                              icon: Icon(
                                Icons.calendar_month_outlined,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withValues(alpha: 0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'service_list'.tr,
                            style: robotoMedium.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontSize: Dimensions.fontSizeLarge),
                          ),
                          if (!widget.isSubBooking)
                            TextButton(
                              onPressed:
                              bookingEditController.cartList.length == 1 &&
                                  bookingEditController
                                      .cartList[0].variantKey ==
                                      null
                                  ? null
                                  : () {
                                showModalBottomSheet(
                                  useRootNavigator: true,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) =>
                                      SubcategoryServiceView(
                                        categoryId: "",
                                        subCategoryId: '',
                                        serviceList: bookingEditController
                                            .serviceList ??
                                            [],
                                      ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radiusDefault),
                                  side: BorderSide(
                                      color: bookingEditController
                                          .cartList.length ==
                                          1 &&
                                          bookingEditController
                                              .cartList[0].variantKey ==
                                              null
                                          ? Theme.of(context).hintColor
                                          : Theme.of(context).primaryColor),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: bookingEditController
                                        .cartList.length ==
                                        1 &&
                                        bookingEditController
                                            .cartList[0].variantKey ==
                                            null
                                        ? Theme.of(context).hintColor
                                        : Theme.of(context).primaryColor,
                                    size: Dimensions.fontSizeDefault,
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    "add_service".tr,
                                    style: robotoMedium.copyWith(
                                      fontSize: Dimensions.fontSizeDefault,
                                      color: bookingEditController
                                          .cartList.length ==
                                          1 &&
                                          bookingEditController
                                              .cartList[0].variantKey ==
                                              null
                                          ? Theme.of(context).hintColor
                                          : Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: Dimensions.paddingSizeDefault),
                      GridView.builder(
                        key: UniqueKey(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: Dimensions.paddingSizeLarge,
                          mainAxisSpacing: ResponsiveHelper.isDesktop(context)
                              ? Dimensions.paddingSizeLarge
                              : Dimensions.paddingSizeSmall,
                          childAspectRatio:
                          ResponsiveHelper.isMobile(context) ? 5 : 6,
                          crossAxisCount: 1,
                          mainAxisExtent: 110,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: bookingEditController.cartList.length,
                        itemBuilder: (context, index) {
                          bool disableQuantityButton =
                              bookingEditController.cartList.length == 1 &&
                                  bookingEditController.cartList[0].variantKey ==
                                      null;
                          return CartServiceWidget(
                            cart: bookingEditController.cartList[index],
                            cartIndex: index,
                            disableQuantityButton: disableQuantityButton,
                            isSubBooking: widget.isSubBooking,
                          );
                        },
                      ),
                      const SizedBox(height: Dimensions.paddingSizeDefault),
                      Text(
                        'additional_services'.tr,
                        style: robotoMedium.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: Dimensions.fontSizeLarge),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      Obx(() => GridView.builder(
                        key: UniqueKey(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: Dimensions.paddingSizeLarge,
                          mainAxisSpacing: ResponsiveHelper.isDesktop(context)
                              ? Dimensions.paddingSizeLarge
                              : Dimensions.paddingSizeSmall,
                          childAspectRatio:
                          ResponsiveHelper.isMobile(context) ? 5 : 6,
                          crossAxisCount: 1,
                          mainAxisExtent: 110,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: bookingEditController.serviceData.length,
                        itemBuilder: (context, index) {
                          return AdditionalServiceWidget(
                            service: bookingEditController.serviceData[index],
                            index: index,
                            isSubBooking: widget.isSubBooking,
                            controller: bookingEditController,
                          );
                        },
                      )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(Dimensions.radiusDefault),
                          ),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.paddingSizeDefault),
                              child: Column(
                                children: [
                                  Obx(() => ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    itemCount: bookingEditController
                                        .textFieldList.length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: bookingEditController
                                                  .textFieldList[index]
                                                  .firstController,
                                              decoration:
                                              const InputDecoration(
                                                labelText: 'Product',
                                              ),
                                              keyboardType:
                                              TextInputType.multiline,
                                              maxLines: null,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: TextField(
                                              controller: bookingEditController
                                                  .textFieldList[index]
                                                  .secondController,
                                              keyboardType:
                                              const TextInputType
                                                  .numberWithOptions(
                                                  decimal: true),
                                              decoration:
                                              const InputDecoration(
                                                labelText: 'Amount',
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () =>
                                                bookingEditController
                                                    .removeTextField(index),
                                          ),
                                        ],
                                      ).paddingAll(8);
                                    },
                                  )),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeDefault),
                                  ElevatedButton.icon(
                                    icon: const Icon(Icons.add),
                                    onPressed:
                                    bookingEditController.addTextFields,
                                    label: const Text('Add Service Data'),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radiusDefault),
                                        side: BorderSide(
                                          color: bookingEditController
                                              .cartList.length ==
                                              1 &&
                                              bookingEditController
                                                  .cartList[0].variantKey ==
                                                  null
                                              ? Theme.of(context).hintColor
                                              : Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GetBuilder<BookingEditController>(builder: (bookingEditController) {
              var bookingDetails = Get.find<BookingDetailsController>()
                  .bookingDetails
                  ?.bookingContent
                  ?.bookingDetailsContent;
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault,
                    vertical: Dimensions.paddingSizeSmall),
                child: SafeArea(
                  child: CustomButton(
                    btnTxt: "update_status".tr,
                    isLoading: bookingEditController.statusUpdateLoading,
                    onPressed: () {
                      List<Map<String, dynamic>> newServiceData = [];
                      for (var row in bookingEditController.textFieldList) {
                        if (row.firstController.text.isNotEmpty &&
                            row.secondController.text.isNotEmpty) {
                          newServiceData.add({
                            "service_name": row.firstController.text,
                            "service_amount": row.secondController.text,
                            "quantity": "1",
                            "service_thumbnail": '',
                          });
                        }
                      }

                      // Append new service data to existing serviceData
                      if (newServiceData.isNotEmpty) {
                        bookingEditController.appendServiceData(newServiceData);
                      }

                      // Call updateBooking to save changes
                      bookingEditController.updateBooking(
                        bookingId:
                        bookingDetails?.subBooking?.id ?? bookingDetails?.id,
                        subBookingId: bookingDetails?.id,
                        zoneId: bookingDetails?.zoneId ??
                            bookingDetails?.subBooking?.zoneId ??
                            "",
                        isSubBooking: widget.isSubBooking,
                      );

                      // Clear text fields
                      bookingEditController.clearTextFields();

                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            }),
          ],
        );
      }),
    );
  }
}