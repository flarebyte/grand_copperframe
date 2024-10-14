# grand\_copperframe

![Experimental](https://img.shields.io/badge/status-experimental-blue)

> The higher level data model for copperframe

The data model used by copperframe components

![Hero image for grand\_copperframe](doc/grand_copperframe.jpeg)

Highlights:

-   Create friendly user message
-   Create a skeleton for rules with friendly messages

A few examples:

Create a message:

```dart
final  message  =  CopperframeMessage(  label:  'This  is  an  info
message',  level:  CopperframeMessageLevel.info,  category:  'usage',  );
```

Create a rule:

```dart
final  rule  =  CopperframeFieldRule(  name:  'Length  Check',  options:
{'min':  '1',  'max':  '255'},  successMessages:  [  failureMessages:  [
message  ],  );
```

## Documentation and links

-   [Code Maintenance :wrench:](MAINTENANCE.md)
-   [Code Of Conduct](CODE_OF_CONDUCT.md)
-   [Contributing :busts\_in\_silhouette: :construction:](CONTRIBUTING.md)
-   [Architectural Decision Records :memo:](DECISIONS.md)
-   [Contributors
    :busts\_in\_silhouette:](https://github.com/flarebyte/grand_copperframe/graphs/contributors)
-   [Dependencies](https://github.com/flarebyte/grand_copperframe/network/dependencies)
-   [Glossary
    :book:](https://github.com/flarebyte/overview/blob/main/GLOSSARY.md)
-   [Software engineering principles
    :gem:](https://github.com/flarebyte/overview/blob/main/PRINCIPLES.md)
-   [Overview of Flarebyte.com ecosystem
    :factory:](https://github.com/flarebyte/overview)
-   [Dart dependencies](DEPENDENCIES.md)
-   [Usage](USAGE.md)
-   [Example](example/example.dart)

## Related

-   [form\_validator](https://pub.dev/packages/form_validator)
