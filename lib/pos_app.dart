import 'package:breez/bloc/app_blocs.dart';
import 'package:breez/bloc/user_profile/breez_user_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:breez/widgets/route.dart';
import 'package:breez/routes/shared/dev/dev.dart';
import 'package:breez/routes/shared/initial_walkthrough.dart';
import 'package:breez/routes/pos/home/pos_home_page.dart';
import 'package:breez/routes/pos/settings/pos_settings_page.dart';
import 'package:breez/routes/user/withdraw_funds/withdraw_funds_page.dart';
import 'package:breez/routes/pos/transactions/pos_transactions_page.dart';
import 'package:breez/theme_data.dart' as theme;

class PosApp extends StatelessWidget {
  final BreezUserModel user;
  final AppBlocs appBlocs;

  const PosApp({Key key, this.user, this.appBlocs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Breez POS',
      initialRoute: user.registered ? null : '/intro',
      home: PosHome(appBlocs.accountBloc, appBlocs.backupBloc),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/home':
            return new FadeInRoute(
              builder: (_) =>
                  new PosHome(appBlocs.accountBloc, appBlocs.backupBloc),
              settings: settings,
            );
          case '/intro':
            return new FadeInRoute(
              builder: (_) => new InitialWalkthroughPage(
                  appBlocs.userProfileBloc, appBlocs.backupBloc, true),
              settings: settings,
            );
          case '/transactions':
            return new FadeInRoute(
              builder: (_) => new PosTransactionsPage(),
              settings: settings,
            );
          case '/withdraw_funds':
            return new FadeInRoute(
              builder: (_) => new WithdrawFundsPage(),
              settings: settings,
            );
          case '/settings':
            return new FadeInRoute(
              builder: (_) => PosSettingsPage(),
              settings: settings,
            );
          case '/developers':
            return new FadeInRoute(
              builder: (_) => new DevView(),
              settings: settings,
            );
        }
        assert(false);
      },
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Color(0xFFffffff),
        dialogBackgroundColor: Colors.white,
        primaryColor: Color.fromRGBO(255, 255, 255, 1.0),
        textSelectionColor: Color.fromRGBO(255, 255, 255, 0.5),
        textSelectionHandleColor: Color(0xFF0085fb),
        dividerColor: Color(0x33ffffff),
        errorColor: theme.errorColor,
        canvasColor: Color.fromRGBO(5, 93, 235, 1.0),
        fontFamily: 'IBMPlexSansRegular',
        cardColor: Color.fromRGBO(5, 93, 235, 1.0),
      ),
    );
  }
}