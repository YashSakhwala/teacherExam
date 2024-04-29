import 'package:fluttertoast/fluttertoast.dart';
import '../../config/app_colors.dart';

void toastView({required String msg}) {
  Fluttertoast.showToast(
    msg: msg,
    fontSize: 16,
    textColor: AppColors.whiteColor,
    backgroundColor: AppColors.blackColor.withOpacity(0.5),
  );
}
