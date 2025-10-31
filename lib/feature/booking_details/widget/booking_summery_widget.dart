import 'package:demandium_serviceman/helper/booking_helper.dart';
import 'package:demandium_serviceman/utils/core_export.dart';
import 'package:demandium_serviceman/feature/booking_details/model/booking_details_model.dart';
import 'package:get/get.dart';

class BookingSummeryView extends StatelessWidget {
  final BookingDetailsContent bookingDetails;
  const BookingSummeryView({super.key, required this.bookingDetails});

  get index => null;
  // The list of services to show

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingDetailsController>(
      builder: (bookingDetailsController) {

      final List<ServiceData> serviceData = bookingDetails.serviceData ?? [];

        double paidAmount = 0;

        double discount = bookingDetails.totalDiscountAmount ?? 0;
        double campaignDiscount = double.tryParse(
                bookingDetails.totalCampaignDiscountAmount ?? "0") ??
            0;
        double totalDiscount = (discount + campaignDiscount);
        double subTotal = BookingHelper.getSubTotalCost(bookingDetails);

        double totalBookingAmount = bookingDetails.totalBookingAmount ?? 0;
        bool isPartialPayment = bookingDetails.partialPayments != null &&
            bookingDetails.partialPayments!.isNotEmpty;

        if (isPartialPayment) {
          bookingDetails.partialPayments?.forEach((element) {
            paidAmount = paidAmount + (element.paidAmount ?? 0);
          });
        } else {
          paidAmount =
              totalBookingAmount - (bookingDetails.additionalCharge ?? 0);
        }

        double dueAmount = totalBookingAmount - paidAmount;
        double additionalCharge = isPartialPayment
            ? totalBookingAmount - paidAmount
            : bookingDetails.additionalCharge ?? 0;
      final Object couponDiscount = bookingDetails.totalCouponDiscountAmount ?? 0;

      double totalReferralDiscountAmount = bookingDetails.totalReferralDiscountAmount ?? 0 ;
        // double totalCouponDiscountAmount = bookingDetails.totalCouponDiscountAmount ?? 0 ;
        //final double sub_Total = total - totalDiscounts + extraFee;
     // final double subTotalALL = subTotal + (bookingDetails.extraFee ?? 0) - totalDiscount;
    // final double subTotalALL = subTotal + (bookingDetails.extraFee ?? 0) - discount;
      //final double subTotalALL = subTotal + (bookingDetails.extraFee ?? 0) - totalDiscount-totalReferralDiscountAmount{bookingDetails.totalCouponDiscountAmount};
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault,
                  vertical: Dimensions.paddingSizeSmall),
              child: Text(
                "booking_summary".tr,
                style: robotoBold.copyWith(
                  fontSize: Dimensions.fontSizeLarge,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color
                      ?.withValues(alpha: 0.9),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withValues(alpha: 0.5),
                boxShadow:
                    Get.find<ThemeController>().darkTheme ? null : lightShadow,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    Container(
                      color: Theme.of(context)
                          .primaryColor
                          .withValues(alpha: 0.05),
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("service_info".tr,
                              style: robotoBold.copyWith(
                                  fontSize: Dimensions.fontSizeLarge,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color!
                                      .withValues(alpha: 0.8),
                                  decoration: TextDecoration.none)),
                          Text("price".tr,
                              style: robotoBold.copyWith(
                                  fontSize: Dimensions.fontSizeLarge,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color!
                                      .withValues(alpha: 0.8),
                                  decoration: TextDecoration.none)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeExtraSmall,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(children: [
                        ListView.builder(
                          itemCount: bookingDetails.details?.length,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ServiceInfoItem(
                              bookingService: bookingDetails.details?[index],
                              bookingDetailsController:
                                  bookingDetailsController,
                              index: index,
                            );
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Dimensions.paddingSizeDefault),
                          child: Divider(
                            height: 2,
                            color: Colors.grey,
                          ),
                        ),

                        Row(    ///// 7 th
                          children: [
                            Expanded(
                              child: Text(
                                "Total".tr,
                                style: robotoRegular.copyWith(
                                    fontSize: Dimensions.fontSizeDefault,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color
                                        ?.withValues(alpha: 0.9)),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(
                              width: Dimensions.paddingSizeDefault,
                            ),
                            Text(
                              PriceConverter.convertPrice(subTotal,
                                  isShowLongPrice: true),
                              style: robotoRegular.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color
                                      ?.withValues(alpha: 0.9)),
                            ),
                          ],
                        ),

                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Text(
                        //         "subtotal".tr,
                        //         style: robotoRegular.copyWith(
                        //             fontSize: Dimensions.fontSizeDefault,
                        //             color: Theme.of(context)
                        //                 .textTheme
                        //                 .bodyLarge!
                        //                 .color
                        //                 ?.withValues(alpha: 0.9)),
                        //         overflow: TextOverflow.ellipsis,
                        //       ),
                        //     ),
                        //     const SizedBox(
                        //       width: Dimensions.paddingSizeDefault,
                        //     ),
                        //     Text(
                        //       PriceConverter.convertPrice(subTotalALL,
                        //           isShowLongPrice: true),
                        //       style: robotoRegular.copyWith(
                        //           fontSize: Dimensions.fontSizeDefault,
                        //           color: Theme.of(context)
                        //               .textTheme
                        //               .bodyLarge!
                        //               .color
                        //               ?.withValues(alpha: 0.9)),
                        //     ),
                        //   ],
                        // ),

                        const SizedBox(
                          height: Dimensions.paddingSizeExtraSmall,
                        ),

                        if (bookingDetails.extraFee != null &&   ///// 2rd
                            bookingDetails.extraFee! > 0)
                          Padding(
                            padding: const EdgeInsets.only(
                                top: Dimensions.paddingSizeExtraSmall),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    Get.find<SplashController>()
                                        .configModel
                                        ?.content
                                        ?.additionalChargeLabelName ??
                                        "",
                                    style: robotoRegular.copyWith(
                                        fontSize: Dimensions.fontSizeDefault,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color
                                            ?.withValues(alpha: 0.9)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(
                                  width: Dimensions.paddingSizeDefault,
                                ),
                                Text(
                                  "(+) ${PriceConverter.convertPrice(bookingDetails.extraFee ?? 0, isShowLongPrice: true)}",
                                  style: robotoRegular.copyWith(
                                      fontSize: Dimensions.fontSizeDefault,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color
                                          ?.withValues(alpha: 0.9)),
                                ),
                              ],
                            ),
                          ),
                        // const SizedBox(height: Dimensions.paddingSizeSmall),
                        // Row(  ////////
                        //   children: [
                        //     Expanded(
                        //       child: Text(
                        //         "GST".tr,
                        //         style: robotoRegular.copyWith(
                        //             fontSize: Dimensions.fontSizeDefault,
                        //             color: Theme.of(context)
                        //                 .textTheme
                        //                 .bodyLarge!
                        //                 .color
                        //                 ?.withValues(alpha: 0.9)),
                        //         overflow: TextOverflow.ellipsis,
                        //       ),
                        //     ),
                        //     const SizedBox(
                        //       width: Dimensions.paddingSizeDefault,
                        //     ),
                        //     Text(
                        //       "(+) ${PriceConverter.convertPrice(bookingDetails.totalTaxAmount ?? 0, isShowLongPrice: true)}",
                        //       style: robotoRegular.copyWith(
                        //           fontSize: Dimensions.fontSizeDefault,
                        //           color: Theme.of(context)
                        //               .textTheme
                        //               .bodyLarge!
                        //               .color
                        //               ?.withValues(alpha: 0.9)),
                        //     ),
                        //   ],
                        // ),

                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        Row(   /// 3rd
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    "service_discount".tr,
                                    style: robotoRegular.copyWith(
                                        fontSize: Dimensions.fontSizeDefault,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color
                                            ?.withValues(alpha: 0.9)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    width: Dimensions.paddingSizeExtraSmall,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: Dimensions.paddingSizeDefault,
                            ),
                            Text(
                              "(-) ${PriceConverter.convertPrice(totalDiscount, isShowLongPrice: true)}",
                              style: robotoRegular.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color
                                      ?.withValues(alpha: 0.9)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: Dimensions.paddingSizeExtraSmall,
                        ),
                        Row(    //4th
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    "coupon_discount".tr,
                                    style: robotoRegular.copyWith(
                                        fontSize: Dimensions.fontSizeDefault,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color
                                            ?.withValues(alpha: 0.9)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    width: Dimensions.paddingSizeExtraSmall,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: Dimensions.paddingSizeDefault,
                            ),
                            Text(
                              "(-) ${PriceConverter.convertPrice(double.tryParse(bookingDetails.totalCouponDiscountAmount!), isShowLongPrice: true)}",
                              style: robotoRegular.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color
                                      ?.withValues(alpha: 0.9)),
                            ),
                          ],
                        ),
                        if (bookingDetails.totalReferralDiscountAmount !=
                                null &&
                            bookingDetails.totalReferralDiscountAmount! > 0)
                          const SizedBox(height: Dimensions.paddingSizeSmall),
                        if (bookingDetails.totalReferralDiscountAmount !=
                                null &&
                            bookingDetails.totalReferralDiscountAmount! > 0)
                          Row(    // 5th
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'referral_discount'.tr,
                                style: robotoRegular.copyWith(
                                    fontSize: Dimensions.fontSizeDefault,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Text(
                                    '(-) ${PriceConverter.convertPrice(bookingDetails.totalReferralDiscountAmount ?? 0)}',
                                    style: robotoRegular.copyWith(
                                        fontSize: Dimensions.fontSizeDefault,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color!)),
                              ),
                            ],
                          ),
                        const SizedBox(
                          height: Dimensions.paddingSizeExtraSmall,
                        ),



                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Text(
                        //         "Subtotal".tr,
                        //         style: robotoRegular.copyWith(
                        //             fontSize: Dimensions.fontSizeDefault,
                        //             color: Theme.of(context)
                        //                 .textTheme
                        //                 .bodyLarge!
                        //                 .color
                        //                 ?.withValues(alpha: 0.9)),
                        //         overflow: TextOverflow.ellipsis,
                        //       ),
                        //     ),
                        //     const SizedBox(
                        //       width: Dimensions.paddingSizeDefault,
                        //     ),
                        //     Text(
                        //       PriceConverter.convertPrice(subTotalALL,
                        //           isShowLongPrice: true),
                        //       style: robotoRegular.copyWith(
                        //           fontSize: Dimensions.fontSizeDefault,
                        //           color: Theme.of(context)
                        //               .textTheme
                        //               .bodyLarge!
                        //               .color
                        //               ?.withValues(alpha: 0.9)),
                        //     ),
                        //   ],
                        // ),
                        //
                        // const SizedBox(
                        //   height: Dimensions.paddingSizeExtraSmall,
                        // ),

                        Row(  ////////
                          children: [
                            Expanded(
                              child: Text(
                                "GST".tr,
                                style: robotoRegular.copyWith(
                                    fontSize: Dimensions.fontSizeDefault,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color
                                        ?.withValues(alpha: 0.9)),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(
                              width: Dimensions.paddingSizeDefault,
                            ),
                            Text(
                              "(+) ${PriceConverter.convertPrice(bookingDetails.totalTaxAmount ?? 0, isShowLongPrice: true)}",
                              style: robotoRegular.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color
                                      ?.withValues(alpha: 0.9)),
                            ),
                          ],
                        ),


                        const Divider(
                          height: 2,
                          color: Colors.grey,
                        ),

                        const SizedBox(
                            height: Dimensions.paddingSizeExtraSmall),
                        !isPartialPayment &&
                                bookingDetails.paymentMethod != "wallet_payment"
                            ? (additionalCharge == 0) ||
                                    bookingDetails.paymentMethod ==
                                        "cash_after_service"
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'grand_total'.tr,
                                        style: robotoBold.copyWith(
                                            fontSize: Dimensions.fontSizeSmall,
                                            color:
                                                Theme.of(context).primaryColor),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: Text(
                                          PriceConverter.convertPrice(
                                              bookingDetails
                                                      .totalBookingAmount ??
                                                  0,
                                              isShowLongPrice: true),
                                          style: robotoBold.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeDefault,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(
                                        Dimensions.paddingSizeSmall),
                                    child: DottedBorder(
                                      dashPattern: const [8, 4],
                                      strokeWidth: 1.1,
                                      borderType: BorderType.RRect,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      radius: const Radius.circular(
                                          Dimensions.radiusDefault),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withValues(alpha: 0.02),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal:
                                                Dimensions.paddingSizeSmall,
                                            vertical:
                                                Dimensions.paddingSizeSmall),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'grand_total'.tr,
                                                  style: robotoBold.copyWith(
                                                    fontSize: Dimensions
                                                        .fontSizeSmall,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Directionality(
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  child: Text(
                                                    PriceConverter.convertPrice(
                                                        totalBookingAmount,
                                                        isShowLongPrice: true),
                                                    style: robotoBold.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeDefault,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height:
                                                  Dimensions.paddingSizeSmall,
                                            ),
                                            additionalCharge > 0
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                        Text(
                                                          "${(bookingDetails.bookingStatus == "pending" || bookingDetails.bookingStatus == "accepted" || bookingDetails.bookingStatus == "ongoing") ? "due_amount".tr : "paid_amount".tr} (${"cash_after_service".tr})",
                                                          style: robotoRegular.copyWith(
                                                              fontSize: Dimensions
                                                                  .fontSizeSmall,
                                                              color: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .color),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Directionality(
                                                          textDirection:
                                                              TextDirection.ltr,
                                                          child: Text(
                                                            PriceConverter.convertPrice(
                                                                additionalCharge,
                                                                isShowLongPrice:
                                                                    true),
                                                            style: robotoRegular.copyWith(
                                                                fontSize: Dimensions
                                                                    .fontSizeDefault,
                                                                color: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .color),
                                                          ),
                                                        )
                                                      ])
                                                : const SizedBox()
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                            : !isPartialPayment &&
                                    bookingDetails.paymentMethod ==
                                        "wallet_payment"
                                ? Padding(
                                    padding: const EdgeInsets.all(
                                        Dimensions.paddingSizeSmall),
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'grand_total'.tr,
                                            style: robotoBold.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeSmall,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: Text(
                                                PriceConverter.convertPrice(
                                                    bookingDetails
                                                            .totalBookingAmount ??
                                                        0,
                                                    isShowLongPrice: true),
                                                style: robotoBold.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeDefault,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                )),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: Dimensions.paddingSizeSmall,
                                      ),
                                      DottedBorder(
                                        dashPattern: const [8, 4],
                                        strokeWidth: 1.1,
                                        borderType: BorderType.RRect,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        radius: const Radius.circular(
                                            Dimensions.radiusDefault),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withValues(alpha: 0.02),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal:
                                                  Dimensions.paddingSizeSmall,
                                              vertical:
                                                  Dimensions.paddingSizeSmall),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  (bookingDetails
                                                              .additionalCharge! <=
                                                          0)
                                                      ? 'total_order_amount_has_been_paid_by_customer'
                                                          .tr
                                                      : "has_been_paid_by_customer"
                                                          .tr,
                                                  style: robotoMedium.copyWith(
                                                    fontSize: Dimensions
                                                        .fontSizeDefault,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(
                                                  height: Dimensions
                                                      .paddingSizeSmall,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                            Images.walletSmall,
                                                            width: 17,
                                                          ),
                                                          const SizedBox(
                                                            width: Dimensions
                                                                .paddingSizeExtraSmall,
                                                          ),
                                                          Text(
                                                            'via_wallet'.tr,
                                                            style: robotoRegular.copyWith(
                                                                fontSize: Dimensions
                                                                    .fontSizeSmall,
                                                                color: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .color),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                      Directionality(
                                                        textDirection:
                                                            TextDirection.ltr,
                                                        child: Text(
                                                          PriceConverter
                                                              .convertPrice(
                                                                  paidAmount,
                                                                  isShowLongPrice:
                                                                      true),
                                                          style: robotoRegular.copyWith(
                                                              fontSize: Dimensions
                                                                  .fontSizeDefault,
                                                              color: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .color),
                                                        ),
                                                      )
                                                    ]),
                                                if (additionalCharge > 0)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "${(bookingDetails.bookingStatus == "pending" || bookingDetails.bookingStatus == "accepted" || bookingDetails.bookingStatus == "ongoing") ? "due_amount".tr : "paid_amount".tr} (${"cash_after_service".tr})",
                                                            style: robotoRegular.copyWith(
                                                                fontSize: Dimensions
                                                                    .fontSizeSmall,
                                                                color: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .color),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          Directionality(
                                                            textDirection:
                                                                TextDirection
                                                                    .ltr,
                                                            child: Text(
                                                              PriceConverter
                                                                  .convertPrice(
                                                                      additionalCharge,
                                                                      isShowLongPrice:
                                                                          true),
                                                              style: robotoRegular.copyWith(
                                                                  fontSize:
                                                                      Dimensions
                                                                          .fontSizeDefault,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyLarge!
                                                                      .color),
                                                            ),
                                                          )
                                                        ]),
                                                  )
                                              ]),
                                        ),
                                      ),
                                    ]),
                                  )
                                : isPartialPayment
                                    ? Padding(
                                        padding: const EdgeInsets.all(
                                            Dimensions.paddingSizeSmall),
                                        child: DottedBorder(
                                          dashPattern: const [8, 4],
                                          strokeWidth: 1.1,
                                          borderType: BorderType.RRect,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          radius: const Radius.circular(
                                              Dimensions.radiusDefault),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor
                                                  .withValues(alpha: 0.02),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal:
                                                    Dimensions.paddingSizeSmall,
                                                vertical: Dimensions
                                                    .paddingSizeSmall),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'grand_total'.tr,
                                                      style:
                                                          robotoBold.copyWith(
                                                        fontSize: Dimensions
                                                            .fontSizeSmall,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Directionality(
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      child: Text(
                                                        PriceConverter
                                                            .convertPrice(
                                                                totalBookingAmount,
                                                                isShowLongPrice:
                                                                    true),
                                                        style:
                                                            robotoBold.copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeDefault,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: Dimensions
                                                      .paddingSizeSmall,
                                                ),
                                                ListView.builder(
                                                  itemBuilder:
                                                      (context, index) {
                                                    String payWith =
                                                        bookingDetails
                                                                .partialPayments?[
                                                                    index]
                                                                .paidWith ??
                                                            "";

                                                    return Padding(
                                                      padding: const EdgeInsets
                                                          .only(
                                                          bottom: Dimensions
                                                              .paddingSizeExtraSmall),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Image.asset(
                                                                  Images
                                                                      .walletSmall,
                                                                  width: 15,
                                                                ),
                                                                const SizedBox(
                                                                  width: Dimensions
                                                                      .paddingSizeExtraSmall,
                                                                ),
                                                                Text(
                                                                  '${payWith == "cash_after_service" ? "paid_amount".tr : payWith == "digital" && bookingDetails.paymentMethod == "offline_payment" ? "" : 'paid_by'.tr} '
                                                                  '${payWith == "digital" ? "${bookingDetails.paymentMethod}".tr : (payWith == "cash_after_service" ? "(${'cash_after_service'.tr})" : payWith).tr}',
                                                                  style: robotoRegular.copyWith(
                                                                      fontSize:
                                                                          Dimensions
                                                                              .fontSizeSmall,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyLarge!
                                                                          .color),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ],
                                                            ),
                                                            Directionality(
                                                              textDirection:
                                                                  TextDirection
                                                                      .ltr,
                                                              child: Text(
                                                                PriceConverter.convertPrice(
                                                                    bookingDetails
                                                                            .partialPayments?[
                                                                                index]
                                                                            .paidAmount ??
                                                                        0,
                                                                    isShowLongPrice:
                                                                        true),
                                                                style: robotoRegular.copyWith(
                                                                    fontSize:
                                                                        Dimensions
                                                                            .fontSizeDefault,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyLarge!
                                                                        .color),
                                                              ),
                                                            )
                                                          ]),
                                                    );
                                                  },
                                                  itemCount: bookingDetails
                                                      .partialPayments?.length,
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                ),
                                                bookingDetails.partialPayments
                                                                ?.length ==
                                                            1 &&
                                                        dueAmount > 0
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                            Text(
                                                              "${(bookingDetails.bookingStatus == "pending" || bookingDetails.bookingStatus == "accepted" || bookingDetails.bookingStatus == "ongoing") ? "due_amount".tr : "paid_amount".tr} (${"cash_after_service".tr})",
                                                              style: robotoRegular.copyWith(
                                                                  fontSize:
                                                                      Dimensions
                                                                          .fontSizeSmall,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyLarge!
                                                                      .color),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            Directionality(
                                                              textDirection:
                                                                  TextDirection
                                                                      .ltr,
                                                              child: Text(
                                                                PriceConverter
                                                                    .convertPrice(
                                                                        dueAmount,
                                                                        isShowLongPrice:
                                                                            true),
                                                                style: robotoRegular.copyWith(
                                                                    fontSize:
                                                                        Dimensions
                                                                            .fontSizeDefault,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyLarge!
                                                                        .color),
                                                              ),
                                                            )
                                                          ])
                                                    : const SizedBox(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal:
                                                Dimensions.paddingSizeDefault),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'grand_total'.tr,
                                              style: robotoBold.copyWith(
                                                  fontSize:
                                                      Dimensions.fontSizeSmall,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: Text(
                                                PriceConverter.convertPrice(
                                                    totalBookingAmount,
                                                    isShowLongPrice: true),
                                                style: robotoBold.copyWith(
                                                    fontSize: Dimensions
                                                        .fontSizeDefault,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),


                                      if (bookingDetails.serviceData != null && bookingDetails.serviceData!.isNotEmpty)
  Padding(
    padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Table to display service data with borders
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1), // Border around the entire table
            borderRadius: BorderRadius.circular(5), // Optional: rounded corners for the table
          ),
          child: Table(
            border: TableBorder.all(color: Colors.grey, width: 1), // Border for each table cell
            children: [
              // Table Header Row (Optional)
              TableRow(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Extra Service",
                      style: robotoRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Amount",
                      style: robotoRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              // Service data rows (dynamic)
              ...bookingDetails.serviceData!.map((service) {
                return TableRow(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        service.serviceName ?? "",
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: Theme.of(context).textTheme.bodyLarge!.color?.withValues(alpha: 0.9),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.centerRight,
                      child: Text(
                        PriceConverter.convertPrice(service.serviceAmount ?? 0, isShowLongPrice: true),
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: Theme.of(context).textTheme.bodyLarge!.color?.withValues(alpha: 0.9),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ],
    ),
  ),

                        const SizedBox(
                          height: Dimensions.paddingSizeSmall,
                        ),
                      ]),
                    )
                  ]),
            ),
          ],
        );
      },
    );
  }
}

