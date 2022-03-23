part of 'quote_bloc.dart';

@immutable
class QuoteState {
  final bool existQuote;
  final Quote? quote;

  const QuoteState({
    this.existQuote = false,
    this.quote
  });

  QuoteState copyWith({
    bool? existQuote,
    Quote? quote,
  }) => QuoteState(
      existQuote: existQuote ?? this.existQuote,
      quote: quote ?? this.quote
  );
}

class QuoteInitialState extends QuoteState {
  const QuoteInitialState(): super( existQuote: false, quote: null );
}

class QuoteSetState extends QuoteState {
  final Quote newQuote;
  const QuoteSetState(this.newQuote)
      : super(existQuote: true, quote: newQuote);
}