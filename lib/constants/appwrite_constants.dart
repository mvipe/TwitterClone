class AppwriteConstants{
  static const String databaseId='6434769cb54b899c10fc';
  static const String projectId='64346efd544be1c7d403';
  static const String endPoint='http://159.65.145.67/v1';

  static const String usersCollection="644937d56545fb3e91cd";
  static const String tweetsCollection="6456252d417f5f17eb29";

  static const String imagesBucket="6456601374d06423543d";

  static String imageUrl(String imageId)=>"http://159.65.145.67/v1/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin";
  
}