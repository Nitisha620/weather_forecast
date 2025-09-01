import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_forcast/styles/app_theme.dart';

void showToast(String message, {ToastGravity gravity = ToastGravity.BOTTOM}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: gravity,
    timeInSecForIosWeb: 1,
    backgroundColor: AppThemes.greyColor,
    textColor: AppThemes.secondaryColor,
    fontSize: 14.0,
  );
}

void cancelToast() {
  Fluttertoast.cancel();
}