class ServiceInfoItem extends StatelessWidget {
  final int index;
  final BookingDetailsController bookingDetailsController;
  final ItemService? bookingService;
  const ServiceInfoItem(
      {super.key,
      required this.bookingService,
      required this.bookingDetailsController,
      required this.index});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: Dimensions.paddingSizeSmall),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(
              bookingService?.serviceName ?? "",
              style: robotoRegular.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color
                      ?.withValues(alpha: 0.9)),
              overflow: TextOverflow.ellipsis,
            )),
            const SizedBox(
              width: Dimensions.paddingSizeDefault,
            ),
            Text(
              PriceConverter.convertPrice(
                BookingHelper.getBookingServiceUnitConst(bookingService),
                isShowLongPrice: true,
              ),
              style: robotoRegular.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color
                      ?.withValues(alpha: 0.9)),
            ),
          ],
        ),
        const SizedBox(
          height: Dimensions.paddingSizeExtraSmall - 2,
        ),

        if (bookingService?.variantKey != null)
          Padding(
            padding:
                const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
            child: Row(children: [
              Text(
                bookingService?.variantKey
                        ?.replaceAll("-", " ")
                        .capitalizeFirst ??
                    "",
                style: robotoRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.color
                        ?.withValues(alpha: 0.7)),
              ),
              Container(
                height: 10,
                width: 0.5,
                color: Theme.of(context).hintColor,
                margin: const EdgeInsets.only(
                    left: Dimensions.paddingSizeSmall,
                    right: Dimensions.paddingSizeSmall,
                    top: 5),
              ),
              Row(children: [
                Text(
                  "${"qty".tr} : ${bookingService?.quantity}",
                  style: robotoRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.color
                        ?.withValues(alpha: 0.7),
                  ),
                ),
              ]),
            ]),
          ),

        priceText("unit_price".tr, bookingService?.serviceCost ?? "0", context),

        // const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
        // (bookingService?.discountAmount ?? 0) > 0
        //     ? priceText("discount".tr,
        //     (bookingService?.discountAmount ?? 0), context)
        //     : const SizedBox(),
        // (bookingService?.campaignDiscountAmount ?? 0) > 0
        //     ? priceText("campaign".tr,
        //     (bookingService?.campaignDiscountAmount??"0"),
        //     context)
        //     : const SizedBox(),
        //
        // (bookingService?.overallCouponDiscountAmount ?? 0) > 0
        //     ? priceText("coupon".tr, (bookingService?.overallCouponDiscountAmount?? 0), context)
        //     : const SizedBox(),
        //
        // bookingService?.service != null && (bookingService?.service?.tax??0) > 0
        //     ? priceText(
        //     "tax".tr, (bookingService?.taxAmount?? 0), context)
        //     : const SizedBox(),
      ],
    );
  }
}

Widget priceText(String title, var amount, context) {
  return Column(
    children: [
      Row(
        children: [
          Text(
            "$title : ",
            style: robotoRegular.copyWith(
                fontSize: Dimensions.fontSizeSmall,
                color: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.color
                    ?.withValues(alpha: 0.7)),
          ),
          Text(
            PriceConverter.convertPrice(amount, isShowLongPrice: true),
            style: robotoRegular.copyWith(
                fontSize: Dimensions.fontSizeSmall,
                color: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.color
                    ?.withValues(alpha: 0.7)),
          ),
        ],
      ),
      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
    ],
  );
}





