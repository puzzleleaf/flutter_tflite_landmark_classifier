class Landmark {
  final String title;
  final String text;
  final String image;
  final String model;
  final String label;

  Landmark({this.title, this.text, this.image, this.model, this.label});

  factory Landmark.fromJson(json) {
    return Landmark(
      title: json['title'],
      text: json['text'],
      image: json['image'],
      model: json['model'],
      label: json['label'],
    );
  }
}
