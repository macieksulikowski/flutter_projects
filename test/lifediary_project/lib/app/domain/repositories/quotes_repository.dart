import 'package:lifediary_project/app/data/remote_data_sources/quotes_remote_data_source.dart';
import 'package:lifediary_project/app/domain/models/quotes_model.dart';

class QuotesRepository {
  QuotesRepository(this.quotesRemoteDataSource);

  final QuotesRemoteDioDataSource quotesRemoteDataSource;

  Future<List<QuotesModel>> getQuotesModel() async {
    final json = await quotesRemoteDataSource.getQuotes();
    if (json == null) {
      return [];
    }

    return json.map((item) => QuotesModel.fromJson(item)).toList();
  }
}
