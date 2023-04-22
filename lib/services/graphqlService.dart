import 'dart:ffi';

import 'package:farm_sanctuary_delivery/graphql/graphql_config.dart';
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

  Future<bool> SendLocation(String longtitue, String latitude) async {
    try {
      var id = _session.id;
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql("""
              mutation UpdateLocation(\$input: AgentLocationInput!) {
                updateLocation(input: \$input) {
                      id
                      login
                      fullName
                      longitude
                      latitude
                  }
                }
            """),
          variables: {
            "input": {
              "id": id,
              "longitude": longtitue,
              "latitude": latitude,
            }
          },
        ),
      );
      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        var longtitude = result.data?['updateLocation']['longitude'];
        var latitude = result.data?['updateLocation']['latitude'];
        print("longtitude" + longtitude.toString());
        print("latitude" + latitude.toString());
      }
      return true;
    } catch (error) {
      return false;
    }
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
                        id
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
        if (agent != null) {
          var agentfullName = agent['fullName'];
          var agentId = agent['id'];
          print('passwordIsValid : ' + passwordIsValid.toString());
          print('userfound : ' + userfound.toString());
          print('agentfullName : ' + agentfullName.toString());
          _session.signin(agentId, agentfullName);
          print("id" + _session.id.toString());

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
