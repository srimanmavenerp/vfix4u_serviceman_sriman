import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:demandium_serviceman/utils/core_export.dart';

import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BookingDetailsWidget extends StatefulWidget {
  final String? bookingId;
  final bool isSubBooking;
  const BookingDetailsWidget(
      {super.key, this.bookingId, required this.isSubBooking});

  @override
  State<BookingDetailsWidget> createState() => _BookingDetailsWidgetState();
}

class _BookingDetailsWidgetState extends State<BookingDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingDetailsController>(
      builder: (bookingDetailsController) {
        final bookingDetailsModel = bookingDetailsController.bookingDetails;
        final bookingDetails = bookingDetailsController
            .bookingDetails?.bookingContent?.bookingDetailsContent;
        print("Booking OTP: ${bookingDetails?.pickupInfo?.bookingOtp ?? ''}");
        bool showDeliveryConfirmImage =
            bookingDetailsController.showPhotoEvidenceField;
        ConfigModel? configModel = Get.find<SplashController>().configModel;

        int isGuest = bookingDetails?.isGuest ?? 0;
        bool isPartial = (bookingDetails != null &&
                bookingDetails.partialPayments != null &&
                bookingDetails.partialPayments!.isNotEmpty)
            ? true
            : false;
        String bookingStatus = bookingDetails?.bookingStatus ?? "";
        bool subBookingPaid =
            widget.isSubBooking && bookingDetails?.isPaid == 1;

        return bookingDetailsModel == null &&
                bookingDetailsModel?.bookingContent == null
            ? const BookingDetailsShimmer()
            : bookingDetailsModel != null &&
                    bookingDetailsModel.bookingContent == null
                ? SizedBox(
                    height: Get.height * 0.7,
                    child: BookingEmptyScreen(
                      bookingId: widget.bookingId ?? "",
                    ))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          // scrollDirection: Axis.vertical,
                          controller: bookingDetailsController.scrollController,
                          child: Column(
                            children: [
                              const SizedBox(
                                  height: Dimensions.paddingSizeSmall),
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor.withValues(
                                      alpha: Get.isDarkMode ? 0.5 : 1),
                                  boxShadow:
                                      Get.find<ThemeController>().darkTheme
                                          ? null
                                          : shadow,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.paddingSizeDefault,
                                    vertical: Dimensions.paddingSizeSmall),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(children: [
                                                    Text(
                                                      '${"booking".tr} # ${bookingDetails?.readableId}',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: robotoMediumHigh
                                                          .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .color),
                                                    ),
                                                    if (widget.isSubBooking)
                                                      Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .green),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2),
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: Dimensions
                                                                .paddingSizeExtraSmall),
                                                        child: const Icon(
                                                          Icons.repeat,
                                                          color: Colors.white,
                                                          size: 10,
                                                        ),
                                                      )
                                                  ]),
                                                  const SizedBox(
                                                    height: Dimensions
                                                        .paddingSizeSmall,
                                                  ),
                                                  (bookingDetails
                                                              ?.bookingStatus !=
                                                          "canceled")
                                                      ? GestureDetector(
                                                          onTap: () async {
                                                            _checkPermission(
                                                                () async {
                                                              if (bookingDetails
                                                                      ?.serviceAddress !=
                                                                  null) {
                                                                Get.dialog(
                                                                    const CustomLoader(),
                                                                    barrierDismissible:
                                                                        false);
                                                                await Geolocator
                                                                        .getCurrentPosition()
                                                                    .then(
                                                                        (position) {
                                                                  MapUtils
                                                                      .openMap(
                                                                    double.tryParse(bookingDetails?.serviceAddress?.lat ??
                                                                            "0") ??
                                                                        23.8103,
                                                                    double.tryParse(bookingDetails?.serviceAddress?.lon ??
                                                                            "0") ??
                                                                        90.4125,
                                                                    position
                                                                        .latitude,
                                                                    position
                                                                        .longitude,
                                                                  );
                                                                });
                                                                Get.back();
                                                              } else {
                                                                showCustomSnackBar(
                                                                    "service_address_not_found"
                                                                        .tr,
                                                                    type: ToasterMessageType
                                                                        .info);
                                                              }
                                                            });
                                                          },
                                                          child: Container(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    Dimensions
                                                                        .paddingSizeDefault,
                                                                vertical: Dimensions
                                                                        .paddingSizeExtraSmall +
                                                                    2),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                color: Colors
                                                                    .grey
                                                                    .withValues(
                                                                        alpha:
                                                                            0.2)),
                                                            child: Center(
                                                              child: Text(
                                                                "view_on_map"
                                                                    .tr,
                                                                style:
                                                                    robotoMediumLow
                                                                        .copyWith(
                                                                  color: ColorResources
                                                                          .buttonTextColorMap[
                                                                      'accepted'],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal: Dimensions
                                                                  .paddingSizeDefault,
                                                              vertical: Dimensions
                                                                  .paddingSizeExtraSmall),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              color: Colors.grey
                                                                  .withValues(
                                                                      alpha:
                                                                          0.2)),
                                                          child: Center(
                                                            child: Text(
                                                              "canceled".tr,
                                                              style:
                                                                  robotoMediumLow
                                                                      .copyWith(
                                                                color: ColorResources
                                                                        .buttonTextColorMap[
                                                                    'canceled'],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                ]),
                                            // if(configModel?.content?.serviceManCanEditBooking == 1 && bookingDetailsController.bookingDetails?.bookingContent?.providerServicemanCanEditBooking == 1)
                                            Expanded(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: Dimensions
                                                          .paddingSizeSmall),
                                              child: CustomButton(
                                                height: 35,
                                                btnTxt: "edit".tr,
                                                icon: Icons.edit,
                                                onPressed: (!subBookingPaid &&
                                                        !isPartial &&
                                                        (bookingStatus ==
                                                                "accepted" ||
                                                            bookingStatus ==
                                                                "ongoing") &&
                                                        ((isGuest == 1 &&
                                                                bookingDetails
                                                                        ?.paymentMethod !=
                                                                    "cash_after_service")
                                                            ? false
                                                            : true))
                                                    ? () {
                                                        Get.to(() =>
                                                            BookingEditScreen(
                                                              isSubBooking: widget
                                                                  .isSubBooking,
                                                            ));
                                                      }
                                                    : null,
                                                fontSize:
                                                    Dimensions.fontSizeSmall,
                                              ),
                                            )),

                                            Column(children: [
                                              CustomButton(
                                                height: 35,
                                                width: 75,
                                                fontSize:
                                                    Dimensions.fontSizeSmall,
                                                btnTxt: "invoice".tr,
                                                onPressed: () async {
                                                  Get.dialog(
                                                      const CustomLoader(),
                                                      barrierDismissible:
                                                          false);
                                                  String languageCode = Get.find<
                                                          LocalizationController>()
                                                      .locale
                                                      .languageCode;
                                                  String uri =
                                                      "${AppConstants.baseUrl}${widget.isSubBooking ? AppConstants.singleRepeatBookingInvoiceUrl : AppConstants.regularBookingInvoiceUrl}${bookingDetails?.id}/$languageCode";
                                                  if (kDebugMode) {
                                                    print("Uri : $uri");
                                                  }
                                                  await _launchUrl(
                                                      Uri.parse(uri));
                                                  Get.back();
                                                },
                                              ),
                                            ])
                                          ]),
                                      if (bookingDetails?.bookingStatus !=
                                          "canceled")
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: Dimensions.paddingSizeSmall),
                                          child: RichText(
                                            text: TextSpan(
                                                text:
                                                    '${'booking_status'.tr}:   ',
                                                style: robotoMedium.copyWith(
                                                  fontSize: Dimensions
                                                          .fontSizeDefault -
                                                      1,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .color,
                                                ),
                                                children: [
                                                  TextSpan(
                                                      text: bookingDetails
                                                          ?.bookingStatus!.tr,
                                                      style: robotoMedium.copyWith(
                                                          fontSize: Dimensions
                                                                  .fontSizeDefault -
                                                              1,
                                                          color: ColorResources
                                                                  .buttonTextColorMap[
                                                              bookingDetails
                                                                  ?.bookingStatus],
                                                          decoration:
                                                              TextDecoration
                                                                  .none)),
                                                ]),
                                          ),
                                        ),
                                      // Visibility(
                                      //   visible: bookingDetails
                                      //           ?.pickupInfo?.laptopDetails !=
                                      //       null,
                                      //   child: Column(
                                      //     crossAxisAlignment:
                                      //         CrossAxisAlignment.start,
                                      //     children: [
                                      //       Text(
                                      //         "Pickup Option: ${bookingDetails?.pickupInfo?.pickupOption ?? ''}",
                                      //         style: robotoRegular.copyWith(
                                      //             fontSize: Dimensions
                                      //                 .fontSizeDefault),
                                      //       ),
                                      //       Text(
                                      //         "Booking OTP: ${bookingDetails?.pickupInfo?.bookingOtp ?? ''}",
                                      //         style: robotoRegular.copyWith(
                                      //             fontSize: Dimensions
                                      //                 .fontSizeDefault),
                                      //       ),
                                      //       Text(
                                      //         "Reschedule: ${bookingDetails?.pickupInfo?.rescheduleDate ?? ''}",
                                      //         style: robotoRegular.copyWith(
                                      //             fontSize: Dimensions
                                      //                 .fontSizeDefault),
                                      //       ),
                                      //       Visibility(
                                      //         visible: bookingDetails
                                      //                 ?.pickupInfo
                                      //                 ?.laptopDetails !=
                                      //             null,
                                      //         child: Column(
                                      //           crossAxisAlignment:
                                      //               CrossAxisAlignment.start,
                                      //           children: [
                                      //             Text(
                                      //               "Laptop Details:",
                                      //               style: robotoBold.copyWith(
                                      //                   fontSize: Dimensions
                                      //                       .fontSizeDefault),
                                      //             ),
                                      //             Visibility(
                                      //               visible: bookingDetails
                                      //                           ?.pickupInfo
                                      //                           ?.pickupOption ==
                                      //                       "pickup" ||
                                      //                   bookingDetails
                                      //                           ?.pickupInfo
                                      //                           ?.laptopDetails
                                      //                           ?.ram !=
                                      //                       null,
                                      //               child: Text(
                                      //                 "RAM: ${bookingDetails?.pickupInfo?.laptopDetails?.ram ?? ''}",
                                      //                 style: robotoRegular.copyWith(
                                      //                     fontSize: Dimensions
                                      //                         .fontSizeSmall),
                                      //               ),
                                      //             ),
                                      //             Visibility(
                                      //               visible: bookingDetails
                                      //                           ?.pickupInfo
                                      //                           ?.pickupOption ==
                                      //                       "pickup" &&
                                      //                   bookingDetails
                                      //                           ?.pickupInfo
                                      //                           ?.laptopDetails
                                      //                           ?.storage !=
                                      //                       null,
                                      //               child: Text(
                                      //                 "Storage: ${bookingDetails?.pickupInfo?.laptopDetails?.storage ?? ''}",
                                      //                 style: robotoRegular.copyWith(
                                      //                     fontSize: Dimensions
                                      //                         .fontSizeSmall),
                                      //               ),
                                      //             ),
                                      //             Visibility(
                                      //               visible: bookingDetails
                                      //                           ?.pickupInfo
                                      //                           ?.pickupOption ==
                                      //                       "pickup" ||
                                      //                   bookingDetails
                                      //                           ?.pickupInfo
                                      //                           ?.laptopDetails
                                      //                           ?.processor !=
                                      //                       null,
                                      //               child: Text(
                                      //                 "Processor: ${bookingDetails?.pickupInfo?.laptopDetails?.processor ?? ''}",
                                      //                 style: robotoRegular.copyWith(
                                      //                     fontSize: Dimensions
                                      //                         .fontSizeSmall),
                                      //               ),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      BookingInformationView(
                                        bookingDetails: bookingDetails!,
                                        isSubBooking: widget.isSubBooking,
                                      ),
                                    ]),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        insetPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 24),
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.95,
                                            maxHeight: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.85,
                                          ),
                                          child: SingleChildScrollView(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Pickup Options",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.close),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    ),
                                                  ],
                                                ),
                                                const Divider(),
                                                PickupOptionWidget(
                                                  bookingotp: bookingDetails
                                                      .pickupInfo?.bookingOtp,
                                                  bookingId:
                                                      bookingDetails.id ?? "",
                                                  initialOption: bookingDetails
                                                      .pickupInfo?.pickupOption,
                                                  initialRescheduleDateTime:
                                                      bookingDetails.pickupInfo
                                                                  ?.rescheduleDate !=
                                                              null
                                                          ? DateTime.tryParse(
                                                              bookingDetails
                                                                  .pickupInfo!
                                                                  .rescheduleDate!)
                                                          : null,
                                                  laptopDetails: {
                                                    "ram": bookingDetails
                                                            .pickupInfo
                                                            ?.laptopDetails
                                                            ?.ram ??
                                                        '',
                                                    "storage": bookingDetails
                                                            .pickupInfo
                                                            ?.laptopDetails
                                                            ?.storage ??
                                                        '',
                                                    "processor": bookingDetails
                                                            .pickupInfo
                                                            ?.laptopDetails
                                                            ?.processor ??
                                                        '',
                                                    "model": bookingDetails
                                                            .pickupInfo
                                                            ?.laptopDetails
                                                            ?.model ??
                                                        '',
                                                    "note": bookingDetails
                                                            .pickupInfo
                                                            ?.laptopDetails
                                                            ?.note ??
                                                        '',
                                                    "images": bookingDetails
                                                            .pickupInfo
                                                            ?.laptopDetails
                                                            ?.images ??
                                                        <String>[],
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const Text("Open Pickup Options"),
                              ),

                              BookingDetailsCustomerInfo(
                                  bookingDetails:
                                      bookingDetails), ////review   Rani

                              BookingSummeryView(
                                  bookingDetails: bookingDetails),

                              BookingDetailsProviderInfo(
                                  bookingDetails:
                                      bookingDetails), ///////rivew  service man reviwe

                              bookingDetails.photoEvidenceFullPath != null &&
                                      bookingDetails
                                          .photoEvidenceFullPath!.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.paddingSizeDefault),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height:
                                                  Dimensions.paddingSizeDefault,
                                            ),
                                            Text(
                                              'completed_service_picture'.tr,
                                              style: robotoMedium.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeDefault,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                            const SizedBox(
                                                height: Dimensions
                                                    .paddingSizeSmall),
                                            Container(
                                              height: 90,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor
                                                    .withValues(alpha: 0.05),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .radiusDefault),
                                              ),
                                              padding: const EdgeInsets.all(
                                                  Dimensions.paddingSizeSmall),
                                              child: ListView.builder(
                                                controller: bookingDetailsController
                                                    .completedServiceImagesScrollController,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: bookingDetails
                                                    .photoEvidenceFullPath
                                                    ?.length,
                                                itemBuilder: (context, index) {
                                                  return Hero(
                                                    tag: bookingDetails
                                                                .photoEvidenceFullPath?[
                                                            index] ??
                                                        "",
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: Dimensions
                                                              .paddingSizeExtraSmall),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                .radiusDefault),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Get.to(
                                                              ImageDetailScreen(
                                                                imageList:
                                                                    bookingDetails
                                                                            .photoEvidenceFullPath ??
                                                                        [],
                                                                index: index,
                                                                appbarTitle:
                                                                    'completed_service_picture'
                                                                        .tr,
                                                              ),
                                                            );
                                                          },
                                                          child: CustomImage(
                                                            image: bookingDetails
                                                                        .photoEvidenceFullPath?[
                                                                    index] ??
                                                                "",
                                                            height: 70,
                                                            width: 120,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ]),
                                    )
                                  : const SizedBox(),

                              Get.find<SplashController>()
                                              .configModel
                                              ?.content
                                              ?.bookingImageVerification ==
                                          1 &&
                                      showDeliveryConfirmImage &&
                                      bookingDetails.bookingStatus !=
                                          'completed'
                                  ? Padding(
                                      padding: const EdgeInsets.all(
                                          Dimensions.paddingSizeDefault),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'completed_service_picture'.tr,
                                              style: robotoMedium.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeDefault,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                            const SizedBox(
                                                height: Dimensions
                                                    .paddingSizeSmall),
                                            Container(
                                              height: 90,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor
                                                    .withValues(alpha: 0.05),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .radiusDefault),
                                              ),
                                              padding: const EdgeInsets.all(
                                                  Dimensions.paddingSizeSmall),
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount:
                                                    bookingDetailsController
                                                            .pickedPhotoEvidence
                                                            .length +
                                                        1,
                                                itemBuilder: (context, index) {
                                                  XFile? file = index ==
                                                          bookingDetailsController
                                                              .pickedPhotoEvidence
                                                              .length
                                                      ? null
                                                      : bookingDetailsController
                                                              .pickedPhotoEvidence[
                                                          index];
                                                  if (index < 5 &&
                                                      index ==
                                                          bookingDetailsController
                                                              .pickedPhotoEvidence
                                                              .length) {
                                                    return InkWell(
                                                      onTap: () {
                                                        Get.bottomSheet(
                                                            CameraButtonSheet(
                                                          bookingId:
                                                              bookingDetails
                                                                      .id ??
                                                                  "",
                                                          isSubBooking: widget
                                                              .isSubBooking,
                                                        ));
                                                      },
                                                      child: Container(
                                                        height: 60,
                                                        width: 70,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(Dimensions
                                                                  .radiusDefault),
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor
                                                                  .withValues(
                                                                      alpha:
                                                                          0.1),
                                                        ),
                                                        child: Icon(
                                                            Icons
                                                                .camera_alt_sharp,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            size: 32),
                                                      ),
                                                    );
                                                  }
                                                  return file != null
                                                      ? Container(
                                                          margin: const EdgeInsets
                                                              .only(
                                                              right: Dimensions
                                                                  .paddingSizeSmall),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .radiusDefault),
                                                          ),
                                                          child:
                                                              Stack(children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      Dimensions
                                                                          .radiusDefault),
                                                              child: GetPlatform
                                                                      .isWeb
                                                                  ? Image
                                                                      .network(
                                                                      file.path,
                                                                      width:
                                                                          120,
                                                                      height:
                                                                          70,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    )
                                                                  : Image.file(
                                                                      File(file
                                                                          .path),
                                                                      width:
                                                                          120,
                                                                      height:
                                                                          70,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                            ),
                                                          ]),
                                                        )
                                                      : const SizedBox();
                                                },
                                              ),
                                            ),
                                          ]),
                                    )
                                  : const SizedBox(),

                              const SizedBox(
                                  height: Dimensions.paddingSizeExtraLarge),
                            ],
                          ),
                        ),
                      ),
                      bookingDetails.bookingStatus == "accepted" ||
                              bookingDetails.bookingStatus == "ongoing"
                          ? SafeArea(
                              child: StatusChangeDropdownButton(
                              bookingId: bookingDetails.id ?? "",
                              bookingDetails: bookingDetails,
                              isSubBooking: widget.isSubBooking,
                            ))
                          : const SizedBox(),
                    ],
                  );
      },
    );
  }

  void _checkPermission(Function onTap) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      showCustomSnackBar('you_have_to_allow'.tr, type: ToasterMessageType.info);
    } else if (permission == LocationPermission.deniedForever) {
      Get.dialog(const PermissionDialog());
    } else {
      onTap();
    }
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(
      double destinationLatitude,
      double destinationLongitude,
      double userLatitude,
      double userLongitude) async {
    String googleUrl =
        'https://www.google.com/maps/dir/?api=1&origin=$userLatitude,$userLongitude'
        '&destination=$destinationLatitude,$destinationLongitude&mode=d';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl),
          mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the map.';
    }
  }
}

