
class Quote{
  final String title;
  final String author;
  final String quote;
  final String idQuote;
  final String length;
  final String category;
  final String language;
  final String background;
  final String permalink;

  const Quote({
    required this.title,
    required this.author,
    required this.quote,
    required this.idQuote,
    required this.length,
    required this.category,
    required this.language,
    required this.background,
    required this.permalink,
  });

  factory Quote.fromJson(Map<String,dynamic> jsonData){
    return Quote(
      title: jsonData["contents"]["quotes"][0]["title"] as String,
      idQuote: jsonData["contents"]["quotes"][0]["id"] as String,
      author: jsonData["contents"]["quotes"][0]["author"] as String,
      quote: jsonData["contents"]["quotes"][0]["quote"] as String,
      length: jsonData["contents"]["quotes"][0]["length"] as String,
      category: jsonData["contents"]["quotes"][0]["category"] as String,
      language: jsonData["contents"]["quotes"][0]["language"] as String,
      background: jsonData["contents"]["quotes"][0]["background"] as String,
      permalink: jsonData["contents"]["quotes"][0]["permalink"] as String,
    );
  }
}