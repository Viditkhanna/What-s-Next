import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_next/bloc/app_bloc.dart';
import 'package:whats_next/resources/theme.dart';
import 'package:whats_next/ui/home_page/home_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBloc = AppBloc();
    return MultiProvider(
      providers: [ChangeNotifierProvider<AppBloc>.value(value: appBloc)],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme,
        home: HomePage(),
      ),
    );
  }
}
