// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TextFormFieldValidator.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TextValidator on _TextValidator, Store {
  Computed<bool> _$isTextdValidComputed;

  @override
  bool get isTextdValid =>
      (_$isTextdValidComputed ??= Computed<bool>(() => super.isTextdValid,
              name: '_TextValidator.isTextdValid'))
          .value;

  final _$inputValorControllerAtom =
      Atom(name: '_TextValidator.inputValorController');

  @override
  dynamic get inputValorController {
    _$inputValorControllerAtom.reportRead();
    return super.inputValorController;
  }

  @override
  set inputValorController(dynamic value) {
    _$inputValorControllerAtom.reportWrite(value, super.inputValorController,
        () {
      super.inputValorController = value;
    });
  }

  final _$_TextValidatorActionController =
      ActionController(name: '_TextValidator');

  @override
  void setTextValue(dynamic value) {
    final _$actionInfo = _$_TextValidatorActionController.startAction(
        name: '_TextValidator.setTextValue');
    try {
      return super.setTextValue(value);
    } finally {
      _$_TextValidatorActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
inputValorController: ${inputValorController},
isTextdValid: ${isTextdValid}
    ''';
  }
}
