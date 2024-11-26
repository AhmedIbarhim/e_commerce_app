import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/bloc/App_Cubit/app_cubit.dart';
import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/screens/product_details.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/widgets/text.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselSliderController carouselController = CarouselSliderController();

  bool allSales = false;

  bool allProducts = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
            body: cubit.homeModel == null
                ? buildLoadingWidget()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SizedBox(
                          width: width,
                          height: height * 0.2,
                          child: CarouselSlider.builder(
                            carouselController: carouselController,
                            itemCount: cubit.homeModel!.data!.banners!.length,
                            itemBuilder: (context, index, realIndex) {
                              return Container(
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: buildCashedImage(
                                  image: cubit
                                      .homeModel!.data!.banners![index].image,
                                  radius: 10,
                                  fit: 'fill',
                                ),
                              );
                            },
                            options: CarouselOptions(
                              onPageChanged: (index, reason) {
                                // if(items != null){
                                //   cubit.changeCurrentIndexSlider(index);
                                // }
                              },
                              aspectRatio: 16 / 10,
                              viewportFraction: 0.90,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              //reverse: true,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.2,
                              scrollDirection: Axis.horizontal,
                              enlargeStrategy: CenterPageEnlargeStrategy.scale,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.03),
                          child: Row(
                            children: [
                              BuildText(
                                text: 'Hot Sales',
                                color: AppColor.primaryColor,
                                size: 25,
                                bold: true,
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    allSales = !allSales;
                                  });
                                },
                                child: BuildText(
                                  text: !allSales ? 'see all' : 'show less',
                                  bold: true,
                                  color: AppColor.secondColor,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.37,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: allSales
                                ? cubit.homeModel!.data!.sales.length
                                : 3,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  navigateTo(
                                      context,
                                      ProductDetailsScreen(
                                        product:
                                            cubit.homeModel!.data!.sales[index],
                                      ));
                                },
                                child: SizedBox(
                                  height: height * 0.4,
                                  width: width * 0.5,
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 0.5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: height * 0.2,
                                            width: width * 0.5,
                                            child: Stack(
                                              children: [
                                                SizedBox(
                                                  height: height * 0.2,
                                                  child: buildCashedImage(
                                                      image: cubit
                                                          .homeModel!
                                                          .data!
                                                          .sales[index]
                                                          .image,
                                                      fit: 'contain'),
                                                ),
                                                Positioned(
                                                  right: 0,
                                                  top: 5,
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20,
                                                        vertical: 2),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColor.myRedColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    child: BuildText(
                                                      text:
                                                          '${cubit.homeModel!.data!.sales[index].discount} %',
                                                      color: Colors.white,
                                                      bold: true,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          BuildText(
                                            text: cubit.homeModel!.data!
                                                .sales[index].name!,
                                            maxLines: 2,
                                            overFlow: true,
                                            bold: true,
                                            color: AppColor.primaryColor,
                                            size: 14,
                                          ),
                                          SizedBox(
                                            height: height * 0.01,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              BuildText(
                                                text: cubit.homeModel!.data!
                                                    .sales[index].price
                                                    .toString(),
                                                size: 17,
                                                bold: true,
                                              ),
                                              BuildText(
                                                text: cubit.homeModel!.data!
                                                    .sales[index].oldPrice
                                                    .toString(),
                                                color: Colors.grey,
                                                size: 7,
                                                bold: true,
                                                lineThrow: true,
                                              ),
                                              const Spacer(),
                                              InkWell(
                                                  onTap: () {
                                                    cubit
                                                        .changeFavouriteInSales(
                                                            index: index);
                                                    cubit.postChangeFavourite(
                                                        id: cubit
                                                            .homeModel!
                                                            .data!
                                                            .sales[index]
                                                            .id!);
                                                  },
                                                  child: Icon(
                                                      cubit
                                                              .homeModel!
                                                              .data!
                                                              .sales[index]
                                                              .inFavourites!
                                                          ? Icons.favorite
                                                          : Icons
                                                              .favorite_outline,
                                                      color: cubit
                                                              .homeModel!
                                                              .data!
                                                              .sales[index]
                                                              .inFavourites!
                                                          ? AppColor.myRedColor
                                                          : AppColor
                                                              .myBlueColor))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Divider(
                          color: AppColor.secondColor.withOpacity(0.1),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.03),
                          child: Row(
                            children: [
                              BuildText(
                                text: 'All Products',
                                color: AppColor.primaryColor,
                                size: 25,
                                bold: true,
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    allProducts = !allProducts;
                                  });
                                },
                                child: BuildText(
                                  text: !allProducts ? 'see all' : 'show less',
                                  bold: true,
                                  color: AppColor.secondColor,
                                ),
                              )
                            ],
                          ),
                        ),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: height * 0.37,
                            crossAxisCount: 2,
                            mainAxisSpacing: 1,
                            crossAxisSpacing: 1,
                          ),
                          itemCount: allProducts
                              ? cubit.homeModel!.data!.products!.length
                              : 7,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                navigateTo(
                                    context,
                                    ProductDetailsScreen(
                                      product: cubit
                                          .homeModel!.data!.products![index],
                                    ));
                              },
                              child: SizedBox(
                                height: height * 0.4,
                                width: width * 0.5,
                                child: Card(
                                  color: Colors.white,
                                  elevation: 0.5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: height * 0.2,
                                          width: width * 0.5,
                                          child: Stack(
                                            children: [
                                              SizedBox(
                                                height: height * 0.2,
                                                child: buildCashedImage(
                                                    image: cubit
                                                        .homeModel!
                                                        .data!
                                                        .products![index]
                                                        .image,
                                                    fit: 'contain'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        BuildText(
                                          text: cubit.homeModel!.data!
                                              .products![index].name!,
                                          maxLines: 2,
                                          overFlow: true,
                                          bold: true,
                                          color: AppColor.primaryColor,
                                          size: 14,
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            BuildText(
                                              text:
                                                  '${cubit.homeModel!.data!.products![index].price.toString()} EGP',
                                              size: 16,
                                              bold: true,
                                            ),
                                            const Spacer(),
                                            InkWell(
                                              onTap: () {
                                                cubit.changeFavouriteInProducts(
                                                    index: index);
                                                cubit.postChangeFavourite(
                                                    id: cubit.homeModel!.data!
                                                        .products![index].id!);
                                              },
                                              child: Icon(
                                                  cubit
                                                          .homeModel!
                                                          .data!
                                                          .products![index]
                                                          .inFavourites!
                                                      ? Icons.favorite
                                                      : Icons.favorite_outline,
                                                  color: cubit
                                                          .homeModel!
                                                          .data!
                                                          .products![index]
                                                          .inFavourites!
                                                      ? AppColor.myRedColor
                                                      : AppColor.myBlueColor),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ));
      },
    );
  }
}
