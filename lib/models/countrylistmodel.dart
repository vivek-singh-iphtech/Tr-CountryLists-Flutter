class CountryModel {
  final int? id;
  final String? image;
  final String? title;
  final String? subtitle;
  final String? link;

  CountryModel(
      {required this.id,
      this.image,
      this.title,
      this.subtitle,
      this.link}); //constructor

  factory CountryModel.fromJson(Map<String, dynamic> json,
      int index) //factory method to create the instance of the country model
  {
    return CountryModel(
        //return the object of this class model
        id: index,
        image: json['image'],
        title: json['title'],
        subtitle: json['subtitle'],
        link: json['link']);
  }
}
