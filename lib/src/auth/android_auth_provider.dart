import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_provider_base.dart';

class _AndroidAuthProvider implements AuthProviderBase {
  @override
  Future<FirebaseApp> initialize() async {
    return await Firebase.initializeApp(
        // Name of the app in Firebase
        name: 'Chat',
        // Options taken from the web folder -> index.html -> copy paste the script on the bottom onto here
        // The appId you get from Firebase -> Project Settings -> Android App -> App Id
        options: FirebaseOptions(
            apiKey: "AIzaSyAXVQH9ygn9EiKCz1OYxoX2oeN-_bN9YXU",
            authDomain: "chat-4b40e.firebaseapp.com",
            databaseURL: "https://chat-4b40e.firebaseio.com",
            projectId: "chat-4b40e",
            storageBucket: "chat-4b40e.appspot.com",
            messagingSenderId: "883326991940",
            appId: "1:883326991940:android:767271c96403bf9a444611",
            measurementId: "G-XYKM9GHNBM"));
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    // This displays the login prompt in the device
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    // Once signed in, can obtain sign in details with contains credentials
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential which gets passed into FirebaseAuth
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredentials, which contains a lot of information about the user
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

class AuthProvider extends _AndroidAuthProvider {}
