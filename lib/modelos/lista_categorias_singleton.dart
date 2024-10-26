class CategoriaSingleton {
  final List<String> _categorias = ['Sin asignar'];

  CategoriaSingleton._();

  static final CategoriaSingleton instance = CategoriaSingleton._();

  List<String> get categorias => _categorias;

  void addCategoria(String categoria) {
    _categorias.add(categoria);
  }

  void addCategoriaInPosition(String cat, int index){
    _categorias.insert(index, cat);
  }

  void removeCategoria(int index) {
    _categorias.removeAt(index);
  }

  void updateCategoria(int index, String categoria) {
    _categorias[index] = categoria;
  }
}
