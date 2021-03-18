import 'package:mobx/mobx.dart';
part 'VisibilityController.g.dart';

class ShowContainer = _ShowContainer with _$ShowContainer;

abstract class _ShowContainer with Store {
  @observable
  bool showBRL = false;

  @observable
  bool showUSD = true;

  @observable
  bool showUSDT = true;

  @observable
  bool showEUR = true;

  @observable
  bool showGBP = true;

  @observable
  bool showCAD = true;

  @observable
  bool showAUD = true;

  @observable
  bool showARS = true;

  @observable
  bool showJPY = true;

  @observable
  bool showCNY = true;

  @observable
  bool showCHF = true;

  @observable
  bool showILS = true;

  @action
  void showBRLfunc() {
    showBRL = false;
    showUSD = true;
    showUSDT = true;
    showEUR = true;
    showGBP = true;
    showCAD = true;
    showAUD = true;
    showARS = true;
    showJPY = true;
    showCNY = true;
    showCHF = true;
    showILS = true;
  }

  @action
  void showUSDfunc() {
    showBRL = true;
    showUSD = false;
    showUSDT = true;
    showEUR = true;
    showGBP = true;
    showCAD = true;
    showAUD = true;
    showARS = true;
    showJPY = true;
    showCNY = true;
    showCHF = true;
    showILS = true;
  }

  @action
  void showUSDTfunc() {
    showBRL = true;
    showUSD = true;
    showUSDT = false;
    showEUR = true;
    showGBP = true;
    showCAD = true;
    showAUD = true;
    showARS = true;
    showJPY = true;
    showCNY = true;
    showCHF = true;
    showILS = true;
  }

  @action
  void showEURfunc() {
    showBRL = true;
    showUSD = true;
    showUSDT = true;
    showEUR = false;
    showGBP = true;
    showCAD = true;
    showAUD = true;
    showARS = true;
    showJPY = true;
    showCNY = true;
    showCHF = true;
    showILS = true;
  }

  @action
  void showGBPfunc() {
    showBRL = true;
    showUSD = true;
    showUSDT = true;
    showEUR = true;
    showGBP = false;
    showCAD = true;
    showAUD = true;
    showARS = true;
    showJPY = true;
    showCNY = true;
    showCHF = true;
    showILS = true;
  }

  @action
  void showCADfunc() {
    showBRL = true;
    showUSD = true;
    showUSDT = true;
    showEUR = true;
    showGBP = true;
    showCAD = false;
    showAUD = true;
    showARS = true;
    showJPY = true;
    showCNY = true;
    showCHF = true;
    showILS = true;
  }

  @action
  void showAUDfunc() {
    showBRL = true;
    showUSD = true;
    showUSDT = true;
    showEUR = true;
    showGBP = true;
    showCAD = true;
    showAUD = false;
    showARS = true;
    showJPY = true;
    showCNY = true;
    showCHF = true;
    showILS = true;
  }

  @action
  void showARSfunc() {
    showBRL = true;
    showUSD = true;
    showUSDT = true;
    showEUR = true;
    showGBP = true;
    showCAD = true;
    showAUD = true;
    showARS = false;
    showJPY = true;
    showCNY = true;
    showCHF = true;
    showILS = true;
  }

  @action
  void showJPYfunc() {
    showBRL = true;
    showUSD = true;
    showUSDT = true;
    showEUR = true;
    showGBP = true;
    showCAD = true;
    showAUD = true;
    showARS = true;
    showJPY = false;
    showCNY = true;
    showCHF = true;
    showILS = true;
  }

  @action
  void showCNYfunc() {
    showBRL = true;
    showUSD = true;
    showUSDT = true;
    showEUR = true;
    showGBP = true;
    showCAD = true;
    showAUD = true;
    showARS = true;
    showJPY = true;
    showCNY = false;
    showCHF = true;
    showILS = true;
  }

  @action
  void showCHFfunc() {
    showBRL = true;
    showUSD = true;
    showUSDT = true;
    showEUR = true;
    showGBP = true;
    showCAD = true;
    showAUD = true;
    showARS = true;
    showJPY = true;
    showCNY = true;
    showCHF = false;
    showILS = true;
  }

  @action
  void showILSfunc() {
    showBRL = true;
    showUSD = true;
    showUSDT = true;
    showEUR = true;
    showGBP = true;
    showCAD = true;
    showAUD = true;
    showARS = true;
    showJPY = true;
    showCNY = true;
    showCHF = true;
    showILS = false;
  }
}
