import 'package:get/get.dart';
import 'package:demandium_serviceman/utils/core_export.dart';


class BookingInformationView extends StatelessWidget {
  final BookingDetailsContent bookingDetails;
  final bool isSubBooking;
  const BookingInformationView({super.key, required this.bookingDetails, required this.isSubBooking}) ;

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<BookingDetailsController>(builder: (bookingDetailsController){

      return Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          const SizedBox(height:Dimensions.paddingSizeDefault),
          BookingItem(
            img: Images.iconCalendar,
            title: '${'booking_date'.tr} : ',
            date: DateConverter.dateMonthYearTime(
                DateConverter.isoUtcStringToLocalDate(bookingDetails.createdAt!)),
          ),
         const SizedBox(height:Dimensions.paddingSizeSmall),

          BookingItem(
            img: Images.iconCalendar,
            title: '${'schedule_date'.tr} : ',
            date: bookingDetails.serviceSchedule != null ? ' ${DateConverter.dateMonthYearTime(DateTime.tryParse(bookingDetails.serviceSchedule!))}' : "",
          ),
          const SizedBox(height:Dimensions.paddingSizeSmall),

          BookingItem(
            img: Images.iconLocation,
            title: '${'service_address'.tr} : ${bookingDetails.serviceAddress?.address ?? bookingDetails.subBooking?.serviceAddress?.address ?? 'address_not_found'.tr

            }',
            date: '',
          ),
          const SizedBox(height:Dimensions.paddingSizeDefault),
          Text("payment_method".tr,
            style: robotoBold.copyWith(
                fontSize: Dimensions.fontSizeDefault,
                color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
          const SizedBox(height:Dimensions.paddingSizeExtraSmall),

          Text("${bookingDetails.paymentMethod!.tr} ${ bookingDetails.partialPayments !=null  && bookingDetails.partialPayments!.isNotEmpty ? "&_wallet_balance".tr: ""}",
              style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha:.5))),
          const SizedBox(height:Dimensions.paddingSizeExtraSmall),

          (bookingDetails.paymentMethod !="cash_after_service" && bookingDetails.paymentMethod !="offline_payment") ?
          Padding(padding: const EdgeInsets.only(bottom : Dimensions.paddingSizeExtraSmall),
            child: Text("${'transaction_id'.tr} : ${bookingDetails.transactionId}",
              style: robotoRegular.copyWith(
                fontSize: Dimensions.fontSizeSmall,
                color: Theme.of(context).hintColor,
              ),
            ),
          ):const SizedBox.shrink(),

          Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
            child: RichText(
              text: TextSpan(text: "${'payment_status'.tr} : ",
                style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor),
                children: <TextSpan>[
                  TextSpan(
                    text: bookingDetails.partialPayments != null && bookingDetails.partialPayments!.isNotEmpty && bookingDetails.isPaid == 0 ? "partially_paid".tr :  bookingDetails.isPaid == 0 ? "unpaid".tr : "paid".tr,
                    style: robotoBold.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: bookingDetails.partialPayments != null && bookingDetails.partialPayments!.isNotEmpty && bookingDetails.isPaid == 0 ? Theme.of(context).primaryColor : bookingDetails.isPaid == 0 ?
                      Theme.of(context).colorScheme.error: Colors.green,
                    ),
                  )
                ],
              ),
            ),
          ),

          Row(
            children: [
              Text("${'amount'.tr} : ",
                style: robotoBold.copyWith(
                  fontSize: Dimensions.fontSizeSmall,
                  color: Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha:0.7),
                ),
              ),

              Text(PriceConverter.convertPrice(bookingDetails.totalBookingAmount ?? 0,isShowLongPrice:true),
                style: robotoBold.copyWith(
                  fontSize: Dimensions.fontSizeSmall,
                  color: Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha:0.7),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}


