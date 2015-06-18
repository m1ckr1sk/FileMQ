Feature: Publish message to a topic
  In order to communicate with many other endpoints
  I need to be able to publish a message to a topic

  Scenario: Publish a message to a topic
    Given that the file MQ is initialised
    And a topic is created
    And a client is listening to the topic
    When I publish a message to the topic
    Then the client must receive the message