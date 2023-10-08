class Question {
  //every question will have id
  final String id;
  final String title;
  //for options:
  final Map<String, bool> options;
  Question({
    required this.id,
    required this.title,
    required this.options,
  });

  //override toString to print questions on console
  @override
  String toString() {
    return 'Question(id: $id, title: $title, options: $options)';
  }
}
