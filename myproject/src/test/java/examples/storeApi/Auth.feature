Feature: Test the registration functionality and the login functionality to get the Token

  Background:
    * url baseUrl
    * configure headers = { 'Content-type': 'application/json; charset=UTF-8' }
    * def requestBody = read('requests/authLoginRequest.json')
    * def registerRequestBody = read('requests/registerRequest.json')

  Scenario: Login and capture access token
    Given path '/auth/login'
    And request requestBody
    When method POST
    Then status 200
    And match response.data.access_token == '#present'
    And match response.data.refresh_token == '#present'
    # Capture the access token
    And def accessToken = response.data.access_token
    And print accessToken
    # Create a file to put the token in
    And karate.write(accessToken, 'access-token.txt')

    Scenario: Register a new user with data to capture token
      Given path '/auth/register'
      And request registerRequestBody
      When method POST
      Then status 201
      And match response.message == "User created"
      And match response.data.access_token == '#present'
      And match response.data.refresh_token == '#present'