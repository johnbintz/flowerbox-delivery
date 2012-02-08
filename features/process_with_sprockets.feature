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

  Scenario: Other File Sources
    Given I have the file "dir/third.js.coffee" with the content:
      """
      #= require other
      for file in [ 'files' ]
        alert(file)
      """
      And I have the file "dir/fourth.jst.ejs" with the content:
        """
        <template><%= data %></template>
        """
      And I have the file "dir/five.css.scss" with the content:
        """
        @mixin cat {
          background: green;
        }
        h1 { @include cat }
        """
    When I instantiate a Sprockets handler with the following asset directories:
      | dir |
      And I work with the Sprockets asset "third"
      And I work with the Sprockets asset "fourth"
      And I work with the Sprockets asset "five"
    Then the handler should have the following files in order:
      | dir/other.js |
      | <%= temp_path_for("dir/third.js.coffee") %> |
      | <%= temp_path_for("dir/fourth.jst.ejs") %> |
      | <%= temp_path_for("dir/five.css.scss") %> |
      And there should be a temp file for the local path "dir/third.js.coffee"
      And there should be a temp file for the local path "dir/fourth.jst.ejs"
      And there should be a temp file for the local path "dir/five.css.scss"

