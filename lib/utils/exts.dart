
import 'package:flutter/foundation.dart';

extension NullCheckObject on Object? {
  void whatIfNotNull(Function() action) {
    if(this != null){
      action();
    }
  }
}
extension NullCheckFunction on Function? {
  void whatIfNotNull(Function() action) {
    if(this != null){
      action();
    }
  }
}
extension NullCheckKey on Key? {
  void whatIfNotNull(Function() action) {
    if(this != null){
      action();
    }
  }
}