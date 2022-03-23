import 'package:bloc/bloc.dart';
import 'package:frasedeldia/quote_api/quote_api.dart';
import 'package:meta/meta.dart';
import 'package:frasedeldia/quote/quote.dart';

part 'quote_event.dart';
part 'quote_state.dart';


class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {

  QuoteBloc() : super( const QuoteInitialState() ) {

    on<ActivateQuote>((event, emit) => emit( state.copyWith(
        existQuote: true,
        quote: event.quote
    ))
    );

    _init();
  }

  Future<void> _init() async {
    final QuoteAPI quoteAPI = QuoteAPI();
    var quote = await quoteAPI.getQuote();
    add(ActivateQuote(quote));
  }
}