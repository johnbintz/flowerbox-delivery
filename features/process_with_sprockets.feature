Feature: Process files with Sprockets
  Background:
    Given I have the file "dir/file.js" with the content:
      """
      //= require other
      a file
      """
      And I have the file "dir/other.js" with the content:
      """
      another file
      """

  Scenario: Simple Sprockets work
    When I instantiate a Sprockets handler with the following asset directories:
      | dir |
      And I work with the Sprockets asset "file"
    Then the handler should have the following files in order:
      | dir/other.js |
      | dir/file.js |

  Scenario: Require the file twice
    Given I have the file "dir/third.js" with the content:
      """
      //= require other
      third file
      """
    When I instantiate a Sprockets handler with the following asset directories:
      | dir |
      And I work with the Sprockets asset "file"
      And I work with the Sprockets asset "third"
    Then the handler should have the following files in order:
      | dir/other.js |
      | dir/file.js |
      | dir/third.js |

