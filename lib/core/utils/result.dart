class Result<T> {
  final T value;
  final bool isSucceed;
  final String errorMessage;

  const Result({
    required this.value,
    required this.isSucceed,
    this.errorMessage = ""
  });

  @override
  String toString(){
    if(isSucceed){
      return "success ::: value => $value";
    }
    else {
      return "failed ::: value => $value ::: errorMassage => $errorMessage";
    }
  }
}
