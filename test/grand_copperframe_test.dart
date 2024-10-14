import 'package:grand_copperframe/grand_copperframe.dart';
import 'package:test/test.dart';
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
  group('CopperframeMessage', () {
    test('toJson and fromJson serialization/deserialization', () {
      final message = CopperframeMessage(
        label: 'This is an info message',
        level: CopperframeMessageLevel.info,
        category: 'usage',
      );

      expect(message.toString(),
          equals('CopperframeMessageLevel.info This is an info message'));

      final json = message.toJson();
      final deserializedMessage = CopperframeMessage.fromJson(json);

      expect(deserializedMessage.label, equals(message.label));
      expect(deserializedMessage.level, equals(message.level));
      expect(deserializedMessage.category, equals(message.category));
    });

    test('fromJson with missing fields should throw FormatException', () {
      final json = {
        'label': 'This is an error message',
        'level': 'error',
      };

      expect(() => CopperframeMessage.fromJson(json), throwsFormatException);
    });

    test('fromJson with invalid level should throw ArgumentError', () {
      final json = {
        'label': 'This is an invalid level message',
        'level': 'critical',
        'category': 'length',
      };

      expect(() => CopperframeMessage.fromJson(json), throwsArgumentError);
    });

    test('get messages should return messages with or without flags', () {
      final blueMessage = CopperframeMessage(
        label: 'This is a blue message',
        level: CopperframeMessageLevel.info,
        category: 'usage',
        flags: 'blue',
      );
      final redMessage = CopperframeMessage(
        label: 'This is an red message',
        level: CopperframeMessageLevel.info,
        category: 'usage',
        flags: 'red',
      );

      final yellowMessage = CopperframeMessage(
        label: 'This is a yellow message',
        level: CopperframeMessageLevel.info,
        category: 'usage',
      );

      final actualsWithFlag = CopperframeMessage.getMessagesWithFlag(
          [yellowMessage, blueMessage, redMessage], 'blue');
      expect(actualsWithFlag.length, 1);
      expect(actualsWithFlag[0], blueMessage);

      final actualsWithoutFlag = CopperframeMessage.getMessagesWithNoFlag(
          [yellowMessage, blueMessage, redMessage]);
      expect(actualsWithoutFlag.length, 1);
      expect(actualsWithoutFlag[0], yellowMessage);
    });
  });

  group('FieldRule', () {
    test('toJson and fromJson serialization/deserialization', () {
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

      final json = rule.toJson();
      final deserializedRule = CopperframeFieldRule.fromJson(json);

      expect(deserializedRule.name, equals(rule.name));
      expect(deserializedRule.options, equals(rule.options));
      expect(deserializedRule.successMessages.length, equals(1));
      expect(deserializedRule.failureMessages.length, equals(1));
    });

    test('fromJson with missing fields should throw FormatException', () {
      final json = {
        'name': 'Required Field',
        'options': {'required': 'true'},
        'successMessages': []
      };

      expect(() => CopperframeFieldRule.fromJson(json), throwsFormatException);
    });
  });

  group('FieldEvent', () {
    test('toJson and fromJson serialization/deserialization', () {
      final rule = CopperframeFieldRule(
        name: 'Required Check',
        options: {'required': 'true'},
        successMessages: [
          CopperframeMessage(
              label: 'Field is required',
              level: CopperframeMessageLevel.info,
              category: 'validation')
        ],
        failureMessages: [
          CopperframeMessage(
              label: 'Field is missing',
              level: CopperframeMessageLevel.error,
              category: 'validation')
        ],
      );

      final event = CopperframeFieldEvent(
        name: 'OnBlur',
        rules: [rule],
      );

      final json = event.toJson();
      final deserializedEvent = CopperframeFieldEvent.fromJson(json);

      expect(deserializedEvent.name, equals(event.name));
      expect(deserializedEvent.rules.length, equals(1));
    });

    test('fromJson with missing fields should throw FormatException', () {
      final json = {
        'name': 'OnChange',
      };

      expect(() => CopperframeFieldEvent.fromJson(json), throwsFormatException);
    });
  });

  group('FieldWidget', () {
    test('toJson and fromJson serialization/deserialization', () {
      final rule = CopperframeFieldRule(
        name: 'MaxLength Check',
        options: {'max': '100'},
        successMessages: [
          CopperframeMessage(
              label: 'Valid length',
              level: CopperframeMessageLevel.info,
              category: 'validation')
        ],
        failureMessages: [
          CopperframeMessage(
              label: 'Too long',
              level: CopperframeMessageLevel.error,
              category: 'validation')
        ],
      );

      final event = CopperframeFieldEvent(
        name: 'OnChange',
        rules: [rule],
      );

      final widget = CopperframeFieldWidget(
        name: 'Username',
        kind: 'text',
        options: {'placeholder': 'Enter your username'},
        events: [event],
      );

      final json = widget.toJson();
      final deserializedWidget = CopperframeFieldWidget.fromJson(json);

      expect(deserializedWidget.name, equals(widget.name));
      expect(deserializedWidget.kind, equals(widget.kind));
      expect(deserializedWidget.options, equals(widget.options));
      expect(deserializedWidget.events.length, equals(1));
    });

    test('fromJson with missing fields should throw FormatException', () {
      final json = {
        'name': 'Email',
        'kind': 'text',
        'options': {'placeholder': 'Enter your email'}
      };

      expect(
          () => CopperframeFieldWidget.fromJson(json), throwsFormatException);
    });
  });

  group('CopperframeMessageProducer', () {
    test('should return a constant message', () {
      final blueMessage = CopperframeMessage(
        label: 'This is a blue message',
        level: CopperframeMessageLevel.info,
        category: 'usage',
        flags: 'blue',
      );
      final producer = CopperframeMessageProducer(blueMessage);
      expect(producer.produce({}, 'anything'), equals(blueMessage));
    });

    test('should create multiple producers from a list of messages', () {
      final blueMessage = CopperframeMessage(
        label: 'This is a blue message',
        level: CopperframeMessageLevel.info,
        category: 'usage',
        flags: 'blue',
      );

      final redMessage = CopperframeMessage(
        label: 'This is an red message',
        level: CopperframeMessageLevel.info,
        category: 'usage',
        flags: 'red',
      );
      final producers =
          CopperframeMessageProducer.createProducers([blueMessage, redMessage]);
      expect(producers.length, 2);
    });
  });

  group('CopperframeRule', () {
    test('', () {
      final rule =
          CopperframeRule(rule: SimpleRule(), options: {'key113': 'value123'});
      final actual = rule.validate('some text');
      expect(actual.length, 1);
      expect(actual[0].label, 'Simple message');
    });
  });

  group('CopperframeRuleComposer', () {
    test('', () {
      final rule =
          CopperframeRule(rule: SimpleRule(), options: {'key113': 'value123'});
      final rule2 =
          CopperframeRule(rule: SecondRule(), options: {'key114': 'value125'});
      final composer = CopperframeRuleComposer([rule, rule2]);
      final actual = composer.validate('some text');
      expect(actual.length, 2);
      expect(actual[0].label, 'Simple message');
      expect(actual[1].label, 'Second message');
    });
  });
}
