import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated,unauthorized}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final String emailTest = "test@vivasdev.com";
  final String passwordTest = "123456";
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<bool> logIn({
    required String email,
    required String password,
  }) async {
    if(email == emailTest && password == passwordTest){
      await Future.delayed(
        const Duration(milliseconds: 300),
            () => _controller.add(AuthenticationStatus.authenticated),
      );
      return true;
    }else{
      await Future.delayed(
        const Duration(milliseconds: 300),
            () => _controller.add(AuthenticationStatus.unauthorized),
      );
      return false;
    }
  }

  Future<bool> logInWithBiometric({required bool didAuthenticate}) async {
    if(didAuthenticate) {
      await Future.delayed(
        const Duration(milliseconds: 300),
            () => _controller.add(AuthenticationStatus.authenticated),
      );
      return true;
    }else{
      await Future.delayed(
        const Duration(milliseconds: 300),
            () => _controller.add(AuthenticationStatus.unauthorized),
      );
      return false;
    }
  }



  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}