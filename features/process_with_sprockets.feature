Feature: Process files with Sprockets
  Scenario: Simple Sprockets work
    Given I have the file "dir/file.js" with the content:
      """
      //= require other
      a file
      """
      And I have the file "dir/other.js" with the content:
      """
      another file
      """
    When I instantiate a Sprockets handler with the following asset directories:
      | dir |
      And I work with the Sprockets asset "file"
    Then the handler should have the following files in order:
      | dir/other.js |
      | dir/file.js |

