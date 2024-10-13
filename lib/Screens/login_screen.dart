import 'package:aa_shopping_mart/Screens/account_type_screen.dart';
import 'package:blur/blur.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Authentication/firebase_auth.dart';
import '../ProvidersClass/login_provider.dart';
import 'home_page.dart';
import '../Utils/error_widgets.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginForm();
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final FocusNode emailFocusNode;
  late final FocusNode passFocusNode;
  late final FocusNode nameFocusNode;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final loginKey = GlobalKey<FormState>();
  final signupKey = GlobalKey<FormState>();

  String email = '';
  String pass = '';
  String name = '';
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    emailFocusNode = FocusNode();
    passFocusNode = FocusNode();
    nameFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passFocusNode.dispose();
    nameFocusNode.dispose();
    emailController.dispose();
    passController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          body: Stack(
        alignment: Alignment.center,
        children: [
          // Background blur and main card design
          Blur(
            blur: 10,
            colorOpacity: 0.5,
            child: Container(
              height: h,
              width: w,
              color: Colors.blue,
            ),
          ),
          (h < 600)
              ? SingleChildScrollView(
                  child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: h * 0.075, horizontal: w * 0.2),
                  child: content(h: h, w: w),
                ))
              : content(h: h, w: w)
        ],
      )),
    );
  }

  Widget content({required double h, required double w}) {
    return Center(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Consumer<LoginProvider>(
            builder: (BuildContext context, provider, Widget? child) {
          return AnimatedSwitcher(
            duration: const Duration(seconds: 3),
            reverseDuration: const Duration(seconds: 3),
            transitionBuilder: (Widget child, Animation<double> animation) =>
                ScaleTransition(scale: animation, child: child),
            child: SizedBox(
              key: ValueKey<bool>(provider.isLogin),
              width: (constraints.maxWidth < 520) ? w * 0.7 : w * 0.4,
              child: Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black54),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                shadowColor: Colors.grey,
                color: Colors.white,
                elevation: 21,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.025,
                      vertical: constraints.maxWidth * 0.015),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Toggle between Login/Signup views
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          provider.isLogin ? 'LogIn' : 'SignUp',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 28),
                        ),
                      ),
                      SizedBox(height: h * 0.025),
                      // Form fields with transition animation
                      Form(
                        key: (provider.isLogin) ? loginKey : signupKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Show Username Field in Signup Mode
                            if (!provider.isLogin)
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'Username',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: RichText(
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.end,
                                    softWrap: true,
                                    text: TextSpan(
                                      text: 'Already have an account? ',
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.black),
                                      children: [
                                        TextSpan(
                                            text: 'Login',
                                            style: const TextStyle(
                                                color: Colors.lightBlue),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                provider.toggleLogin();
                                                emailController.clear();
                                                passController.clear();
                                                nameController.clear();
                                              })
                                      ],
                                    ),
                                  )),
                                  const SizedBox(width: 16)
                                ],
                              ),

                            if (!provider.isLogin)
                              tff(nameController, false, nameFocusNode,
                                  "Username", "John Doe"),

                            (provider.isLogin)
                                ? Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          'Email',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: RichText(
                                        overflow: TextOverflow.visible,
                                        textAlign: TextAlign.end,
                                        softWrap: true,
                                        text: TextSpan(
                                          text: 'Need an account? ',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                          children: [
                                            TextSpan(
                                                text: 'Signup',
                                                style: const TextStyle(
                                                    color: Colors.lightBlue),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        provider.toggleLogin();
                                                        emailController.clear();
                                                        passController.clear();
                                                        nameController.clear();
                                                      })
                                          ],
                                        ),
                                      )),
                                      const SizedBox(width: 16)
                                    ],
                                  )
                                : const Text(
                                    'Email',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                            tff(emailController, false, emailFocusNode, "Email",
                                "JohnDoe@gmail.com"),

                            // Password Field
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'Password',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: InkWell(
                                        onTap: () {
                                          provider.togglePasswordVisibility();
                                        },
                                        child: Icon(
                                          (provider.isHidden)
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.lightBlue,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            tff(passController, provider.isHidden,
                                passFocusNode, "Password", "xxxxxxxx"),
                            const SizedBox(
                              height: 6.0,
                            )
                          ],
                        ),
                      ),

                      button(provider.isLogin ? 'Login' : 'Signup',
                          Colors.green[600]!, Colors.white, ''),
                      const SizedBox(height: 12),
                      const SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  child: Divider(
                                color: Colors.black,
                              )),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  'OR',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Expanded(
                                  child: Divider(
                                color: Colors.black,
                              )),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      button('Continue with Google', Colors.white, Colors.black,
                          'assets/google.png'),
                      const SizedBox(height: 12),
                      button('Continue with Facebook', Colors.blue[700]!,
                          Colors.white, 'assets/FacebookLogo.jpg'),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Center(
                          child: (provider.isLogin)
                              ? TextButton(
                                  onPressed: () {},
                                  child: const Text('Forgot Password?',
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                )
                              : const Text(
                                  'By clicking the "Sign up" button, you agree to the Terms of Service and Privacy Policy',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      }),
    );
  }

  Widget tff(TextEditingController controller, bool isHidden,
      FocusNode focusNode, String labelText, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0, bottom: 10.0),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: isHidden,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black87),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black87),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black87),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $labelText';
          }
          return null;
        },
      ),
    );
  }

  Widget button(String text, Color bgColor, Color textColor, String imgUrl) {
    return Consumer<LoginProvider>(
      builder: (context, provider, child) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity,
                  MediaQuery.of(context).size.height * 0.055 + 12),
              alignment: Alignment.center,
              padding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 8.0),
              elevation: 6,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  side: BorderSide(color: Colors.white, width: 1.5)),
              backgroundColor: bgColor),
          onPressed: () async {
            var key = (provider.isLogin) ? loginKey : signupKey;
            if (key.currentState!.validate()) {
              // Authentication logic
              if (provider.isLogin && imgUrl.isEmpty) {
                provider.setLoading(true);
                final status = await Authentication.signIn(
                    emailController.text, passController.text);
                if (status.isEmpty) {
                  // Move to HomeScreen
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                } else {
                  ErrorWidgets.toastMessage(str: status);
                }
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccountTypeScreen(
                            name: nameController.text,
                            email: emailController.text,
                            pass: passController.text)));
              }
              provider.setLoading(false);
            }
          },
          child: (provider.isLoading && imgUrl.isEmpty)
              ? const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (imgUrl.isNotEmpty) ...[
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage(imgUrl),
                      ),
                      const SizedBox(
                          width: 8), // Spacing between image and text
                    ],
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          text,
                          style: TextStyle(color: textColor),
                          maxLines: 1, // Prevents overflow
                          overflow:
                              TextOverflow.ellipsis, // Graceful text overflow
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
