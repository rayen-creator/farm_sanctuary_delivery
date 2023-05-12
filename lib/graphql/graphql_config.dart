import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static HttpLink httpLink = HttpLink(
    "http://192.168.1.10:3000/graphql",
  );

  GraphQLClient clientToQuery() => GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      );
}
