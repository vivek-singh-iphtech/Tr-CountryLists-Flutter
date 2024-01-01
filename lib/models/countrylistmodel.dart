class CountryModel {

  final String? image;
  final String? title;
  final String? subtitle;
  final String? link;


  CountryModel({required this.image,this.title,this.subtitle,this.link}); //constructor 

  factory CountryModel.fromJson(Map<String,dynamic> json) //factory method to create the instance of the country model
  {
    return CountryModel(  //return the object of this class model
    image: json['image'],
    title: json['title'],
    subtitle: json['subtitle'],
    link:json['link']

    );
  }
}

