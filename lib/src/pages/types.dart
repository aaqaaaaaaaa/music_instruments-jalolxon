import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_instruments/src/helpers/apptheme.dart';
import 'package:music_instruments/src/helpers/data/models.dart';
import 'package:music_instruments/src/helpers/utils.dart';
import 'package:music_instruments/src/pages/detail.dart';
import 'package:music_instruments/src/widgets/custom_cached_image.dart';
import 'package:screensize_utils/screensize_util.dart';

import '../widgets/background.dart';

class TypesScreen extends StatefulWidget {
  const TypesScreen(
      {super.key,
      required this.subCategoryId,
      required this.data,
      required this.categoryId,
      required this.subCategoryList,
      required this.categoryImageUrl});

  final int subCategoryId, categoryId;
  final List data, subCategoryList;
  final String categoryImageUrl;

  @override
  State<TypesScreen> createState() => _TypesScreenState();
}

class _TypesScreenState extends State<TypesScreen> {
  bool isMusic = false;
  int selectedId = 0;
  List itemList = [];
  XFile? xfile;
  String imageUrl = '';
  String fileUrl = '';
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    itemList = widget.subCategoryList[widget.subCategoryId]['items'];
    print(itemList);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.subCategoryList);
    Locale myLocale = Localizations.localeOf(context);
    return BackgroundApp(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AnimationLimiter(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('category_model')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return Container();
                var snapshotData = snapshot.data?.docs[widget.categoryId];
                return GridView.builder(
                  itemCount: ((snapshotData?.get('items')[widget.subCategoryId]
                          ['items'] as List)
                      .length),
                  padding:
                      EdgeInsets.symmetric(vertical: 50.h, horizontal: 63.w),
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 600),
                      columnCount: 3,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: InkWell(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      data: SubCategoryItem(
                                        desc: itemList[index][
                                            myLocale.languageCode == 'ru'
                                                ? 'desc_ru'
                                                : 'desc'],
                                        title: itemList[index][
                                            myLocale.languageCode == 'ru'
                                                ? 'title_ru'
                                                : 'title'],
                                        image: itemList[index]['image'],
                                        filePath: itemList[index]['filePath'],
                                      ),
                                    ),
                                  ));
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: 215.w,
                                  height: 146.h,
                                  decoration: BoxDecoration(
                                      gradient: AppTheme.linearGradient,
                                      borderRadius: BorderRadius.circular(12.r),
                                      color: AppTheme.border),
                                  child: CustomCachedImage(
                                      imageUrl: (snapshotData?.get(
                                              'items')[widget.subCategoryId]
                                          ['items'] as List)[index]['image']),
                                ),
                                SizedBox(height: 24.h),
                                SizedBox(
                                  width: 215.h,
                                  child: Text(
                                    (snapshotData?.get(
                                                'items')[widget.subCategoryId]
                                            ['items'] as List)[index][
                                        myLocale.languageCode == 'ru'
                                            ? 'title_ru'
                                            : 'title'],
                                    style: TextStyle(
                                        fontSize: 24.sp, fontFamily: 'Inter'),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 30.w,
                    childAspectRatio: 0.97,
                  ),
                  physics: const BouncingScrollPhysics(),
                );
              }),
        ),
      ),
    );
  }

  showAddItemDialog(String id, int subId, BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              backgroundColor: AppTheme.dialog,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              content: SizedBox(
                height: 250.h,
                width: 1.w,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            onTap: () async {
                              ImagePicker imagePicker = ImagePicker();
                              xfile = await imagePicker.pickImage(
                                  source: ImageSource.gallery);
                              if (xfile == null) return;
                              String uniqueName = DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString();
                              Reference refRoot =
                                  FirebaseStorage.instance.ref();
                              Reference refDirImage =
                                  refRoot.child('subcategory_item_image');
                              Reference refImageUpload =
                                  refDirImage.child(uniqueName);
                              try {
                                await refImageUpload.putFile(File(xfile!.path));
                                imageUrl =
                                    await refImageUpload.getDownloadURL();
                              } catch (error) {
                                // Fluttertoast.showToast(msg: '$error');
                              }
                            },
                            child: Container(
                              width: 100.h,
                              height: 100.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  gradient: AppTheme.linearGradient),
                              child: xfile != null
                                  ? Image.file(File(xfile!.path))
                                  : SvgPicture.asset('assets/icons/add.svg'),
                            ),
                          ),

                          /// for select file
                          InkWell(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            onTap: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles();

                              if (result != null) {
                                File file =
                                    File(result.files.single.path ?? '');
                                String uniqueName = DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString();
                                Reference refRoot =
                                    FirebaseStorage.instance.ref();
                                Reference refDirImage =
                                    refRoot.child('subcategory_item_file');
                                Reference refImageUpload =
                                    refDirImage.child(uniqueName);
                                try {
                                  await refImageUpload.putFile(File(file.path));
                                  fileUrl =
                                      await refImageUpload.getDownloadURL();
                                } catch (error) {
                                  // Fluttertoast.showToast(msg: '$error');
                                }
                              } else {
                                // User canceled the picker
                              }
                            },
                            child: Container(
                              width: 100.h,
                              height: 100.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  gradient: AppTheme.linearGradient),
                              child: SvgPicture.asset(
                                  'assets/icons/music_note.svg'),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.h),
                        child: TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2.w, color: AppTheme.border),
                                  borderRadius: BorderRadius.circular(8.r)),
                              hintText: 'Nomi',
                              hintStyle: TextStyle(
                                  fontSize: 18.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.border),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2.w, color: AppTheme.border),
                                  borderRadius: BorderRadius.circular(8.r)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2.w, color: AppTheme.border),
                                  borderRadius: BorderRadius.circular(8.r))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: TextField(
                          controller: descController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2.w, color: AppTheme.border),
                                  borderRadius: BorderRadius.circular(8.r)),
                              hintText: 'Desc',
                              hintStyle: TextStyle(
                                  fontSize: 18.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.border),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2.w, color: AppTheme.border),
                                  borderRadius: BorderRadius.circular(8.r)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2.w, color: AppTheme.border),
                                  borderRadius: BorderRadius.circular(8.r))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                itemList.add(SubCategoryItem(
                                  id: subId,
                                  image: imageUrl,
                                  desc: descController.text,
                                  filePath: fileUrl,
                                  subCategoryId: widget.subCategoryId,
                                  title: titleController.text,
                                ).toJson());
                                widget.subCategoryList[widget.subCategoryId] = {
                                  'id': widget.subCategoryId,
                                  'categoryId': widget.categoryId,
                                  'title': widget
                                          .subCategoryList[widget.subCategoryId]
                                      ['title'],
                                  'image': widget
                                          .subCategoryList[widget.subCategoryId]
                                      ['image'],
                                  'items': itemList,
                                };
                                FirebaseFirestore.instance
                                    .collection('category_model')
                                    .doc(id)
                                    .set(
                                  {
                                    'id': widget.categoryId,
                                    'image': widget.categoryImageUrl,
                                    'items': widget.subCategoryList
                                  },
                                );
                                descController.clear();
                                imageUrl = '';
                                fileUrl = '';
                                titleController.clear();
                                pop(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: AppTheme.linearGradient,
                                    borderRadius: BorderRadius.circular(12.r)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 7.h, horizontal: 21.w),
                                child: Text(
                                  'Saqlash',
                                  style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontFamily: AppTheme.fontFamily),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
