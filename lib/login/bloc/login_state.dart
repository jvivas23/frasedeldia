part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.statusBiometrics = 1,
    this.status = FormzStatus.pure,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });
  final int statusBiometrics; //1.- Todavía no se valida. 2.- Si puede iniciar con biometría. 3.- No puede iniciar con biometría
  final FormzStatus status;
  final Email email;
  final Password password;

  LoginState copyWith({
    int? statusBiometrics,
    FormzStatus? status,
    Email? email,
    Password? password,
  }) {
    return LoginState(
      statusBiometrics: statusBiometrics ?? this.statusBiometrics,
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [statusBiometrics,status, email, password];
}