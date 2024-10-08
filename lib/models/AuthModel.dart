// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthModel {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   Future<UserCredential?> signInWithEmailPassword(
//       String email, String password) async {
//     try {
//       return await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//       throw Exception("Login failed: ${e.message}");
//     }
//   }

//   Future<UserCredential?> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) {
//         return null; // User canceled the sign-in
//       }
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//       return await _auth.signInWithCredential(credential);
//     } on FirebaseAuthException catch (e) {
//       throw Exception("Google sign-in failed: ${e.message}");
//     }
//   }
// }
