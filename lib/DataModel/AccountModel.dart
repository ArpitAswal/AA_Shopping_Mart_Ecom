/// address : {"geolocation":{"lat":"-37.3159","long":"81.1496"},"city":"kilcoole","street":"new road","number":7682,"zipcode":"12926-3874"}
/// id : 1
/// email : "john@gmail.com"
/// username : "johnd"
/// password : "m38rmF$"
/// name : {"firstname":"john","lastname":"doe"}
/// phone : "1-570-236-7033"
/// __v : 0

class AccountModel {
  AccountModel({
      Address? address, 
      num? id, 
      String? email, 
      String? username, 
      String? password, 
      Name? name, 
      String? phone, 
      num? v,}){
    _address = address;
    _id = id;
    _email = email;
    _username = username;
    _password = password;
    _name = name;
    _phone = phone;
    _v = v;
}

  AccountModel.fromJson(dynamic json) {
    _address = json['address'] != null ? Address.fromJson(json['address']) : null;
    _id = json['id'];
    _email = json['email'];
    _username = json['username'];
    _password = json['password'];
    _name = json['name'] != null ? Name.fromJson(json['name']) : null;
    _phone = json['phone'];
    _v = json['__v'];
  }
  Address? _address;
  num? _id;
  String? _email;
  String? _username;
  String? _password;
  Name? _name;
  String? _phone;
  num? _v;
AccountModel copyWith({  Address? address,
  num? id,
  String? email,
  String? username,
  String? password,
  Name? name,
  String? phone,
  num? v,
}) => AccountModel(  address: address ?? _address,
  id: id ?? _id,
  email: email ?? _email,
  username: username ?? _username,
  password: password ?? _password,
  name: name ?? _name,
  phone: phone ?? _phone,
  v: v ?? _v,
);
  Address? get address => _address;
  num? get id => _id;
  String? get email => _email;
  String? get username => _username;
  String? get password => _password;
  Name? get name => _name;
  String? get phone => _phone;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    map['id'] = _id;
    map['email'] = _email;
    map['username'] = _username;
    map['password'] = _password;
    if (_name != null) {
      map['name'] = _name?.toJson();
    }
    map['phone'] = _phone;
    map['__v'] = _v;
    return map;
  }

}

/// firstname : "john"
/// lastname : "doe"

class Name {
  Name({
      String? firstname, 
      String? lastname,}){
    _firstname = firstname;
    _lastname = lastname;
}

  Name.fromJson(dynamic json) {
    _firstname = json['firstname'];
    _lastname = json['lastname'];
  }
  String? _firstname;
  String? _lastname;
Name copyWith({  String? firstname,
  String? lastname,
}) => Name(  firstname: firstname ?? _firstname,
  lastname: lastname ?? _lastname,
);
  String? get firstname => _firstname;
  String? get lastname => _lastname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstname'] = _firstname;
    map['lastname'] = _lastname;
    return map;
  }

}

/// geolocation : {"lat":"-37.3159","long":"81.1496"}
/// city : "kilcoole"
/// street : "new road"
/// number : 7682
/// zipcode : "12926-3874"

class Address {
  Address({
      Geolocation? geolocation, 
      String? city, 
      String? street, 
      num? number, 
      String? zipcode,}){
    _geolocation = geolocation;
    _city = city;
    _street = street;
    _number = number;
    _zipcode = zipcode;
}

  Address.fromJson(dynamic json) {
    _geolocation = json['geolocation'] != null ? Geolocation.fromJson(json['geolocation']) : null;
    _city = json['city'];
    _street = json['street'];
    _number = json['number'];
    _zipcode = json['zipcode'];
  }
  Geolocation? _geolocation;
  String? _city;
  String? _street;
  num? _number;
  String? _zipcode;
Address copyWith({  Geolocation? geolocation,
  String? city,
  String? street,
  num? number,
  String? zipcode,
}) => Address(  geolocation: geolocation ?? _geolocation,
  city: city ?? _city,
  street: street ?? _street,
  number: number ?? _number,
  zipcode: zipcode ?? _zipcode,
);
  Geolocation? get geolocation => _geolocation;
  String? get city => _city;
  String? get street => _street;
  num? get number => _number;
  String? get zipcode => _zipcode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_geolocation != null) {
      map['geolocation'] = _geolocation?.toJson();
    }
    map['city'] = _city;
    map['street'] = _street;
    map['number'] = _number;
    map['zipcode'] = _zipcode;
    return map;
  }

}

/// lat : "-37.3159"
/// long : "81.1496"

class Geolocation {
  Geolocation({
      String? lat, 
      String? long,}){
    _lat = lat;
    _long = long;
}

  Geolocation.fromJson(dynamic json) {
    _lat = json['lat'];
    _long = json['long'];
  }
  String? _lat;
  String? _long;
Geolocation copyWith({  String? lat,
  String? long,
}) => Geolocation(  lat: lat ?? _lat,
  long: long ?? _long,
);
  String? get lat => _lat;
  String? get long => _long;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['long'] = _long;
    return map;
  }

}