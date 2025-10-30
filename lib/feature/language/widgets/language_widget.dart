// import 'package:demandium_serviceman/utils/core_export.dart';
// import 'package:get/get.dart';
//
// class LanguageWidget extends StatelessWidget {
//   final LanguageModel languageModel;
//   final LocalizationController localizationController;
//   final int index;
//   const LanguageWidget({super.key,
//     required this.languageModel,
//     required this.localizationController,
//     required this.index,
//   }) ;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         localizationController.setSelectIndex(index);
//       },
//       child: Container(
//         padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
//         margin: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
//         decoration: BoxDecoration(
//             color: Get.isDarkMode?Colors.grey.withValues(alpha:0.2) : Theme.of(context).cardColor,
//
//             borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//             boxShadow: Get.find<ThemeController>().darkTheme ? null : shadow
//         ),
//         child: Stack(children: [
//
//           Center(
//             child: Column(mainAxisSize: MainAxisSize.min, children: [
//               // Container(
//               //   height: 65, width: 65,
//               //   decoration: BoxDecoration(
//               //     borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//               //     border: Border.all(color: Theme.of(context).textTheme.bodyLarge!.color!, width: 1),
//               //   ),
//               //   alignment: Alignment.center,
//               //   child: Image.asset(
//               //     languageModel.imageUrl!, width: 36, height: 36,
//               //
//               //   ),
//               // ),
//               const SizedBox(height: Dimensions.paddingSizeLarge),
//               Text(languageModel.languageName!, style: robotoRegular),
//             ]),
//           ),
//
//           localizationController.selectedIndex == index ? Positioned(
//             top: 0, right: 0,
//             child: Icon(Icons.check_circle, color: Theme.of(context).primaryColorLight, size: 25),
//           ) : const SizedBox(),
//
//         ]),
//       ),
//     );
//   }
// }



import 'package:demandium_serviceman/utils/core_export.dart';
import 'package:get/get.dart';

class LanguageWidget extends StatelessWidget {
  final LanguageModel languageModel;
  final LocalizationController localizationController;
  final int index;

  const LanguageWidget({
    super.key,
    required this.languageModel,
    required this.localizationController,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = localizationController.selectedIndex == index;

    return GestureDetector(
      onTap: () {
        localizationController.setSelectIndex(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(
            vertical: Dimensions.paddingSizeLarge,
            horizontal: Dimensions.paddingSizeExtraLarge),
        margin: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor.withOpacity(0.1)
              : Get.isDarkMode
              ? Colors.grey.withOpacity(0.2)
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          boxShadow: Get.find<ThemeController>().darkTheme ? null : shadow,
          border: isSelected
              ? Border.all(color: Theme.of(context).primaryColor, width: 2)
              : null,
        ),
        child: Center(
          child: Text(
            languageModel.languageName!,
            textAlign: TextAlign.center,
            style: robotoMedium.copyWith(
              fontSize: 16,
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
        ),
      ),
    );
  }
}
