import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../SingletonClasses/firebase_firestore_database.dart';
import '../Utils/error_widgets.dart';

class Authentication {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<String> signIn(String email, String pass) async {
    String errorMsg = '';
    try {
      await auth.signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          errorMsg = 'There is no more user exist by given E-mailID';
          break;
        case 'The password is invalid or the user does not have a password.':
          errorMsg = 'Password is incorrect or invalid';
          break;
        case 'The email address is badly formatted.':
          errorMsg =
          'Entered email format is incorrect. Correct Format: xxx...@gmail.com';
          break;
        case 'Password should be at least 6 characters':
          errorMsg =
              'Password is too short. It should be at least minimum of 6 characters';
          break;
        default:
          errorMsg = 'Case ${e.message} is not yet implemented';
      }
    }
    return errorMsg;
  }

  static Future<String> signUp(String name, String email, String pass, {required String accountType}) async {
    String errorMsg = '';
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: pass);
      var firebaseInstance = FirestoreDatabaseService();
      firebaseInstance.createDocument("All Users SignIn Info", auth.currentUser!.uid, {"User Name": name, "User Email": email, "Account Password": pass, "Account Type": accountType})
          .onError((e, _) => ErrorWidgets.showErrorSnackBar(msg: e.toString()));
    } on FirebaseAuthException catch (e) {
      switch (e.message) {
        case 'Password should be at least 6 characters':
          errorMsg =
              'Password is too short. It should be at least minimum of 6 characters';
          break;
        case 'The email address is badly formatted.':
          errorMsg =
              'Entered email format is incorrect. Correct Format: xxx...@gmail.com';
          break;
        case 'The email address is already in use by another account.':
          errorMsg = 'Given email is already in use by another account';
          break;
        default:
          errorMsg = 'Case ${e.message} is not yet implemented';
      }
    }
    return errorMsg;
  }

  // function to implement the Google SignIn
  static Future<User?> googleSignIn() async {
    User? user;
    String uid, name, userEmail, imageUrl;
    GoogleAuthProvider authProvider = GoogleAuthProvider();

    try {
      final UserCredential userCredential =
          await auth.signInWithPopup(authProvider);
      user = userCredential.user;
    } catch (e) {
      debugPrint(e.toString());
    }

    if (user != null) {
      uid = user.uid;
      name = user.displayName!;
      userEmail = user.email!;
      imageUrl = user.photoURL!;

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', true);
      prefs.setString('UserId', uid);
      prefs.setString('name', name);
      prefs.setString('userEmail', userEmail);
      prefs.setString('imageUrl', imageUrl);

      FirebaseFirestore.instance
          .collection('UsersAccountData')
          .doc('UserId:$uid')
          .set(({'name': name, 'email': userEmail, 'pass': 'Not exist'}))
          .onError((e, _) => debugPrint("Error writing document: $e"));
    }
    return user;
  }
}
