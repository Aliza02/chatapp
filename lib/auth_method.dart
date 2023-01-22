import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore store = FirebaseFirestore.instance;

Future Signup(
    {required String name,
    required String email,
    required String password}) async {
  try {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;
    if (user != null) {
      user.updateDisplayName(name);

      await user.reload();
    }
    await store.collection('user').doc(auth.currentUser?.uid).set({
      "name": name,
      "email": email,
      "status": "unavailable",
    });
  } on FirebaseException catch (e) {
    print(e.message);
  }
}

Future Signin({required String email, required String password}) async {
  try {
    UserCredential userCred =
        await auth.signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    print(e.message);
  }
}

Future Signout() async {
  await auth.signOut();
}
