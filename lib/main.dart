import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hava_havai_hiring_challenge/screens/catalogue_screen.dart';

void main(){
  runApp(Home());
}
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return  ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.pink[50],
          ),
        ),
        home: CatalogueScreen()
      ),
    );
  }
}