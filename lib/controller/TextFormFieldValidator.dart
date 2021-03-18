import 'package:mobx/mobx.dart';
part 'TextFormFieldValidator.g.dart';

class TextValidator = _TextValidator with _$TextValidator;

abstract class _TextValidator with Store {
  // _TextValidator() {
  //   autorun((_) {
  //     print(isTextdValid);
  //     print(setTextValue);
  //   });
  // }

  @observable
  dynamic inputValorController = '';

  @action
  void setTextValue(value) => inputValorController = value;

  @computed
  // ignore: unrelated_type_equality_checks
  bool get isTextdValid => inputValorController != '';
}
