import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/views/ui/auth/login.dart';
import 'package:provider/provider.dart';

import '../../../controllers/login_provider.dart';
import '../../shared/appstyle.dart';
import '../../shared/custom_textfield.dart';
import '../../shared/reusable_text.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginNotifier>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50.h,
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        decoration: const BoxDecoration(
          image: DecorationImage(
              opacity: 0.5,
              image: AssetImage('assets/images/bg.jpg')
          ),

        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ReusableText(text: "Hello!",
                style: appstyle(30, Colors.white, FontWeight.w600)),
            ReusableText(text: "Fill in your details to sign up into your account",
                style: appstyle(14, Colors.white, FontWeight.normal)),

            SizedBox(
              height: 50.h,
            ),

            CustomTextField(
              keyboard: TextInputType.emailAddress,
              hintText: "Username",
              controller: username,
              validator: (username) {
                if(username!.isEmpty){
                  return 'Please provide a valid username';
                }else{
                  return null;
                }
              },
            ),

            SizedBox(
              height: 15.h,
            ),

            CustomTextField(
              keyboard: TextInputType.emailAddress,
              hintText: "Email",
              controller: email,
              validator: (email) {
                if(email!.isEmpty && !email.contains("@")){
                  return 'Please provide a valid email address';
                }else{
                  return null;
                }
              },
            ),

            SizedBox(
              height: 15.h,
            ),

            CustomTextField(
              hintText: "Password",
              obscureText: authNotifier.isObsecure,
              controller: password,
              suffixIcon: GestureDetector(
                onTap: (){
                  authNotifier.isObsecure = !authNotifier.isObsecure;
                },
                child: authNotifier.isObsecure
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              ),
              validator: (password) {
                if(password!.isEmpty && password.length < 6){
                  return 'Password too weak';
                }else{
                  return null;
                }
              },
            ),

            SizedBox(
              height: 10.h,
            ),

            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
                },
                child: ReusableText(text: "Login",
                    style: appstyle(14, Colors.white, FontWeight.normal)),
              ),
            ),

            SizedBox(
              height: 40.h,
            ),

            GestureDetector(
              onTap: (){},
              child: Container(
                height: 55.h,
                width: 300.w,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: Center(
                  child: ReusableText(text: "S I G N U P",
                      style: appstyle(18, Colors.black, FontWeight.bold)),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
