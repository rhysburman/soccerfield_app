import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/screens/home_screen.dart';
import 'blocs/application_bloc.dart';
import 'package:form_making_practice/services/data_service.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DataService.init();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
   return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: MaterialApp(
        title: 'Soccer Ratings App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity:  VisualDensity.adaptivePlatformDensity
        ),
        home: HomeScreen(),
      ),
    );
  }
}
