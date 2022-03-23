import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frasedeldia/login/login.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Las credenciales no son correctas')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 250,
                    width: 250,
                    child: Image.asset('assets/launcher/logo.png'),
                  )
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.all(12)),
            _EmailInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _LoginButton(),
            const Padding(padding: EdgeInsets.all(12)),
            _LoginBiometricButton()
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('emailTextField'),
          onChanged: (email) =>
              context.read<LoginBloc>().add(LoginEmailChanged(email)),
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0)
            ),
            labelText: 'Email',
            errorText: state.email.invalid ? 'Email incorrecto' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('passwordTextField'),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
            labelText: 'Contraseña',
            errorText: state.password.invalid ? 'Contraseña incorrecta' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
          key: const Key('loginBtn'),
          child: const Text('Iniciar sesión'),
          onPressed: state.status.isValidated ? () {
            context.read<LoginBloc>().add(const LoginSubmitted());
          }
              : null,
        );
      },
    );
  }
}

class _LoginBiometricButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.statusBiometrics != current.statusBiometrics,
      builder: (context, state) {
        return state.statusBiometrics == 1
            ? const CircularProgressIndicator()
            : state.statusBiometrics == 2 ? ElevatedButton(
          key: const Key('loginBiometricBtn'),
          child: const Text('Iniciar sesión con biométrico'),
          onPressed: () {
            late LoginBloc loginBloc =  BlocProvider.of<LoginBloc>(context);
            loginBloc.loginWithBiometric();
          }
        ):const Text('No tiene soporte para iniciar sesión con biométrico');
      },
    );
  }
}