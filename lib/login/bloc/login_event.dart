part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginBiometricsSupported extends LoginEvent {
  const LoginBiometricsSupported(this.statusBiometrics);

  final int statusBiometrics;

  @override
  List<Object> get props => [statusBiometrics];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}

class LoginWithBiometricSuccess extends LoginEvent {
  const LoginWithBiometricSuccess();
}

class LoginWithBiometricFailure extends LoginEvent {
  const LoginWithBiometricFailure();
}