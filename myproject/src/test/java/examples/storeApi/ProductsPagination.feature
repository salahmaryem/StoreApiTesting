Feature: Products pagination

  Background:
    * url baseUrl
    * configure headers = { 'Content-type': 'application/json; charset=UTF-8' }
    * def totalProducts = 0
    * def currentPage = 0

  Scenario: Verify current page and total products
    Given path '/products'
    And param limit = 10
    And param page = 1
    When method GET
    Then status 200
    * def response = response
    * def metadata = response.metadata
    * def currentPage = metadata.currentPage
    * def totalProducts = metadata.totalProducts
    * print 'Current Page:', currentPage
    * print 'Total Products:', totalProducts

   # Scenario: Fetch the next page
      Given path '/products'
      And param limit = 10
      And param page = currentPage + 1
      When method GET
      Then status 200
      And print response
    And match response.metadata.prevPage == 1
