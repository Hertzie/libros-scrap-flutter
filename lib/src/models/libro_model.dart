
class Libro{
  String imagen;
  String tituloLibro;
  String precio;
  String stock;
  String link;
  String upc;
  String tipoProducto;
  String precioNormal;
  String precioImpuesto;
  String tax;
  String disponibilidad;
  String reviews;
  String descripcion;
  String categoria;
  bool isFavorito;

  Libro({
    this.imagen,
    this.tituloLibro,
    this.precio,
    this.stock,
    this.link,
    this.upc,
    this.tipoProducto,
    this.precioImpuesto,
    this.precioNormal,
    this.tax,
    this.disponibilidad,
    this.reviews,
    this.descripcion,
    this.categoria,
    this.isFavorito
  });

  Libro.mapFromJson(Map<String, dynamic> json){
    imagen = json['imagen'];
    tituloLibro = json['titulo_libro'];
    precio = json['precio'];
    stock = json['stock'];
    link = json['link'];
    upc = json['upc'];
    tipoProducto = json['product_type'];
    precioNormal = json['precio_normal'];
    precioImpuesto = json['precio_impuesto'];
    tax = json['tax'];
    disponibilidad = json['availability'];
    reviews = json['number_of_reviews'];
    descripcion = json['descripcion'];
    categoria = json['categoria'];
    isFavorito = false;
  }
}