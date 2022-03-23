import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frasedeldia/login/login.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(title: const Text('Login')),
      body: SizedBox(
        height: MediaQuery.of(context).size.height-MediaQuery.of(context).viewInsets.bottom,
        child: SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.all(12),
           child: BlocProvider(
             create: (context) {
               return LoginBloc(
                 authenticationRepository:
                 RepositoryProvider.of<AuthenticationRepository>(context),
               );
             },
             child: LoginForm(),
           ),
         ),
        )
      )
    );
  }
}