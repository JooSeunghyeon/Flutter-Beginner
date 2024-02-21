import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterbeginner/model/ex_model.dart';
import 'package:http/http.dart' as http;

class AsyncScreen extends StatelessWidget {
  const AsyncScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: const MainPage(),
      theme: ThemeData(
        useMaterial3: true, // 활성화
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

Future<void> getUserOrder() {
  return Future.delayed(Duration(seconds: 3), () {
    getUserText = "getUserOrder 호출 완료";
  });
}

// Asynchronous
Future<String> createOrderMessage() async {
  var order = await getUserOrder2();
  return 'Your order is: $order';
}

Future<String> getUserOrder2() {
  return
    Future.delayed(
        Duration(seconds: 4), () => 'Large Latte');
}

Future<String> futurebuilder() async{
  await Future.delayed(Duration(seconds: 3));
  return 'CallBack';
}

// String jsonDecode(){
//   CodeNameModel code = CodeNameModel("만원으로 살 수 있는 주식");
//   // String jsonCode = jsonEncode(code);
//
//   // return jsonCode;
// }

Future<List<ExModel>> futurebuilder2() async {
  var body = jsonEncode( {
    'stocktype': "만원으로 살 수 있는 주식"
  });

  var response = await http.post(
      Uri.parse('http://m6ydz642a604.iptime.org:9090/stock_code_type_serach'),
      body: body,
      headers: {'content-type': 'application/json'}
  );
  if (response.statusCode == 200) {
    List<ExModel> data = exModelFromJson(response.body);

    // List<dynamic> data = json.decode(response.body);

    print(data.length);

    print('성공');

    return data;
  } else {
    //만약 응답이 ok가 아니면 에러를 던집니다.
    throw Exception('종목 불러오기 실패');
  }
}

String getUserText = "";

String getUserText2 = "";

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Async 예제"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        getUserOrder().then((value) {
                          setState(() {});
                        });
                      },
                      child: Text("3초뒤 Print 출력하는 함수")),
                  Text(getUserText),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () async{
                        await createOrderMessage().then((value){
                          getUserText2 = value;
                          setState(() {});
                        });
                      },
                      child: Text("await 사요하는 함수")),
                  Text(getUserText2),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Futubilder",style: TextStyle(fontSize: 18),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder(
                      future: futurebuilder(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData == false) {
                          return CircularProgressIndicator();
                        }
                        //error가 발생하게 될 경우 반환하게 되는 부분
                        else if (snapshot.hasError) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Error: ${snapshot.error}',
                              style: TextStyle(fontSize: 15),
                            ),
                          );
                        }else{
                          return SizedBox(
                            height: 20,
                            child: Text(snapshot.data),
                          );
                        }
                      })
                ],
              ),
              SizedBox(height: 40,),
              Row(
                children: [
                  Text('실제로 사용하는 Futurebuilder 예제',style: TextStyle(fontSize: 16),),
                ],
              ),
              FutureBuilder(
              future: futurebuilder2(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if (snapshot.hasData == false) {
                  return CircularProgressIndicator();
                }
                //error가 발생하게 될 경우 반환하게 되는 부분
                else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }else{
                    return Text("");
                }
              }),

            ],
          ),
        ),
      ),
    );
  }
}
