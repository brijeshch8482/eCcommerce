import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:online_shop/controllers/login_provider.dart';
import 'package:online_shop/controllers/product_provider.dart';
import 'package:online_shop/models/sneaker_model.dart';
import 'package:online_shop/services/helper.dart';
import 'package:online_shop/views/shared/appstyle.dart';
import 'package:online_shop/views/shared/checkout_btn.dart';
import 'package:online_shop/views/ui/auth/login.dart';
import 'package:online_shop/views/ui/favorites.dart';
import 'package:provider/provider.dart';

import '../../controllers/favorites_provider.dart';
import '../../models/constants.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.sneakers});

  final Sneakers sneakers;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();
  final _cartBox = Hive.box('cart_box');
  final _favBox = Hive.box('fav_box');

  Future<void> _createCart(Map<dynamic, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }



  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginNotifier>(context);
    var favoritesNotifier = Provider.of<FavoritesNotifier>(context, listen: true);
    favoritesNotifier.getFavorites();


    return Scaffold(
        body: Consumer<ProductNotifier>(
          builder: (context, productNotifier, child) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  leadingWidth: 0,
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            productNotifier.shoeSizes.clear();
                          },
                          child: const Icon(
                            AntDesign.close,
                            color: Colors.black,
                          ),
                        ),

                        Consumer<FavoritesNotifier>(
                          builder: (BuildContext context,
                              favoritesNotifier, Widget? child) {

                            return GestureDetector(
                              onTap: () {
                                if(authNotifier.loggedIn == true){
                                  if(favoritesNotifier.ids.contains(widget.sneakers.id)){
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => const Favorites()));
                                  }else{
                                    favoritesNotifier.createFav({
                                      "id": widget.sneakers.id,
                                      "name": widget.sneakers.name,
                                      "category": widget.sneakers.category,
                                      "price": '\$${widget.sneakers.price}',
                                      "imageUrl": widget.sneakers.imageUrl[0],
                                    });
                                  }
                                }else{
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                                }
                                setState(() {

                                });
                              },
                              child: favoritesNotifier.ids.contains(widget.sneakers.id)
                                  ? const Icon(
                                AntDesign.heart,
                                color: Colors.black,
                              )
                                  : const Icon(
                                AntDesign.hearto,
                                color: Colors.black,
                              ),
                            );
                          },

                        )

                      ],
                    ),
                  ),
                  pinned: true,
                  snap: false,
                  floating: true,
                  backgroundColor: Colors.transparent,
                  expandedHeight: MediaQuery.of(context).size.height,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        SizedBox(
                          height:
                          MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width,
                          child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.sneakers.imageUrl.length,
                              controller: pageController,
                              onPageChanged: (page) {
                                productNotifier.activePage = page;
                              },
                              itemBuilder: (context, int index) {
                                return Stack(
                                  children: [
                                    Container(
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.39,
                                      width: MediaQuery.of(context)
                                          .size
                                          .width,
                                      color: Colors.grey.shade300,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        widget.sneakers.imageUrl[index],
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        height: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.3,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children:
                                          List<Widget>.generate(
                                              widget.sneakers
                                                  .imageUrl.length,
                                                  (index) => Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal:
                                                    4),
                                                child:
                                                CircleAvatar(
                                                  radius: 5,
                                                  backgroundColor: productNotifier
                                                      .activepage !=
                                                      index
                                                      ? Colors
                                                      .grey
                                                      : Colors
                                                      .black,
                                                ),
                                              )),
                                        )),
                                  ],
                                );
                              }),
                        ),
                        Positioned(
                            bottom: 30,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                              child: Container(
                                height:
                                MediaQuery.of(context).size.height *
                                    0.645,
                                width:
                                MediaQuery.of(context).size.width,
                                color: Colors.white,
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.sneakers.name,
                                          style: appstyle(
                                              40,
                                              Colors.black,
                                              FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              widget.sneakers.category,
                                              style: appstyle(
                                                  20,
                                                  Colors.grey,
                                                  FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            RatingBar.builder(
                                              initialRating: 4,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 22,
                                              itemPadding:
                                              const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 1),
                                              itemBuilder: (context, _) =>
                                              const Icon(
                                                Icons.star,
                                                size: 18,
                                                color: Colors.black,
                                              ),
                                              onRatingUpdate: (rating) {},
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text(
                                              "\$${widget.sneakers.price}",
                                              style: appstyle(
                                                  26,
                                                  Colors.black,
                                                  FontWeight.w600),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Colors",
                                                  style: appstyle(
                                                      18,
                                                      Colors.black,
                                                      FontWeight.w500),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                const CircleAvatar(
                                                  radius: 7,
                                                  backgroundColor:
                                                  Colors.black,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                const CircleAvatar(
                                                  radius: 7,
                                                  backgroundColor:
                                                  Colors.red,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Select sizes",
                                                  style: appstyle(
                                                      20,
                                                      Colors.black,
                                                      FontWeight.w600),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "View size guide",
                                                  style: appstyle(
                                                      20,
                                                      Colors.grey,
                                                      FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              height: 40,
                                              child: ListView.builder(
                                                  itemCount:
                                                  productNotifier
                                                      .shoeSizes
                                                      .length,
                                                  scrollDirection:
                                                  Axis.horizontal,
                                                  padding:
                                                  EdgeInsets.zero,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final sizes =
                                                    productNotifier
                                                        .shoeSizes[
                                                    index];

                                                    return Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 8.0,
                                                      ),
                                                      child: ChoiceChip(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                60),
                                                            side: const BorderSide(
                                                                color: Colors
                                                                    .black,
                                                                width: 1,
                                                                style: BorderStyle
                                                                    .solid)),
                                                        disabledColor:
                                                        Colors.white,
                                                        label: Text(
                                                          sizes['size'],
                                                          style: appstyle(
                                                              16,
                                                              sizes['isSelected']
                                                                  ? Colors
                                                                  .white
                                                                  : Colors
                                                                  .black,
                                                              FontWeight
                                                                  .w500),
                                                        ),
                                                        selectedColor:
                                                        Colors.black,
                                                        padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            vertical:
                                                            8),
                                                        selected: sizes[
                                                        'isSelected'],
                                                        onSelected:
                                                            (newState) {
                                                          if (productNotifier
                                                              .sizes
                                                              .contains(sizes[
                                                          'size'])) {
                                                            productNotifier
                                                                .sizes
                                                                .remove(sizes[
                                                            'size']);
                                                          } else {
                                                            productNotifier
                                                                .sizes
                                                                .add(sizes[
                                                            'size']);
                                                          }
                                                          print(
                                                              productNotifier
                                                                  .sizes);
                                                          productNotifier
                                                              .toggleCheck(
                                                              index);
                                                        },
                                                      ),
                                                    );
                                                  }),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Divider(
                                          indent: 10,
                                          endIndent: 10,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.8,
                                          child: Text(
                                            widget.sneakers.title,
                                            maxLines: 2,
                                            style: appstyle(
                                                26,
                                                Colors.black,
                                                FontWeight.w700),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          widget.sneakers.description,
                                          textAlign: TextAlign.justify,
                                          maxLines: 4,
                                          style: appstyle(
                                              14,
                                              Colors.black,
                                              FontWeight.normal),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Align(
                                          alignment:
                                          Alignment.bottomCenter,
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                top: 12),
                                            child: CheckoutButton(
                                              onTap: () async {
                                                if(authNotifier.loggedIn == true) {
                                                  _createCart({
                                                    "id": widget.sneakers.id,
                                                    "name": widget.sneakers.name,
                                                    "category":
                                                    widget.sneakers.category,
                                                    "sizes": productNotifier
                                                        .sizes[0],
                                                    "imageUrl":
                                                    widget.sneakers.imageUrl[0],
                                                    "price": widget.sneakers.price,
                                                    "qty": 1
                                                  });
                                                  print(widget.sneakers.name);
                                                  productNotifier.sizes
                                                      .clear();
                                                  Navigator.pop(context);
                                                }else{
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                                                }
                                              },
                                              label: "Add to Cart",
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ));
  }

}
