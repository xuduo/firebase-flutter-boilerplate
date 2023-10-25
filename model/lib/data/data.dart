class Data<T> {
  T? _data;
  String? errorMessage;

  set data(T? data){
    _data = data;
    errorMessage = null;
  }

  T? get data => _data;
}