class BookingEmptyScreen extends StatelessWidget {
  final String? bookingId;
  const BookingEmptyScreen({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Images.noResults,
            height: Get.height * 0.1,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(
            height: Dimensions.paddingSizeLarge,
          ),
          Text(
            "information_not_found".tr,
            style: robotoRegular,
          ),
          const SizedBox(
            height: Dimensions.paddingSizeLarge,
          ),
          CustomButton(
            height: 35,
            width: 120,
            radius: Dimensions.radiusExtraLarge,
            btnTxt: "go_back".tr,
            onPressed: () {
              //Get.find<BookingRequestController>().removeBookingItemFromList(bookingId ?? "", shouldUpdate: true , bookingStatus: "");
              Get.back();
            },
          )
        ],
      ),
    );
  }
}

class PickupOptionWidget extends StatefulWidget {
  final String bookingId;
  final Map<String, dynamic>? laptopDetails;
  final String? initialOption;
  final DateTime? initialRescheduleDateTime;
  final List<String>? base64Images;
  final String? bookingotp;

  const PickupOptionWidget({
    super.key,
    required this.bookingId,
    this.bookingotp,
    this.laptopDetails,
    this.initialOption,
    this.initialRescheduleDateTime,
    this.base64Images,
  });

  @override
  State<PickupOptionWidget> createState() => _PickupOptionWidgetState();
}

