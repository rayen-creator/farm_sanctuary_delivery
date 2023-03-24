import 'dart:ffi';

import 'package:farm_sanctuary_delivery/graphql/graphql_config.dart';
import 'package:farm_sanctuary_delivery/models/LoginDriverResponse.dart';
import 'package:farm_sanctuary_delivery/services/sessionService.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();
  late final SessionService _session;

  GraphQLService() {
    _session = SessionService();
    _session.init();
  }

  Future<bool> login({
    required String login,
    required String password,
  }) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql("""
              mutation LoginDriver(\$input: loginDriverInput!) {
                loginDriver(input: \$input) {
                      userfound
                      passwordIsValid
                      message
                      agent {
                        fullName
                      }
                  }
                }
            """),
          variables: {
            "input": {
              "login": login,
              "password": password,
            }
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        print("response" + result.data.toString());

        // final loginDriverResponse = LoginDriverResponse.fromJson(result.data?['loginDriver']);
        var passwordIsValid = result.data?['loginDriver']['passwordIsValid'] as bool;
        print("passwordIsValid" + passwordIsValid.toString());
        if (!passwordIsValid) {
          return false;
        }
        var userfound = result.data?['loginDriver']['userfound'] as bool;
        print("userfound" + userfound.toString());
        if (!userfound) {
          return false;
        }
        var agent = result.data?['loginDriver']['agent'];
        print("agent " + agent.toString());
        if (agent != null) {
          var agentfullName = agent['fullName'];

          print('passwordIsValid : ' + passwordIsValid.toString());
          print('userfound : ' + userfound.toString());
          print('agentfullName : ' + agentfullName.toString());
          _session.signin(agentfullName, login);
          return true;
        } else {
          return false;
        }
      }
    } catch (error) {
      print(" error : " + error.toString());
      return false;
    }
  }
}
