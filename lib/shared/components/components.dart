import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/constants/colors.dart';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../bloc/App_Cubit/app_cubit.dart';
import '../widgets/text.dart';

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateToFinish(context, widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

SnackBar buildAwesomeSnackBar(
    {required int typeCode,
    required String title,
    required String message,
    milSecond = 3000}) {
  return SnackBar(
    duration: Duration(milliseconds: milSecond),
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: typeCode == 0
          ? ContentType.failure
          : typeCode == 1
              ? ContentType.success
              : ContentType.warning,
    ),
  );
}

Center buildLoadingWidget({double size = 50}) {
  return Center(
    child: LoadingAnimationWidget.staggeredDotsWave(
      color: AppColor.primaryColor,
      size: size,
    ),
  );
}

ClipRRect buildCashedImage(
    {required image, double radius = 0, required String fit}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: CachedNetworkImage(
      fit: fit == 'fill'
          ? BoxFit.fill
          : fit == 'cover'
              ? BoxFit.cover
              : BoxFit.contain,
      imageUrl: image,
      placeholder: (context, url) => buildLoadingWidget(),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        color: Colors.red,
      ),
    ),
  );
}

Container BuildCarouselSlider({
  required double width,
  required double height,
  required CarouselSliderController carouselController,
  required AppCubit cubit,
  required int length,
  List<String>? items,
}) {
  return Container(
    width: width,
    height: height,
    child: CarouselSlider.builder(
      carouselController: carouselController,
      itemCount: length,
      itemBuilder: (context, index, realIndex) {
        return Container(
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: buildCashedImage(
            image: items != null
                ? items[index]
                : cubit.homeModel!.data!.banners![index].image,
            radius: 10,
            fit: 'fill',
          ),
        );
      },
      options: CarouselOptions(
        onPageChanged: (index, reason) {
          if (items != null) {
            cubit.changeSliderIndex(index);
          }
        },
        aspectRatio: 16 / 10,
        viewportFraction: 0.90,
        initialPage: 0,
        enableInfiniteScroll: true,
        //reverse: true,
        // autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.2,
        scrollDirection: Axis.horizontal,
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
      ),
    ),
  );
}

Container buildProductItem(
  double height,
  double width, {
  required String image,
  required String name,
  required String price,
  required int index,
  required String from,
  required bool isFavourite,
  required int id,
}) {
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        SizedBox(
          height: height * 0.02,
        ),
        SizedBox(
          child: buildCashedImage(image: image, fit: 'contain'),
          height: height * 0.2,
          width: width,
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Container(
          height: height * 0.07,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BuildText(text: name, maxLines: 2, bold: true),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              BuildText(
                text: '$price EGP',
                bold: true,
                color: AppColor.primaryColor,
                size: 20,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  if (from == 'home') {
                  } else {}
                },
                child: Icon(
                  isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: isFavourite ? Colors.red : Colors.grey,
                  size: 25,
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
