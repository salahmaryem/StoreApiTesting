Feature: Creating and Updating a product with a specific header key

  Background:
    * url baseUrl
 #Normally here there should be a * configure headers = { 'Content-type': 'multipart/form-data' }, but it won't work in this case
    * configure headers = { 'Content-type': 'application/json' }
    * def requestBody = read('requests/updatingRequest.json')

    Scenario: Create a product
      Given path '/products'
      And request requestBody
      When method POST
      Then status 201
      And print response
      And match response.message == 'Success! product created'

      Scenario: Update a product by it's title
        Given path '/products/running-sneaker'
        And request requestBody
        When method PUT
        Then status 201
        And match response.message == 'Success! product updated'
