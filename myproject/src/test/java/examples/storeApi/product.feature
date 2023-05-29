Feature: Product Management
  Background:
    * url baseUrl
    * configure headers = { 'Content-type': 'application/json; charset=UTF-8' }

  Scenario: Get all products
    Given path '/products'
    When method get
    Then status 200
    And print response

  Scenario Outline: Get a product by Title
    Given path '/products'
    And param title = "<title>"
    When method GET
    Then status 200
    And print response

    Examples:
      | title              |
      | running-sneaker    |
      | high quality men distress skinny blue jeans   |
      | cotton o neck mens clothing t shirts |

  Scenario Outline: Get products with different page values
    Given path '/products'
    And param limit = 10
    And param page = <page>
    When method get
    Then status 200
    And match response.metadata.totalProducts != 0

    Examples:
      | page |
      | 1    |
      | 2    |
      | 3    |

  Scenario: Delete a product
    Given path '/products/running-sneaker'
    When method delete
    Then status 200
    And print response
    And match response.status == 202
    And match response.message == "Success! Product deleted"