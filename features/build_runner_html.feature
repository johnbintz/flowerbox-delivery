Feature: Build Runner HTML
  Scenario: All JS files
    Given I have the file "template.erb" with the content:
      """
      <html>
        <%= resource_tags %>
      </html>
      """
    When I instantiate a template renderer with the template "template.erb" and the files:
      | src/source.js |
      | spec/spec.js |
    And I render the template
    Then I should have script tags for the following files in the template:
      | src/source.js |
      | spec/spec.js |

