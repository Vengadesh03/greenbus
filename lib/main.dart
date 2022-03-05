import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/viewmodels/general_provider.dart';
import 'router.dart' as CustomRouter;
import 'locator.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<GeneralProvider>()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          title: 'Green Bus',
          theme: ThemeData(),
          onGenerateRoute: CustomRouter.Router.generateRoute),
      //  MaterialApp(
      //   title: 'Flutter Demo',
      //   theme: ThemeData(
      //     visualDensity: VisualDensity.adaptivePlatformDensity,
      //   ),
      //   home: Login(),
    );
  }
}
