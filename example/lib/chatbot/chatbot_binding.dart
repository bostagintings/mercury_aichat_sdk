import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mercury_aichat_sdk/mercury_aichat_sdk.dart';

import '../core/dio_client.dart';

class ChatbotBinding extends Bindings {
  @override
  void dependencies() {
    /// In the chatbot package, the DataSource, Repo, UseCase, and Controller are created separately with a dependency chain (Controller -> UseCase -> Repo -> DataSource).
    /// Dependency injection can be done here. And the Base URL and ChatBotId can also be set here
    Get.lazyPut<ChatbotRepo>(
      () => ChatbotRepo(
        dioClient: DioClient(
            options: BaseOptions(
          baseUrl: 'https://staging-mercury-api-bwjdcapn3a-as.a.run.app',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 30),
        )),
        chatBotId: '9f1196141ce84950ad05ced4b6db4d9e',
        dataSource: ChatLocalDataSource(),
      ),
    );
    Get.lazyPut(() => CreateConversationUsecase(Get.find()));
    Get.lazyPut(() => GetMessagesUsecase(Get.find()));
    Get.lazyPut(() => SendMessageUsecase(Get.find()));

    Get.lazyPut<ChatbotController>(
      () => ChatbotController(
        conversationUsecase: Get.find(),
        getMessagesUsecase: Get.find(),
        sendMessageUsecase: Get.find(),
      ),
    );
  }
}
