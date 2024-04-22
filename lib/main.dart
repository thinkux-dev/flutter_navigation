import 'package:flutter/material.dart';
import 'package:flutter_navigation/error_page.dart';
import 'package:flutter_navigation/home_page.dart';
import 'package:flutter_navigation/login_page.dart';
import 'package:flutter_navigation/page_one.dart';
import 'package:flutter_navigation/page_one_details.dart';
import 'package:flutter_navigation/page_two.dart';
import 'package:flutter_navigation/profile_page.dart';
import 'package:go_router/go_router.dart';

bool loggedIn = true;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }

  final _router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      if(!loggedIn){
        return '/login';
      }
      return null;
    },
    // errorBuilder: (context, state) => const ErrorPage(),
    routes: [
      GoRoute(
        name: HomePage.routeName,
        path: '/',
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            name: ProfilePage.routeName,
            path: 'profile/:id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return ProfilePage(id: int.parse(id));
            }
          ),
        ]
      ),
      GoRoute(
        name: PageOne.routeName,
        path: '/pageone',
        builder: (context, state) => const PageOne(),
        routes: [
          GoRoute(
            name: PageOneDetails.routeName,
            path: 'pageone_details',
            builder: (context, state) => const PageOneDetails(),
          ),
        ]
      ),
      GoRoute(
        name: PageTwo.routeName,
        path: '/pagetwo',
        builder: (context, state) {
          // converting as String bcux by default "state.extra" returns an object
          final msg = state.extra! as String;
          return PageTwo(greetings: msg);
        }
      ),
      GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
      )
    ]
  );
}