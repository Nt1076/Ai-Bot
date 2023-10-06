import 'dart:convert';

import 'package:ai_diction/bardMoedl.dart';
import 'package:ai_diction/data.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class AiController extends GetxController{

  RxList historyList = RxList<BardModel>(
    [
  //   BardModel(
    
  //   system: "user",
  //   message: "what can you do for me"
  //   ),
    //  BardModel(
    
    // system: "bard",
    // message: "what can you do for me"
    // )
    ]
  );

  RxBool isLoading = false.obs;

void sendPrompt(String prompt) async{
    isLoading.value = true;
  var newHistory =BardModel(

    system: "user",
    message: prompt 
  );
  historyList.add(newHistory);
  
  final body = {
  'prompt': {
    'text': prompt,
  }
  } ;

  final request = await http.post(
Uri.parse("https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText?key=$apiKey"),

headers: {
  'Content-Type': 'application/json',
},
body: jsonEncode(body)
  );

  final response = jsonDecode(request.body);
  final bardReply = response["candidates"][0]["output"];
   var newHistory2 =BardModel(

    system: "bard",
    message: bardReply 
  );
  historyList.add(newHistory2);
  print(bardReply);
  isLoading.value = false;
}

}