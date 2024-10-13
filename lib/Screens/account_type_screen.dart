import 'package:aa_shopping_mart/Authentication/firebase_auth.dart';
import 'package:aa_shopping_mart/ProvidersClass/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Utils/error_widgets.dart';
import 'home_page.dart';

class AccountTypeScreen extends StatefulWidget {
  const AccountTypeScreen(
      {super.key, required this.name, required this.email, required this.pass});
  final String name;
  final String email;
  final String pass;

  @override
  State<AccountTypeScreen> createState() => _AccountTypeScreenState();
}

class _AccountTypeScreenState extends State<AccountTypeScreen> {
  late FocusNode keyNode;
  late TextEditingController keyController;
  final keyState = GlobalKey<FormState>();

  @override
  void initState() {
    keyController = TextEditingController();
    keyNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    keyNode.dispose();
    keyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width,
          child: Consumer<LoginProvider>(builder:
              (BuildContext context, LoginProvider value, Widget? child) {
            return Stack(alignment: Alignment.center, children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    flex: 3,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                            child: InkWell(
                                onTap: () {
                                  value.setInfoSaved(true);
                                  if (value.adminKeyField) {
                                    value.showAdminKeyField();
                                  }
                                  doSignUp("Customer Account", provider: value);
                                },
                                child:
                                    accountType(size: size, type: "customer"))),
                        Flexible(
                            child: InkWell(
                                onTap: () {
                                  value.showAdminKeyField();
                                },
                                child: accountType(size: size, type: "admin")))
                      ],
                    ),
                  ),
                  (value.adminKeyField)
                      ? Container(
                          width: size.width * 0.5,
                          margin: EdgeInsets.symmetric(
                              vertical: 32.0, horizontal: 18.0),
                          child: Form(
                            key: keyState,
                            autovalidateMode: AutovalidateMode.onUnfocus,
                            child: TextFormField(
                              controller: keyController,
                              focusNode: keyNode,
                              autofocus: true,
                              obscureText: value.adminKeyToggle,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Colors.black87, width: 1.5)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Colors.deepPurpleAccent,
                                        width: 1.5)),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Colors.black87, width: 1.5)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Colors.redAccent, width: 1.5)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Colors.redAccent, width: 1.5)),
                                suffix: InkWell(
                                  onTap: () => value.toggleAdminKey(),
                                  child: Icon(
                                    value.adminKeyToggle
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                ),
                              ),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Enter the Admin Key';
                                } else if (!value.matchAdminKey(val)) {
                                  return "Incorrect Admin Key";
                                }
                                return null;
                              },
                              onFieldSubmitted: (String val) {
                                if (keyState.currentState!.validate() &&
                                    value.matchAdminKey(val)) {
                                  value.setInfoSaved(true);
                                  doSignUp("Admin Account", provider: value);
                                }
                              },
                            ),
                          ),
                        )
                      : SizedBox()
                ],
              ),
              (value.infoSaved) ? CircularProgressIndicator() : SizedBox()
            ]);
          }),
        ),
      ),
    ));
  }

  Widget accountType({required Size size, required String type}) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black54),
        borderRadius: BorderRadius.circular(18.0),
      ),
      shadowColor: Colors.deepPurpleAccent,
      color: Colors.grey.shade300,
      elevation: 21,
      margin: EdgeInsets.symmetric(vertical: 18, horizontal: 26),
      child: Container(
        height: size.height * 0.25,
        width: size.width * 0.23,
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                (type.contains("admin")) ? "Admin Account" : "Customer Account",
                softWrap: true,
                textAlign: TextAlign.center,
                style: GoogleFonts.aladin(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 32),
              ),
            ),
            (size.height < 500 || size.width < 800)
                ? FittedBox(
                    child: Text(
                      (type.contains("admin"))
                          ? "To SignUp as the Admin member, verify the Admin Key that you had "
                          : "500Rs discount free for the first time SignUp",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.alice(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 26),
                    ),
                  )
                : Text(
                    (type.contains("admin"))
                        ? "Verify the AdminKey to SignUp as an Admin member"
                        : "500Rs discount free for the first time SignUp",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.alice(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
          ],
        ),
      ),
    );
  }

  void doSignUp(String type, {required LoginProvider provider}) async {
    final status = await Authentication.signUp(
        widget.name, widget.email, widget.pass,
        accountType: type);
    if (status.isEmpty) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (Route<dynamic> route) => false);
    } else {
      ErrorWidgets.toastMessage(str: status);
    }
    provider.setInfoSaved(false);
  }
}
