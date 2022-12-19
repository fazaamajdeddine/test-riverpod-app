import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutoriverpod/models/product_model.dart';
import '../dataProvider/data_provider.dart';
import '../helper/constant.dart';
import 'common_widget/bottom_nav_bar.dart';
import 'common_widget/primary_button.dart';
import 'common_widget/secondary_button.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'detail.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool men = true;
  bool women = false;

  @override
  Widget build(BuildContext context) {
    final _mensProduct = ref.watch(menProductDataProvider);
    final _womenProduct = ref.watch(womenProductDataProvider);

    return Scaffold(
      bottomNavigationBar: const BottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SecondaryButton(
                      press: () {},
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.height * 0.08,
                      color: Colors.white,
                      icon: const Icon(Icons.menu)),
                  PrimaryButton(
                    text: 'Men',
                    press: () {
                      setState(() {
                        men = !men;
                        women = !women;
                      });
                    },
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.height * 0.15,
                    color: men == true ? Colors.black : Colors.white,
                    textColor: men == true ? Colors.white : Colors.black,
                    fontSize: 15,
                  ),
                  PrimaryButton(
                      text: 'Women',
                      press: () {
                        setState(() {
                          men = !men;
                          women = !women;
                        });
                      },
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.height * 0.15,
                      color: women == false ? Colors.white : Colors.black,
                      textColor: women == false ? Colors.black : Colors.white,
                      fontSize: 15),
                  SecondaryButton(
                      press: () {},
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.height * 0.08,
                      color: Colors.white,
                      icon: const Icon(Icons.search))
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.height * 0.53,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                    image: AssetImage("images/banner.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: const [
                          Text(
                            'Brace YourSelf!\nGet Yours!',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          PrimaryButton(
                              text: 'Shop Now',
                              press: () {},
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.height * 0.19,
                              color: Colors.orange[700],
                              textColor: Colors.white,
                              fontSize: 15),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              men
                  ? _mensProduct.when(
                      data: (_mensProduct) {
                        List<Product> productList =
                            _mensProduct.map((e) => e).toList();
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 15),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: productList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                            e: productList[index],
                                          )));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          productList[index].image!),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[300],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Column(
                                                children: [
                                                  RatingBar.builder(
                                                    initialRating:
                                                        productList[index]
                                                            .rating!
                                                            .rate!,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 15,
                                                    ignoreGestures: true,
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate: (rating) {},
                                                  ),
                                                  Text(
                                                    '(${productList[index].rating!.count})',
                                                    style: const TextStyle(
                                                        color: Colors.amber),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: PriceColor,
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "New",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "\$${productList[index].price}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        AutoSizeText(
                                          productList[index]
                                              .description
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      error: (err, s) => Text(err.toString()),
                      loading: () => const CircularProgressIndicator(
                        color: Colors.orange,
                      ),
                    )
                  : _womenProduct.when(
                      data: (_womenProduct) {
                        List<Product> productList =
                            _womenProduct.map((e) => e).toList();
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 15),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: productList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                            e: productList[index],
                                          )));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          productList[index].image!),
                                      fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[300],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Column(
                                                children: [
                                                  RatingBar.builder(
                                                    initialRating:
                                                        productList[index]
                                                            .rating!
                                                            .rate!,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 15,
                                                    ignoreGestures: true,
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate: (rating) {},
                                                  ),
                                                  Text(
                                                    '(${productList[index].rating!.count})',
                                                    style: const TextStyle(
                                                        color: Colors.amber),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: PriceColor,
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "New",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "\$${productList[index].price}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        AutoSizeText(
                                          productList[index]
                                              .description
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      error: (err, s) => Text(err.toString()),
                      loading: () => const CircularProgressIndicator(
                        color: Colors.orange,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
