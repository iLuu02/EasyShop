class Pila<T> {
  final List<T> _stack = [];

  // Agrega un elemento a la pila
  void push(T item) {
    _stack.add(item);
  }

  // Elimina y devuelve el último elemento de la pila
  T pop() {
    if (isEmpty()) {
      throw Exception('La pila está vacía');
    }
    T item = _stack.last;
    _stack.removeLast();
    return item;
  }

  // Devuelve el último elemento de la pila sin eliminarlo
  T peek() {
    if (isEmpty()) {
      throw Exception('La pila está vacía');
    }
    return _stack.last;
  }

  // Elimina todos los elementos de la pila
  void clear() {
    _stack.clear();
  }

  // Verifica si la pila está vacía
  bool isEmpty() {
    return _stack.isEmpty;
  }
}