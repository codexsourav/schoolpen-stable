// ignore: file_names
import 'package:schoolpenintern/data/Network/config.dart';

String loadImage(id, role) {
  var url = ('${Config.hostUrl}/get_image/$id/$role');
  print(url);
  return url;
}
