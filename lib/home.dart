
import 'package:ai_diction/controeller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AiController controller = Get.put(AiController());
    TextEditingController textField = TextEditingController();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 135, 215, 145),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:40.0),
              child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
              const Text(
                "ai",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 24),
              ),
                const Text(
                "Diction",
                style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 2, 77, 5),fontSize: 24),
              ),
                      ],
                    ),
            ),
            SizedBox(height: 12,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60)
              ),
               child: ClipRRect(
                borderRadius: BorderRadius.circular(60)
                ,
                child: Image.asset("assets/img.jpg",height: 80,width: 80,fit: BoxFit.cover,))
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Lets Ask a question!!!",style:TextStyle(fontWeight: FontWeight.w500, color: Color.fromARGB(255, 2, 77, 5),fontSize: 20))
              ],
            ),
            SizedBox(height: 16,),
            Expanded(
                child: ListView(
              children: [
                
                Obx(() => Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  
                  child: Column(
                        children:
                        
                         controller.historyList
                            .map(
                              (e) => Container(
                                margin: EdgeInsets.symmetric(vertical: 14),
                                padding: EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 14),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 74, 168, 119),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Text(e.system == "user" ? "👨‍💻" : "⚛️"),
                                    SizedBox(width: 10),
                                    Flexible(child: Text(e.message)),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                ))
              ],
            )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 176, 236, 214).withOpacity(0.9),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 60,
              child: Row(children: [
                Expanded(
                  child: TextFormField(
                    controller: textField,
                    decoration: InputDecoration(
                        hintText: "Enter text here",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        )),
                  ),
                ),
                Obx(
                  () => controller.isLoading.value
                      ? CircularProgressIndicator()
                      : IconButton(
                          onPressed: () {
                            if (textField.text != "") {
                              controller.sendPrompt(textField.text);
                              textField.clear();
                            }
                          },
                          icon: Icon(
                            Icons.send,
                            color: Color.fromARGB(255, 117, 214, 120),
                          )),
                ),
                SizedBox(width: 10)
              ]),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}