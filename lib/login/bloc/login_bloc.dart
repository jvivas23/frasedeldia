import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frasedeldia/login/login.dart';
import 'package:formz/formz.dart';
import 'package:local_auth/local_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _localAuth = LocalAuthentication();
  
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginBiometricsSupported>((event, emit) => emit( state.copyWith(
        statusBiometrics: event.statusBiometrics
    ))
    );
    on<LoginWithBiometricSuccess>((event, emit) => emit(state.copyWith(status: FormzStatus.submissionSuccess))
    );
    on<LoginWithBiometricFailure>((event, emit) => emit(state.copyWith(status: FormzStatus.submissionFailure))
    );
    _checkIfBiometricsSupported();
  }

  final AuthenticationRepository _authenticationRepository;

  void _onEmailChanged(
      LoginEmailChanged event,
      Emitter<LoginState> emit,
      ) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([state.password, email]),
    ));
  }

  void _onPasswordChanged(
      LoginPasswordChanged event,
      Emitter<LoginState> emit,
      ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.email]),
    ));
  }

  void _onSubmitted(
      LoginSubmitted event,
      Emitter<LoginState> emit,
      ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        if(await _authenticationRepository.logIn(
          email: state.email.value,
          password: state.password.value,
        )){
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        }else{
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }else{
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> _checkIfBiometricsSupported() async {
    bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
    int  statusBiometrics;
    canCheckBiometrics ? statusBiometrics=2:statusBiometrics=3;
    add(LoginBiometricsSupported(statusBiometrics));
  }

  Future<void> loginWithBiometric() async{
    bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        useErrorDialogs: true,
        stickyAuth: false,
        biometricOnly: true);
    if(await _authenticationRepository.logInWithBiometric(
      didAuthenticate: didAuthenticate,
    )){
      add(LoginWithBiometricSuccess());
    }
  }
}