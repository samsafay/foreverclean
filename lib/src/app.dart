import 'package:flutter/material.dart';
import './screens/settings_screen.dart';
import './screens/payment_screen.dart';
import './screens/add_payment_method_screen.dart';
import './screens/add_card_screen.dart';
import './screens/landing_screen.dart';
import './screens/sign_up_screen.dart';
import './screens/sign_in_screen.dart';
import './screens/map_screen.dart';
import 'blocs/login_provider.dart';
import 'blocs/barcode_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginProvider(
      child: new BarCodeProvider(
        child: new MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: new ThemeData(
            primarySwatch: Colors.amber,
          ),
          title: 'Forever Clean',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    switch (settings.name) {
      case '/AddCardScreen':
        return MaterialPageRoute(
          builder: (context) {
            return AddCardScreen();
          },
        );
        break;
      case '/AddPaymentMethodScreen':
        return MaterialPageRoute(
          builder: (context) {
            return AddPaymentMethodScreen();
          },
        );
        break;
      case '/PaymentScreen':
        return MaterialPageRoute(
          builder: (context) {
            return PaymentScreen();
          },
        );
        break;
      case '/SettingsScreen':
        return MaterialPageRoute(
          builder: (context) {
            return SettingsScreen();
          },
        );
        break;

      case '/MapScreen':
        return MaterialPageRoute(
          builder: (context) {
            return MapScreen();
          },
        );
        break;

      case '/SignUpScreen':
        return MaterialPageRoute(
          builder: (context) {
            return SignUpScreen();
          },
        );
        break;

      case '/SignInScreen':
        return MaterialPageRoute(
          builder: (context) {
            return SignInScreen();
          },
        );
        break;

      default:
        return MaterialPageRoute(
          builder: (context) {
            return LandingScreen();
          },
        );
    }
  }
}
