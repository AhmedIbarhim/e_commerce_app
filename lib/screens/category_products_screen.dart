import 'package:ecommerce_app/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/App_Cubit/app_cubit.dart';
import '../shared/components/components.dart';

class CategoryProductsScreen extends StatelessWidget {
  late String title;
  CategoryProductsScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          body: cubit.categoryProductsModel == null
              ? buildLoadingWidget()
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2,
                    mainAxisExtent: height * 0.3,
                    crossAxisCount: 2, // number of items in each row
                    mainAxisSpacing: 1, // spacing between rows
                    crossAxisSpacing: 1, // spacing between column
                  ),
                  itemCount:
                      cubit.categoryProductsModel!.data!.products!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        navigateTo(
                            context,
                            ProductDetailsScreen(
                                product: cubit.categoryProductsModel!.data!
                                    .products![index]));
                      },
                      child: Container(
                        width: width,
                        child: Stack(
                          children: [
                            buildCashedImage(
                              image: cubit.categoryProductsModel!.data!
                                  .products![index].image,
                              fit: 'cover',
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                    Colors.black,
                                    Colors.transparent
                                  ])),
                            ),
                            Positioned(
                              right: 3,
                              bottom: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    cubit.changeFavouriteInCategories(
                                        index: index);
                                    cubit
                                        .postChangeFavourite(
                                            id: cubit.categoryProductsModel!
                                                .data!.products![index].id!)
                                        .then((value) {
                                      cubit.getHomeData();
                                    });
                                  },
                                  child: Icon(
                                    cubit.categoryProductsModel!.data!
                                            .products![index].inFavourites!
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: cubit.categoryProductsModel!.data!
                                            .products![index].inFavourites!
                                        ? Colors.red
                                        : Colors.grey,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
        );
      },
    );
  }
}
