import 'package:farm_sanctuary_delivery/graphql/graphql_config.dart';
import 'package:farm_sanctuary_delivery/services/sessionService.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();
  late final SessionService _session;
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
              mutation LoginDriver(\$input: loginDriverInput!) {
                loginDriver(input: \$input){

                }
              }
            """),
          variables: {
            "loginDriverInput": {
              "login": email,
              "password": password,
            }
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        var data = result.data?['loginDriver'];
        _session.login(data.fullname, email);
        return true;
      }
    } catch (error) {
      return false;
    }
  }
}
