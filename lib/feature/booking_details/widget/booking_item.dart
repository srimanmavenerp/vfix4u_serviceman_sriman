import 'package:get/get.dart';
import 'package:demandium_serviceman/utils/core_export.dart';

class BookingItem extends StatelessWidget {
  const BookingItem({super.key, required this.img, required this.title, required this.date})
      ;
  final String img;
  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image(image: AssetImage(img),height: 15,width: 15),
        const SizedBox(width:Dimensions.paddingSizeSmall),
        Expanded(
          child: Row(
            children: [
              Flexible(
                child: Text(title.tr,
                  style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha:0.6)),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(date,
                style: robotoRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color: Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha:0.6)),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textDirection: TextDirection.ltr,
              ),
            ],
          ),
        ),
      ],
    );
  }
}