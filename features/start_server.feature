Feature: Start Server
  Scenario: With no conflicting port, start a random port server
    Given I have a server with the default configuration
      And the server will start on the random port "12345"
    When I start the server
    Then the server should have started on port "12345", interface "127.0.0.1"

  Scenario: With a conflicting port, start a random port server
    Given I have a server with the default configuration
      And the server will start on the random ports "12345,23456"
      And I have an existing service running on port "12345"
    When I start the server
    Then the server should have started on port "23456", interface "127.0.0.1"

  Scenario: Specify a port for starting the server
    Given I have a server with the configuration:
      | port | 12345 |
    When I start the server
    Then the server should have started on port "12345", interface "127.0.0.1"

  Scenario: Specify an adapter and port for starting
    Given I have a server with the configuration:
      | port | 12345 |
      | interface | 0.0.0.0 |
    When I start the server
    Then the server should have started on port "12345", interface "127.0.0.1"

