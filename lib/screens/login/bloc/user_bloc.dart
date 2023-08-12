import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

sealed class UserState {}

class NoUser extends UserState {}

class HasUser extends UserState {
  final User user;

  HasUser({required this.user});
}

class HasError extends UserState {
  final Object error;

  HasError(this.error);
}

sealed class UserEvent {}

class EmailLogin extends UserEvent {
  final String email, password;

  EmailLogin({required this.email, required this.password});
}

class GoogleLogin extends UserEvent {}

class Logout extends UserEvent {}

class UserStateChanged extends UserEvent {
  final User? user;

  UserStateChanged(this.user);
}

final class UserBloc extends Bloc<UserEvent, UserState> {
  static final auth = FirebaseAuth.instance;

  void onUserStateChanged(User? user) {
    add(UserStateChanged(user));
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await auth.signInWithCredential(credential);
  }

  UserBloc()
      : super((auth.currentUser == null)
            ? NoUser()
            : HasUser(user: auth.currentUser!)) {
    on<UserStateChanged>(
      (event, emit) {
        emit((event.user == null) ? NoUser() : HasUser(user: event.user!));
      },
    );

    on<GoogleLogin>(
      (event, emit) async {
        try {
          final userCreds = await signInWithGoogle();
          emit(HasUser(user: userCreds.user!));
        } on FirebaseAuthException catch (e) {
          resolveAuthError(e.code, emit);
        } catch (e) {
          emit(HasError("Что-то пошло не так"));
        }
      },
    );

    on<Logout>(
      (event, emit) async {
        await auth.signOut();
        emit(NoUser());
      },
    );

    on<EmailLogin>(
      (event, emit) async {
        try {
          final userCreds = await auth.signInWithEmailAndPassword(
              email: event.email, password: event.password);
          emit(HasUser(user: userCreds.user!));
        } on FirebaseAuthException catch (e) {
          resolveAuthError(e.code, emit);
        } catch (e) {
          emit(HasError("Что-то пошло не так"));
        }
      },
    );

    auth.authStateChanges().listen(onUserStateChanged);
  }

  resolveAuthError(String code, Emitter<UserState> emit) {
    switch (code) {
      case "wrong-password" || "user-not-found":
        emit(HasError("Неверное имя пользователя или пароль"));
        break;
      default:
        emit(HasError("Что-то пошло не так"));
        break;
    }
  }
}
