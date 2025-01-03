import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/model/post.dart';

class PostDetailModel {
  Post? post;
}

final PostDetailProvider = NotifierProvider<PostDetailVM, PostDetailModel?>(() {
  return PostDetailVM();
});

class PostDetailVM extends Notifier<PostDetailModel?> {
  @override
  PostDetailModel? build() {
    init();
    return null;
  }

  Future<void> init() async {}
}
