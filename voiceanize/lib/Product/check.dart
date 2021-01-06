import 'package:mime/mime.dart';
import 'package:validators/validators.dart';

class Check {
  bool isDouble(String val) {
    try {
      double.parse(val);
      return true;
    } catch (NumberFormatException) {
        return false;
    }   
  }
  
  bool isImageURL(String val) {
    if(val == '')
    {
      return true;
    }
    else if(isURL(val) && lookupMimeType(val).contains('image')) {
      return true;
    }
    return false;
  }

  bool isInt(double val) {
    return(val == val.roundToDouble());
  }
}