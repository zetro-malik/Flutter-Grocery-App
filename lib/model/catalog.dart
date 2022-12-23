
class CatalogItemsByCate{
   static List<CatalogItem> dairylst=[];
static  List<CatalogItem> fruitlst=[];
 static List<CatalogItem> veglst=[];
 static List<CatalogItem> bakerylst=[];
  static List<CatalogItem> meatlst=[];
}

class CatalogItems{
  static List<CatalogItem> plist = [];
}

class CatalogItem{
  String title;
  String type;
  String description;
  String imgpath;
  double price;
  int rating;
  
   CatalogItem( { required this.title, required this.type, required this.description,required this.imgpath,required this.price,required this.rating});


  static fromMap(Map<String, dynamic> map) {
    CatalogItem a = CatalogItem(
      title: map["title"],
      type: map["type"],
      description: map["description"],
      imgpath: map["filename"],
      price:double.parse( map["price"].toString()),
      rating:int.parse(map["rating"].toString())
    );
    return a;
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'ID': this.ID,
  //     'email': this.email,
  //     'gender':this.gender,
  //     "city":this.city,
  //     'password': this.password,
  //     "img":this.img
      

  //   };
  // }

}

