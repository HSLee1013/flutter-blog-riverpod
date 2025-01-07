import 'package:flutter/material.dart';
import 'package:flutter_blog/data/model/reply.dart';
import 'package:flutter_blog/ui/pages/post/list_page/post_list_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/model/post.dart';
import '../../../../data/repository/post_repository.dart';
import '../../../../main.dart';

class PostDetailModel {
  Post post;
  List<Reply> replies;

  PostDetailModel.fromMap(Map<String, dynamic> map)
      : post = Post.fromMap(map),
        replies = (map["replies"] as List<dynamic>)
            .map((e) => Reply.fromMap(e))
            .toList();
}

// autoDispose 화면 파괴시 창고 같이 소멸
final postDetailProvider = NotifierProvider.family
    .autoDispose<PostDetailVM, PostDetailModel?, int>(() {
  return PostDetailVM();
});

class PostDetailVM extends AutoDisposeFamilyNotifier<PostDetailModel?, int> {
  final mContext = navigatorKey.currentContext!;
  PostRepository postRepository = const PostRepository();

  @override
  PostDetailModel? build(id) {
    init(id);
    return null;
  }

  Future<void> init(int id) async {
    Map<String, dynamic> responseBody = await postRepository.findById(id);

    if (!responseBody["success"]) {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        SnackBar(
            content: Text("게시글 상세보기 실패 : ${responseBody["errorMessage"]}")),
      );
      return;
    }

    state = PostDetailModel.fromMap(responseBody["response"]);
  }

  Future<void> delete(int id) async {
    Map<String, dynamic> responseBody = await postRepository.delete(id);
    if (!responseBody["success"]) {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        SnackBar(content: Text("게시글 삭제 실패 : ${responseBody["errorMessage"]}")),
      );
      return;
    }

    // PostlisvVM의 상태를 변경
    // ref.read(postListProvider.notifier).init(0);
    ref.read(postListProvider.notifier).remove(id);

    // EventBus Notifier -> 삭제했어!

    // 화면 파괴시 vm이 autoDispose 됨
    Navigator.pop(mContext);
  }
}
