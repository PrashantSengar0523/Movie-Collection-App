class MovieCollectionModel {
  
  String image;
  String name;
  String director;
  

  MovieCollectionModel(
      {
      required this.image,
      required this.name,
     required this.director,
      }
    );

    Map<String,dynamic> toJson(){
      return{
        
        'Image':image,
        'Name':name,
        'Director':director,
        
      };
    }

    factory MovieCollectionModel.fromMap(Map<String,dynamic> data){
      return MovieCollectionModel(
     
        image: data['Image']??'',
        name: data['Name']??'',
        director: data['Director']??'',
        
        );
    }
}
