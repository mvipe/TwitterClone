import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/core/providers.dart';
import 'package:twitter_clone/models/user_model.dart';

final UserAPIProvider = Provider((ref) {
   final db=ref.watch(appwriteDatabaseProvider);

  return userAPI(db: db);
});

abstract class IUserAPI {
  FutureEitherVoid saveUserData(UserModel userModel);
}

class userAPI implements IUserAPI {
  final Databases _db;

  userAPI({required Databases db}) : _db = db;
  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
       await _db.createDocument(databaseId: AppwriteConstants.databaseId, collectionId: AppwriteConstants.usersCollection, documentId: ID.unique(), data: userModel.toMap());
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message??'some unexcepted error occured' , st));
    } catch (e, st) {
       return left(Failure(e.toString() , st));
    }
  }
}
