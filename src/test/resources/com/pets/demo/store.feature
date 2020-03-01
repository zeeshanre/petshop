Feature: Store API Tests

  Scenario: Order a new Pet in the store
    Given request json is newStore.json
    When POST method is called on webservice https://petstore.swagger.io/v2/store/order
    Then the status code is 200
    And response includes the following
      | status | placed |

  Scenario: Order a new Pet in the store and Retrieve purchase order by order id
    Given request json is newStore.json
    When POST method is called on webservice https://petstore.swagger.io/v2/store/order
    Then the status code is 200
    And response includes the following
      | status | placed |
    Given request path is newly created id
    When GET method is called on webservice https://petstore.swagger.io/v2/store/order
    Then the status code is 200
    And response includes the following
      | status | placed |

  Scenario: Order a new Pet in the store and Delete purchase order by order id
    Given request json is newStore.json
    When POST method is called on webservice https://petstore.swagger.io/v2/store/order
    Then the status code is 200
    And response includes the following
      | status | placed |
    Given request path is newly created id
    When DELETE method is called on webservice https://petstore.swagger.io/v2/store/order
    Then the status code is 200

  Scenario: Retrieve status of the pet inventory
    Given request json is newStore.json
    When GET method is called on webservice https://petstore.swagger.io/v2/store/inventory
    Then the status code is 200