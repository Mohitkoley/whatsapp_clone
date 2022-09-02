// ignore_for_file: constant_identifier_names
enum MessageEnum {
  text("text"),
  image("image"),
  audio("audio"),
  video("video"),
  gif("gif");

  //Converting the enum to string
  const MessageEnum(this.type);
  final String type;
}

extension ConvertMessage on String {
  //Converting Firebase ("value") to enum value
  MessageEnum toEnum() {
    switch (this) {
      case "audio":
        return MessageEnum.audio;
      case "image":
        return MessageEnum.image;
      case "text":
        return MessageEnum.text;
      case "video":
        return MessageEnum.video;
      case "gif":
        return MessageEnum.gif;
      default:
        return MessageEnum.text;
    }
  }
}
