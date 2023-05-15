// import 'package:music_instruments/src/helpers/data/models.dart';
//
// final List<SubCategoryItem> subCategoryItemsList = [
//   ...List.generate(
//     10,
//     (index) => SubCategoryItem(
//       id: index,
//       subCategoryId: 0,
//       filePath: 'assets/audio/default.mp3',
//       title: 'Sato $index',
//       image: 'assets/images/def_image.png',
//       desc:
//           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut et massa mi. Aliquam in hendrerit urna. Pellentesque sit amet sapien fringilla, mattis ligula consectetur, ultrices mauris. Maecenas vitae mattis tellus. Nullam quis imperdiet augue. Vestibulum auctor ornare leo, non suscipit magna interdum eu. Curabitur pellentesque nibh nibh, at maximus ante fermentum sit amet.',
//     ),
//   ),
//   ...List.generate(
//     12,
//     (index) => SubCategoryItem(
//       id: index,
//       subCategoryId: 1,
//       title: 'Tambur $index',
//       image: 'assets/images/def_image.png',
//       desc:
//           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut et massa mi. Aliquam in hendrerit urna. Pellentesque sit amet sapien fringilla, mattis ligula consectetur, ultrices mauris. Maecenas vitae mattis tellus. Nullam quis imperdiet augue. Vestibulum auctor ornare leo, non suscipit magna interdum eu. Curabitur pellentesque nibh nibh, at maximus ante fermentum sit amet.',
//     ),
//   ),
//   ...List.generate(
//     4,
//     (index) => SubCategoryItem(
//       id: index,
//       subCategoryId: 2,
//       title: 'Sato $index',
//       image: 'assets/images/def_image.png',
//       desc:
//           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut et massa mi. Aliquam in hendrerit urna. Pellentesque sit amet sapien fringilla, mattis ligula consectetur, ultrices mauris. Maecenas vitae mattis tellus. Nullam quis imperdiet augue. Vestibulum auctor ornare leo, non suscipit magna interdum eu. Curabitur pellentesque nibh nibh, at maximus ante fermentum sit amet.',
//     ),
//   ),
//   ...List.generate(
//     10,
//     (index) => SubCategoryItem(
//       id: index,
//       subCategoryId: 3,
//       title: 'Tambur $index',
//       image: 'assets/images/def_image.png',
//       desc:
//           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut et massa mi. Aliquam in hendrerit urna. Pellentesque sit amet sapien fringilla, mattis ligula consectetur, ultrices mauris. Maecenas vitae mattis tellus. Nullam quis imperdiet augue. Vestibulum auctor ornare leo, non suscipit magna interdum eu. Curabitur pellentesque nibh nibh, at maximus ante fermentum sit amet.',
//     ),
//   ),
// ];
//
// final List<SubCategory> subCategoryList = [
//   ...List.generate(
//     6,
//     (index) => SubCategory(
//       id: index,
//       categoryId: 0,
//       title: 'O‘zbek cholg‘ulari tarixi',
//       image: 'assets/images/def_image.png',
//       items: subCategoryItemsList
//           .where((element) => element.subCategoryId == index)
//           .toList(),
//     ),
//   ),
//   ...List.generate(
//     9,
//     (index) => SubCategory(
//       id: index,
//       categoryId: 1,
//       title: 'O‘zbek $index',
//       image: 'assets/images/def_image.png',
//       items: subCategoryItemsList
//           .where((element) => element.subCategoryId == index)
//           .toList(),
//     ),
//   ),
//   ...List.generate(
//     10,
//     (index) => SubCategory(
//       id: index,
//       categoryId: 2,
//       title: 'O‘zbek tarixi $index',
//       image: 'assets/images/def_image.png',
//       items: subCategoryItemsList
//           .where((element) => element.subCategoryId == index)
//           .toList(),
//     ),
//   ),
// ];
//
// final List<CategoryModel> categoryList = [
//   ...List.generate(
//     3,
//     (index) => CategoryModel(
//       id: index,
//       image: 'assets/images/def_image.png',
//       items: subCategoryList
//           .where((element) => element.categoryId == index)
//           .toList(),
//     ),
//   ),
// ];
