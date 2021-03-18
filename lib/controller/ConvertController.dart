import 'package:conversor_moeda_jpvp/currencyList.dart';
import 'package:mobx/mobx.dart';
part 'ConvertController.g.dart';

class ConvertCurrency = _ConvertCurrency with _$ConvertCurrency;

abstract class _ConvertCurrency with Store {
  @observable
  double brlResult = 0;

  @observable
  double usdResult = 0;

  @observable
  double usdtResult = 0;

  @observable
  double eurResult = 0;

  @observable
  double gbpResult = 0;

  @observable
  double cadResult = 0;

  @observable
  double audResult = 0;

  @observable
  double arsResult = 0;

  @observable
  double jpyResult = 0;

  @observable
  double cnyResult = 0;

  @observable
  double chfResult = 0;

  @observable
  double ilsResult = 0;

  @action
  void calculateBRL() => brlResult =
      double.parse((inputNumber * currency / brl).toStringAsFixed(2));

  @action
  void calculateUSD() => usdResult =
      double.parse((inputNumber * currency / usd).toStringAsFixed(2));

  @action
  void calculateUSDT() => usdtResult =
      double.parse((inputNumber * currency / usdt).toStringAsFixed(2));

  @action
  void calculateEUR() => eurResult =
      double.parse((inputNumber * currency / eur).toStringAsFixed(2));

  @action
  void calculateGBP() => gbpResult =
      double.parse((inputNumber * currency / gbp).toStringAsFixed(2));

  @action
  void calculateCAD() => cadResult =
      double.parse((inputNumber * currency / cad).toStringAsFixed(2));

  @action
  void calculateAUD() => audResult =
      double.parse((inputNumber * currency / aud).toStringAsFixed(2));

  @action
  void calculateARS() => arsResult =
      double.parse((inputNumber * currency / ars).toStringAsFixed(2));

  @action
  void calculateJPY() => jpyResult =
      double.parse((inputNumber * currency / jpy).toStringAsFixed(2));

  @action
  void calculateCNY() => cnyResult =
      double.parse((inputNumber * currency / cny).toStringAsFixed(2));

  @action
  void calculateCHF() => chfResult =
      double.parse((inputNumber * currency / chf).toStringAsFixed(2));

  @action
  void calculateILS() => ilsResult =
      double.parse((inputNumber * currency / ils).toStringAsFixed(2));
}
