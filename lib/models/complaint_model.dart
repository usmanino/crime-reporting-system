class ComplaintModel {
  String fullName;
  String gender;
  String skinColor;
  String ageApprox;
  String height;
  String eyeColor;
  String date;
  String ethnicity;
  String hairColor;
  String tattooDescription;
  String facialHair;
  String town;
  String city;
  String state;
  String description;

  ComplaintModel({

    this.fullName,
    this.gender,
    this.skinColor,
    this.ageApprox,
    this.height,
    this.eyeColor,
    this.date,
    this.ethnicity,
    this.facialHair,
    this.hairColor,
    this.tattooDescription,
    this.town,
    this.city,
    this.state,
    this.description,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'full_name': fullName,
      'gender': gender,
      'skin_color': skinColor,
      'age': ageApprox,
      'height': height,
      'eye_colour': eyeColor,
      'date': date,
      'ethnicity': ethnicity,
      'facial_hair': facialHair,
      'hair_color': hairColor,
      'tattoo_description': tattooDescription,
      'town': town,
      'city': city,
      'state': state,
      'description': description,
    };
    return map;
  }

  ComplaintModel.fromMap(Map<String, dynamic> map) {
    fullName = map['full_name'];
    gender = map['gender'];
    skinColor = map['skin_color'];
    ageApprox = map['age'];
    height = map['height'];
    eyeColor = map['eye_colour'];
    date = map['date'];
    ethnicity = map['ethnicity'];
    facialHair = map['facial_hair'];
    hairColor = map['hair_color'];
    tattooDescription = map['tattoo_description'];
    town = map['town'];
    city = map['city'];
    state = map['state'];
    description = map['description'];
  }
}

// class ComplaintModel {
//   String fullName;
//   String gender;
//   String skinColor;
//   String ageApprox;
//   String height;
//   String eyeColor;
//   String date;
//   String ethnicity;
//   String hairColor;
//   String tattooDescription = "";
//   String facialHair;
//   //List<ComplaintListModel> complaintListModel;

//   ComplaintModel(
//     String name,
//     String tdes,
//     String age,
//     String eye,
//     String skin,
//     String gen,
//     String facial,
//     String eth,
//     String hair,
//     String heightt,
//     String ondate, {
//     this.date,
//     this.skinColor,
//     this.fullName,
//     this.gender,
//     this.ageApprox,
//     this.height,
//     this.eyeColor,
//     this.ethnicity,
//     this.hairColor,
//     this.tattooDescription,
//     this.facialHair,
//   });
//   ComplaintModel.withId({
//     this.date,
//     this.fullName,
//     this.gender,
//     this.ageApprox,
//     this.height,
//     this.eyeColor,
//     this.ethnicity,
//     this.hairColor,
//     this.skinColor,
//     this.tattooDescription,
//     this.facialHair,
//   });

//   Map<String, dynamic> toMap() {
//     final map = Map<String, dynamic>();
//     map['name'] = fullName;
//     map['gender'] = gender;
//     map['skin_color'] = skinColor;
//     map['age_approx'] = ageApprox;
//     map['height'] = height;
//     map['eye_colour'] = eyeColor;
//     map['date'] = date;
//     map['ethnicity'] = ethnicity;
//     map['hair_colour'] = hairColor;
//     map['tattoo_description'] = tattooDescription;
//     map['facial_hair'] = facialHair;

//     return map;
//   }

//   factory ComplaintModel.fromMap(Map<String, dynamic> map) {
//     return ComplaintModel.withId(
//       fullName: map['name'],
//       skinColor: map['skin_color'],
//       gender: map['gender'],
//       ageApprox: map['age_approx'],
//       height: map['height'],
//       eyeColor: map['eye_colour'],
//       ethnicity: map['ethnicity'],
//       date: map['date'],
//       hairColor: map['hair_colour'],
//       tattooDescription: map['tattoo_description'],
//       facialHair: map['facial_hair'],
//     );
//   }

//   ComplaintModel.convert(Map<String, dynamic> json) {
//     this.fullName = json['data']['details']['abuser_details']['name'];
//     this.gender = json['data']['details']['abuser_details']['gender'];
//     this.ageApprox = json['data']['details']['abuser_details']['age_approx'];
//     this.eyeColor = json['data']['details']['abuser_details']['eye_colour'];
//     this.ethnicity = json['data']['details']['abuser_details']['ethnicity'];
//     this.skinColor = json['data']['details']['abuser_details']['skin_colour'];
//     this.hairColor = json['data']['details']['abuser_details']['hair_colour'];
//     this.date = json['data']['details']['date'];
//     this.facialHair = json['data']['details']['abuser_details']['facial_hair'];
//     this.height = json['data']['details']['abuser_details']['height'];
//     this.tattooDescription = json['data']['details']['abuser_details']
//         ['tattoos']['tattoo_description'];
//   }
// }

class ComplaintModelL {
  String id;
  String town;
  String city;
  String state;

  String description = "";

  //List<ComplaintListModel> complaintListModel;

  ComplaintModelL({
    this.town,
    this.city,
    this.state,
    this.description,
  });
  ComplaintModelL.withId({
    this.id,
    this.town,
    this.city,
    this.state,
    this.description,
  });

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();

    map['town'] = town;
    map['state'] = state;
    map['city'] = city;

    map['description'] = description;

    return map;
  }

  factory ComplaintModelL.fromMap(Map<String, dynamic> map) {
    return ComplaintModelL(
        town: map['town'],
        state: map['state'],
        city: map['city'],
        description: map['description']);
  }
}
