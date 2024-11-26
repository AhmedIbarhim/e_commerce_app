import 'package:ecommerce_app/bloc/App_Cubit/app_cubit.dart';
import 'package:ecommerce_app/screens/category_products_screen.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:ecommerce_app/shared/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

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
            body: ListView.builder(
                itemCount: cubit.categoryModel!.data!.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () {
                        cubit.getCategoryProducts(
                            id: cubit.categoryModel!.data!.data![index].id!);
                        navigateTo(
                            context,
                            CategoryProductsScreen(
                              title:
                                  cubit.categoryModel!.data!.data![index].name!,
                            ));
                      },
                      child: SizedBox(
                        height: height * 0.2,
                        child: Stack(
                          children: [
                            SizedBox(
                              height: height * 0.2,
                              width: width,
                              child: buildCashedImage(
                                  image: cubit
                                      .categoryModel!.data!.data![index].image,
                                  fit: 'cover'),
                            ),
                            Container(
                              height: height * 0.2,
                              color: Colors.black54,
                            ),
                            Container(
                              height: height * 0.2,
                              color: Colors.black54,
                            ),
                            Center(
                              child: BuildText(
                                text: cubit
                                    .categoryModel!.data!.data![index].name!,
                                color: Colors.white,
                                bold: true,
                                size: 25,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }));
      },
    );
  }
}
