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
    * def currentPage = response.metadata.currentPage
    * print 'Current Page:', currentPage
    And match response.metadata.nextPage == currentPage + 1

   # Scenario: Fetch the next page
      Given path '/products'
      And param limit = 10
      And param page = currentPage + 1
      When method GET
      Then status 200
      And print response
    And match response.metadata.prevPage == 1
