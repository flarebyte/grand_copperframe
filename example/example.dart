import 'package:grand_copperframe/grand_copperframe.dart';
import 'package:validomix/validomix.dart';

class SimpleRule extends VxBaseRule<CopperframeMessage> {
  @override
  List<CopperframeMessage> validate(Map<String, String> options, String value) {
    final message = CopperframeMessage(
      label: 'Simple message',
      level: CopperframeMessageLevel.info,
      category: 'usage',
    );
    return [message];
  }
}

class SecondRule extends VxBaseRule<CopperframeMessage> {
  @override
  List<CopperframeMessage> validate(Map<String, String> options, String value) {
    final message = CopperframeMessage(
      label: 'Second message',
      level: CopperframeMessageLevel.info,
      category: 'usage',
    );
    return [message];
  }
}

void main() {
  final message = CopperframeMessage(
    label: 'This is an info message',
    level: CopperframeMessageLevel.info,
    category: 'usage',
  );
  final rule = CopperframeFieldRule(
    name: 'Length Check',
    options: {'min': '1', 'max': '255'},
    successMessages: [
      CopperframeMessage(
          label: 'Valid length',
          level: CopperframeMessageLevel.info,
          category: 'length')
    ],
    failureMessages: [
      CopperframeMessage(
          label: 'Invalid length',
          level: CopperframeMessageLevel.error,
          category: 'length')
    ],
  );

  final rule1 =
      CopperframeRule(rule: SimpleRule(), options: {'key113': 'value123'});
  final rule2 =
      CopperframeRule(rule: SecondRule(), options: {'key114': 'value125'});
  final composer = CopperframeRuleComposer([rule1, rule2]);
  composer.validate('some text');
}
