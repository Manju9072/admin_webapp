class Article {
  String articleType;
  String title;
  String content;
  List<Map<String, String>> mainImage; // Change to list of maps
  List<Map<String, String>> additionalImages;
  List<String> additionalTexts;
  Map<String, String> seoData;
  Map<String, String> headerData;

  Article({
    required this.articleType,
    required this.title,
    required this.content,
    required this.mainImage,
    this.additionalImages = const [],
    this.additionalTexts = const [],
    this.seoData = const {},
    this.headerData = const {},
  });

  // Factory constructor to create an Article from a map
  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      articleType: map['articleType'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      mainImage: List<Map<String, String>>.from(map['mainImage'] ?? []),
      additionalImages:
          List<Map<String, String>>.from(map['additionalImages'] ?? []),
      additionalTexts: List<String>.from(map['additionalTexts'] ?? []),
      seoData: Map<String, String>.from(map['seoData'] ?? {}),
      headerData: Map<String, String>.from(map['headerData'] ?? {}),
    );
  }

  // Method to convert the Article to a map
  Map<String, dynamic> toMap() {
    return {
      'articleType': articleType,
      'title': title,
      'content': content,
      'mainImage': mainImage,
      'additionalImages': additionalImages,
      'additionalTexts': additionalTexts,
      'seoData': seoData,
      'headerData': headerData,
    };
  }
}
