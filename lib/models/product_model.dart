class ProductModel {
  final String ?id;
  final String ?productPrice;
  final String ?productName;
  final String ?productRating;
  final String ?productCategory;
  final String ?productImage;

  ProductModel(
      { this.id,
      this.productPrice,
      this.productName,
      this.productRating,
      this.productCategory,
      this.productImage}
      );

  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'productPrice':productPrice,
      'productName':productName,
      'productRating':productRating,
      'productCategory':productCategory,
      'productImage': productImage,
    };
  }

  factory ProductModel.fromMap(Map<String,dynamic> data){
    return ProductModel(
        id: data['id']??'',
        productPrice: data['productPrice']??'',
        productCategory: data['productCategory']??'',
        productName: data['productName']??'',
        productImage: data['productImage']??'',
        productRating: data['productRating']??'',
    );
  }
}
