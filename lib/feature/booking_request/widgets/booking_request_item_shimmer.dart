import 'package:demandium_serviceman/utils/core_export.dart';
import 'package:get/get.dart';

class BookingRequestItemShimmer extends StatelessWidget {
  const BookingRequestItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(


      itemBuilder: (context ,index){
      return Padding(padding: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeSmall- 3,
          horizontal: Dimensions.paddingSizeDefault
      ),
        child: Shimmer(duration: const Duration(seconds: 2), child: Container(
          height: 130, width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            color: Theme.of(context).hintColor.withValues(alpha:0.2),
          ),
          child:  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [


            Padding(padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault,
              vertical: Dimensions.paddingSizeSmall + 2,
            ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [


                Column( crossAxisAlignment: CrossAxisAlignment.start, children: [


                  Container(height: 20, width: 150,
                    decoration: BoxDecoration(
                        color: Get.isDarkMode? Colors.grey.shade700 : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault)
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),


                  Container(height: 15 , width: 200,
                    decoration: BoxDecoration(
                        color: Get.isDarkMode? Colors.grey.shade700 : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault)
                    ),
                  ),


                ]),


                Container(height: 20, width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
                    color: Get.isDarkMode? Colors.grey.shade700 : Colors.grey.shade100,
                  ),
                ),


              ]),
            ),


            Divider(height: 1, thickness: 3, color: Theme.of(context).primaryColor.withValues(alpha:0.04)),

            const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

            Padding(padding: const EdgeInsets.symmetric(horizontal: 15 ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [


                Column( crossAxisAlignment: CrossAxisAlignment.start, children: [


                  Container(height: 15, width: 150,
                    decoration: BoxDecoration(
                        color: Get.isDarkMode? Colors.grey.shade700 : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault)
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),


                  Container(height: 15, width: 140,
                    decoration: BoxDecoration(
                        color: Get.isDarkMode? Colors.grey.shade700 : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault)
                    ),
                  ),


                ]),


                Column( crossAxisAlignment: CrossAxisAlignment.end, children: [


                  Container(height: Dimensions.paddingSizeDefault, width: 120,
                    decoration: BoxDecoration(
                        color: Get.isDarkMode? Colors.grey.shade700 : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault)
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),


                  Container(height: Dimensions.paddingSizeExtraLarge,
                    width: Dimensions.paddingSizeExtraLarge * 4,
                    decoration: BoxDecoration(
                        color: Get.isDarkMode? Colors.grey.shade700 : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault)
                    ),
                  ),


                ]),


              ]),
            ),


          ]),
        )),
      );
    },shrinkWrap: true, itemCount: 10,);
  }
}