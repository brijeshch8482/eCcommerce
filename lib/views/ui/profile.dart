
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:online_shop/views/shared/appstyle.dart';
import 'package:online_shop/views/shared/tiles_widget.dart';
import 'package:online_shop/views/ui/auth/login.dart';
import 'package:online_shop/views/ui/cartpage.dart';
import 'package:online_shop/views/ui/favorites.dart';
import 'package:online_shop/views/ui/nonuser.dart';
import 'package:provider/provider.dart';

import '../../controllers/login_provider.dart';
import '../shared/reusable_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

    var authNotifier = Provider.of<LoginNotifier>(context);

    return authNotifier.loggedIn == false ? const NonUser() : Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE2E2E2),
        elevation: 0,
        leading: const Icon(
          MaterialCommunityIcons.qrcode_scan,
          size: 18,
          color: Colors.black,
        ),
        actions: [
          GestureDetector(
            onTap: (){

            },
            child: Padding(padding: const EdgeInsets.only(right: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/usa.svg', width: 15.w, height: 25,),

                  SizedBox(
                    width: 5.w,
                  ),

                  Container(
                    height: 15.h,
                    width: 1.w,
                    color: Colors.grey,
                  ),

                  SizedBox(
                    width: 5.w,
                  ),

                  ReusableText(text: "USA", style: appstyle(16, Colors.black, FontWeight.normal)),

                  SizedBox(
                    width: 10.w,
                  ),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Icon(
                      SimpleLineIcons.settings,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 80.h,
              decoration: const BoxDecoration(
                color: Color(0xFFE2E2E2),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 10, 16, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 35.h,
                              width: 35.w,
                              child: const CircleAvatar(
                                backgroundImage: AssetImage('assets/images/user.jpeg'),
                              ),
                            ),

                            const SizedBox(
                              width: 8,
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                  text: "Username",
                                  style: appstyle(12, Colors.black, FontWeight.normal),
                                ),
                                ReusableText(
                                  text: "chaudharyji8482@gmail.com",
                                  style: appstyle(12, Colors.black, FontWeight.normal),
                                ),
                              ],
                            ),



                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){

                            },
                            child: const Icon(Feather.edit, size: 20,)
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),

                Container(
                  height: 170.h,
                  color: Colors.grey.shade200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TilesWidget(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
                        },
                        title: 'My Orders',
                        leading: MaterialCommunityIcons.truck_fast_outline,

                      ),

                      TilesWidget(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const Favorites()));
                        },
                        title: 'My Favorites',
                        leading: MaterialCommunityIcons.heart_outline,

                      ),

                      TilesWidget(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> CartPage()));
                        },
                        title: 'Cart',
                        leading: Fontisto.shopping_bag_1,

                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 10.h,
                ),

                Container(
                  height: 120.h,
                  color: Colors.grey.shade200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TilesWidget(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const Favorites()));
                        },
                        title: 'Coupons',
                        leading: MaterialCommunityIcons.tag_outline,

                      ),

                      TilesWidget(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const Favorites()));
                        },
                        title: 'My Store',
                        leading: MaterialCommunityIcons.shopping_outline,

                      ),

                    ],
                  ),
                ),

                SizedBox(
                  height: 10.h,
                ),

                Container(
                  height: 170.h,
                  color: Colors.grey.shade200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TilesWidget(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const Favorites()));
                        },
                        title: 'Shipping address',
                        leading: SimpleLineIcons.location_pin,

                      ),

                      TilesWidget(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const Favorites()));
                        },
                        title: 'Settings',
                        leading: AntDesign.setting,

                      ),

                      TilesWidget(
                        onTap: (){
                          authNotifier.logout();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
                        },
                        title: 'Logout',
                        leading: AntDesign.logout,

                      ),

                    ],
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}