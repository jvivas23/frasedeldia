import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frasedeldia/authentication/authentication.dart';
import 'package:frasedeldia/quote/bloc/quote_bloc.dart';

class QuotePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => QuotePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuoteBloc>(
      create: (context) {
        return QuoteBloc();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              BlocBuilder<QuoteBloc, QuoteState>(
                buildWhen: (previous, current) => previous.existQuote != current.existQuote,
                builder: (context, state) {
                  if(!state.existQuote){
                    return const CircularProgressIndicator();
                  }else{
                    var title = state.quote!.title;
                    var quote = state.quote!.quote;
                    var imagen = state.quote!.background;
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      margin: EdgeInsets.all(15),
                      elevation: 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(title),
                              ),
                              Image(
                                image: NetworkImage(
                                    imagen),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(quote),
                              )
                            ]
                        )
                      )
                    );
                  }
                },
              ),
              Builder(
                builder: (context) {
                  final userId = context.select(
                        (AuthenticationBloc bloc) => bloc.state.user.id,
                  );
                  return Text('UserID: $userId');
                },
              ),
              ElevatedButton(
                child: const Text('Cerrar sesión'),
                onPressed: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationLogoutRequested());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}