class _PickupOptionWidgetState extends State<PickupOptionWidget> {
  final ImagePicker _picker = ImagePicker();
  List<File> selectedImages = [];
  List<String> existingImageUrls = [];

  String? selectedOption;
  DateTime? rescheduleDateTime;

  final TextEditingController otpController = TextEditingController();
  final TextEditingController ramController = TextEditingController();
  final TextEditingController storageController = TextEditingController();
  final TextEditingController processorController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // ✅ Pre-fill laptop details if available
    final details = widget.laptopDetails ?? {};
    ramController.text = details['ram'] ?? '';
    storageController.text = details['storage'] ?? '';
    processorController.text = details['processor'] ?? '';
    modelController.text = details['model'] ?? '';
    noteController.text = details['note'] ?? '';
    otpController.text = widget.bookingotp ?? '';

    // ✅ Pickup option & reschedule time
    selectedOption = widget.initialOption;
    rescheduleDateTime = widget.initialRescheduleDateTime;

    // ✅ Load existing image URLs from API response
    if (details['images'] != null && details['images'] is List) {
      existingImageUrls = List<String>.from(details['images']);
    }

    // ✅ Decode base64 images if provided
    if (widget.base64Images != null && widget.base64Images!.isNotEmpty) {
      _decodeBase64Images(widget.base64Images!);
    }
  }

  Future<void> _decodeBase64Images(List<String> base64Images) async {
    for (var base64Img in base64Images) {
      final decodedBytes = base64Decode(base64Img);
      final tempFile = File(
        '${Directory.systemTemp.path}/img_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      await tempFile.writeAsBytes(decodedBytes);
      setState(() {
        selectedImages.add(tempFile);
      });
    }
  }

  /// Pick single image from camera
  Future<void> pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        selectedImages.add(File(pickedFile.path));
      });
    }
  }

  /// Pick multiple images from gallery
  Future<void> pickImagesFromGallery() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        selectedImages.addAll(pickedFiles.map((f) => File(f.path)));
      });
    }
  }

  /// Pick date & time for reschedule
  Future<void> pickRescheduleDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return;

    setState(() {
      rescheduleDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  /// API call
  Future<void> updatePickupOption() async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(AppConstants.token) ?? "";

      final url = Uri.parse(
        '${AppConstants.baseUrl}/api/v1/serviceman/booking/pickup-option/${widget.bookingId}',
      );

      final request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer $token';

      // ✅ Common field
      request.fields['option'] = selectedOption ?? '';

      // ✅ Handle reschedule
      if (selectedOption == "reschedule" && rescheduleDateTime != null) {
        request.fields['reschedule_date'] =
            DateFormat("yyyy-MM-dd HH:mm:ss").format(rescheduleDateTime!);
      }

      // ✅ Handle pickup option
      if (selectedOption == "pickup") {
        request.fields['otp'] = otpController.text;
        request.fields['model'] = modelController.text;
        request.fields['note'] = noteController.text;
        request.fields['laptop_details[ram]'] = ramController.text;
        request.fields['laptop_details[storage]'] = storageController.text;
        request.fields['laptop_details[processor]'] = processorController.text;

        // ✅ Attach laptop images (multiple)
        for (var img in selectedImages) {
          request.files.add(await http.MultipartFile.fromPath(
            'laptop_images[]',
            img.path,
          ));
        }
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (!mounted) return;

      // ✅ Hide loading spinner
      if (Get.isDialogOpen ?? false) Get.back();
      if (response.statusCode == 200) {
        Get.back(); // close dialog first
        Get.snackbar(
          "Success",
          "Updated successfully",
          backgroundColor: Colors.green.shade600.withOpacity(0.95),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(12),
          borderRadius: 10,
          icon: const Icon(Icons.check_circle, color: Colors.white),
          overlayBlur: 0, // ensures it's above any dialog blur
          overlayColor: Colors.transparent,
          isDismissible: true,
          duration: const Duration(seconds: 3),
        );
        Navigator.pop(context, true);
      } else {
        String msg = "Something went wrong";
        try {
          final decoded = jsonDecode(responseBody);
          if (decoded is Map && decoded['message'] != null) {
            msg = decoded['message'];
          }
        } catch (_) {}

        // Get.back(); // close dialog first if open
        Get.snackbar(
          "Error",
          msg,
          backgroundColor: Colors.red.shade600.withOpacity(0.95),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(12),
          borderRadius: 10,
          icon: const Icon(Icons.error_outline, color: Colors.white),
          overlayBlur: 0,
          overlayColor: Colors.transparent,
          isDismissible: true,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DropdownButton<String>(
            value: selectedOption,
            hint: const Text("Pickup Option"),
            items: const [
              DropdownMenuItem(
                  value: "discontinue", child: Text("Discontinue")),
              DropdownMenuItem(value: "reschedule", child: Text("Reschedule")),
              DropdownMenuItem(value: "pickup", child: Text("Pickup")),
            ],
            onChanged: (value) => setState(() => selectedOption = value),
          ),
          const SizedBox(height: 10),

          // ✅ Reschedule section
          if (selectedOption == "reschedule")
            GestureDetector(
              onTap: pickRescheduleDateTime,
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: rescheduleDateTime != null
                        ? DateFormat("yyyy-MM-dd HH:mm:ss")
                            .format(rescheduleDateTime!)
                        : "Select Reschedule Date & Time",
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ),

          // ✅ Pickup form
          if (selectedOption == "pickup") ...[
            const SizedBox(height: 5),
            _buildTextField(otpController, "OTP"),
            _buildTextField(ramController, "RAM"),
            _buildTextField(storageController, "Storage"),
            _buildTextField(processorController, "Processor"),
            _buildTextField(modelController, "Model"),
            _buildTextField(noteController, "Note"),
            const SizedBox(height: 10),

            // ✅ Camera & Gallery Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: pickImageFromCamera,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Camera"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: pickImagesFromGallery,
                    icon: const Icon(Icons.photo_library),
                    label: const Text("Gallery"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ✅ Show existing + selected images
            if (existingImageUrls.isNotEmpty || selectedImages.isNotEmpty)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemCount: existingImageUrls.length + selectedImages.length,
                itemBuilder: (context, index) {
                  final isRemote = index < existingImageUrls.length;
                  if (isRemote) {
                    final imageUrl = existingImageUrls[index];
                    return Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.broken_image, color: Colors.grey),
                    );
                  } else {
                    final localIndex = index - existingImageUrls.length;
                    final file = selectedImages[localIndex];
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: Image.file(file, fit: BoxFit.cover),
                        ),
                        Positioned(
                          top: 2,
                          right: 2,
                          child: GestureDetector(
                            onTap: () => setState(() {
                              selectedImages.removeAt(localIndex);
                            }),
                            child: const CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.black54,
                              child: Icon(Icons.close,
                                  size: 14, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
          ],

          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: selectedOption != null ? updatePickupOption : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text(
                "Update",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
