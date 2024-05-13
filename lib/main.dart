import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:images_api/Model/imageModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ImageModel> imageModelList=[];
  Future<List<ImageModel>> GetImages() async{
    final response= await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200)
      {
        for(dynamic i in data)
        // ImageModel imageModel=ImageModel(title: i['title'], url: i['url'], id:i['id']);
        imageModelList.add(ImageModel.fromJson(i));
        return imageModelList;
      }
    else
      {
        print('This is an Error Message');
      }
    return imageModelList;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(child:FutureBuilder(
              future: GetImages(),
              builder: (context,snapshot){
                if(!snapshot.hasData)
                  {
                    return Text('Some Thing Went Wrong');
                  }
                else {
                  return ListView.separated(itemBuilder: (context,index) {
                    return Card(
                      child: ListTile(
                        tileColor: Colors.green,
                        leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data![index].url.toString()),),
                        title: Text(snapshot.data![index].title.toString()),
                        subtitle: Text(snapshot.data![index].id.toString()),
                      ),
                    );
                  },
                      separatorBuilder:(BuildContext context,int index){
                    return Divider(height: 10,thickness: 5,color: Colors.black,);
                      },
                      itemCount: imageModelList.length);
                }},
            ),
          )
        ],
      ),

    );
  }
}
