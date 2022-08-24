import 'package:flutter/material.dart';
import 'package:untitled2/module/data_notification.dart';
import 'package:untitled2/module/get_data.dart';

late final ResponseNotification responseNotification;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<ResponseNotification> notification() async {
    GetData ret = GetData();
    var responseApi = await ret.getToken();
    return responseNotification = ResponseNotification(responseApi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        buildAppBar(),
        buildListNotification(),
      ],
    );
  }

  Widget buildAppBar() {
    return Row(
      children: [
        const Text(
          'Thông báo',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Expanded(
          child: SizedBox(),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }

  Widget buildListNotification() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasError) {
          return const SizedBox();
        }
        return ListView.separated(
          itemBuilder: (context, index) {
            return Row(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(28.0),
                      child: Image.network(
                        '${responseNotification.data![index].image}',
                        width: 56,
                        height: 56,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(text: TextSpan(
                      children: [
                        TextSpan(text: responseNotification.data![index].message),
                      ]
                    ),)
                  ],
                ),
                const Icon(Icons.more_horiz),
              ],
            );
          },
          separatorBuilder: (context, index) => const SizedBox(),
          itemCount: responseNotification.data!.length,
        );
      },
      future: notification(),
    );
  }
}
