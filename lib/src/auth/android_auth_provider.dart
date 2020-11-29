import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth_provider_base.dart';

class _AndroidAuthProvider implements AuthProviderBase {
  @override
  Future<FirebaseApp> initialize() async {
    return await Firebase.initializeApp(
        name: 'Chat',
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
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
}
