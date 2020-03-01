Feature: Users API Tests

  Scenario: Retrieve user by username
    Given request path is user1
    When GET method is called on webservice https://petstore.swagger.io/v2/user
    Then the status code is 200
    And response includes the following
      | username  | user1        |
      | firstName | first name 1 |
      | lastName  | last name 1  |

  Scenario: Update user detail
    Given request json is newUser.json
    When POST method is called on webservice https://petstore.swagger.io/v2/user
    Then the status code is 200
    Given request json is newUser2.json
    When PUT method is called on webservice https://petstore.swagger.io/v2/user/user1
    Then the status code is 200

  Scenario: Delete User
    Given request path is user1
    When DELETE method is called on webservice https://petstore.swagger.io/v2/user
    Then the status code is 200

  Scenario: Create a new user
    Given request json is newUser.json
    When POST method is called on webservice https://petstore.swagger.io/v2/user
    Then the status code is 200


  Scenario: User login by valid username and password
    Given request path is login?username=user1&password=XXXXXXXX
    When GET method is called on webservice https://petstore.swagger.io/v2/user
    Then the status code is 200

  Scenario: User logout
    Given request path is logout
    When GET method is called on webservice https://petstore.swagger.io/v2/user
    Then the status code is 200

  Scenario: Creating multiple users with list
    Given request json is newUserMultiple.json
    When POST method is called on webservice https://petstore.swagger.io/v2/user/createWithList
    Then the status code is 200

  Scenario: Creating multiple users with array
    Given request json is newUserMultiple.json
    When POST method is called on webservice https://petstore.swagger.io/v2/user/createWithArray
    Then the status code is 200
