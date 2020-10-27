import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:prueba/services/auth_service.dart';

class AuthBloc {
  final authService = AuthService();
  final fb = FacebookLogin();
  
  Stream<User> get currentUser => authService.currentUser;

  loginFacebook() async {
    final res = await fb.logIn(
      permissions:[FacebookPermission.publicProfile,FacebookPermission.email] 
    );
    switch(res.status){
      case FacebookLoginStatus.Success:
      print('SUCESS!!!!!!!');

      final FacebookAccessToken fbToken = res.accessToken;
      final AuthCredential credential = FacebookAuthProvider.credential(fbToken.token);

      final result = await authService.signInWithCredemtial(credential);
      print('${result.user.displayName} is now LOGIN');



      break;
      case FacebookLoginStatus.Cancel:
      print('CANCEL!!!!!!!');
      break;
      case FacebookLoginStatus.Error:
      print('ERROR!!!!!!!');
      break;
    }
  }

  logoutFacebook(){
    authService.logout();
  }
}