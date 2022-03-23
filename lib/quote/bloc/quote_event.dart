part of 'quote_bloc.dart';

@immutable
abstract class QuoteEvent {}

class ActivateQuote extends QuoteEvent {
  final Quote quote;
  ActivateQuote(this.quote);
}