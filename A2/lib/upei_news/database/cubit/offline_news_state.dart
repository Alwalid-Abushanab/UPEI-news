part of 'offline_news_cubit.dart';


enum NewsStatus {loading, loaded, failure}

class OfflineNewsState extends Equatable {

  final List<NewsItem> item;
  final NewsStatus status;

  OfflineNewsState({
    this.status = NewsStatus.loading,
    this.item = const<NewsItem> []
  });

  ///generate a new HighScore State from this
  OfflineNewsState copyWith( {
    NewsStatus? status,
    List<NewsItem>? item,
  })
  {
    return OfflineNewsState(
        status: status ?? this.status,
        item : item ?? this.item
    );
  }

  @override
  List<Object> get props => [status, item];

  @override
  bool? get stringify => true;
}
