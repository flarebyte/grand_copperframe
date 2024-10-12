import 'package:grand_copperframe/grand_copperframe.dart';

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
}
