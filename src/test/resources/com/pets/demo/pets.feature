Feature: Pets API Tests

  Scenario: Add a new Pet to the store
      Given request json is newPet.json
      When POST method is called on webservice https://petstore.swagger.io/v2/pet
      Then the status code is 200
      And response includes the following
        | status | available |
        | name | pepe |

  Scenario: Retrieve Pets by Invalid Id
    Given request path is 1001-Invalid
    When GET method is called on webservice https://petstore.swagger.io/v2/pet
    Then the status code is 404

  Scenario: Retrieve Pets by Status
    Given request parameters are
      | Key | Value |
      | status | available |
    When GET method is called on webservice https://petstore.swagger.io/v2/pet/findByStatus
    Then the status code is 200

  Scenario: Add a new Pet to the store and retrieve the Pet
        Given request json is newPet.json
        When POST method is called on webservice https://petstore.swagger.io/v2/pet
        Then the status code is 200
        And response includes the following
          | status | available |
          | name | pepe |
        Given request path is newly created id
        When GET method is called on webservice https://petstore.swagger.io/v2/pet
        Then the status code is 200
        And response includes the following
           | status | available |
           | name | pepe |
           | category.name | string |

  Scenario: Add a new Pet to the store and Update the Pet details
    Given request json is newPet.json
    When POST method is called on webservice https://petstore.swagger.io/v2/pet
    Then the status code is 200
    And response includes the following
      | status | available |
      | name | pepe |
    Given request json is newPet.json
    When PUT method is called on webservice https://petstore.swagger.io/v2/pet
    Then the status code is 200
    And response includes the following
      | status | available |
      | name | pepe |
      | category.name | string |

  Scenario: Add a new Pet to the store and Delete the Pet details
    Given request json is newPet.json
    When POST method is called on webservice https://petstore.swagger.io/v2/pet
    Then the status code is 200
    And response includes the following
      | status | available |
      | name | pepe |
    Given request path is newly created id
    When DELETE method is called on webservice https://petstore.swagger.io/v2/pet
    Then the status code is 200