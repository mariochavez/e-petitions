Feature: As Charlie
  In order to have an issue discussed in parliament
  I want to be able to create a petition and verify my email address.

@search
Scenario: Charlie has to search for a petition before creating one
  Given a petition "Rioters should loose benefits"
  Given I am on the home page
  When I follow "Start a new petition"
  Then I should be asked to search for a new petition
  When I check for similar petitions
  Then I should see a list of existing petitions I can sign
  When I choose to create a petition anyway
  Then I should be on the new petition page
  And I should see my search query already filled in as the title of the petition

@search
Scenario: Charlie cannot craft an xss attack when searching for petitions
  Given I am on the home page
  When I follow "Start a new petition"
  Then I fill in "q" with "'onmouseover='alert(1)'"
  When I press "Check for similar petitions"
  Then the markup should be valid

Scenario: Charlie creates a petition
  Given I start a new petition
  And I fill in the petition details
  And I press "Next"
  And I fill in my details
  And I press "Next"
  When I press "Next"
  Then the markup should be valid
  And I am asked to review my email address
  When I press "Submit"
  Then a petition should exist with title: "The wombats of wimbledon rock.", state: "pending"
  And there should be a "pending" signature with email "womboid@wimbledon.com" and name "Womboid Wibbledon"
  And "Womboid Wibbledon" wants to be notified about the petition's progress
  And "womboid@wimbledon.com" should be emailed a link for gathering support from sponsors

Scenario: First person sponsors a petition
  When I have created an e-petition and told people to sponsor it
  And a sponsor supports my e-petition
  Then the e-petition should be validated
  And the e-petition creator signature should be validated

Scenario: Charlie creates a petition with invalid postcode SW14 9RQ
  Given I start a new petition
  And I fill in the petition details
  And I press "Next"
  And I fill in my details with postcode "SW14 9RQ"
  And I press "Next"
  Then I should not see the text "Your constituency is"

@javascript
Scenario: Charlie tries to submit an invalid petition
  Given I am on the new petition page

  Then I should see a fieldset called "Petition Details"

  When I press "Next"
  Then I should see "Title must be completed"
  And I should see "Action must be completed"
  And I should see "Description must be completed"

  When I am allowed to make the petition title too long
  When I fill in "Title" with "012345678911234567892123456789312345678941234567895123456789012345678911234567892123456789312345678941234567895123456789012345678911234567892123456789Blah"
  And I fill in "Action" with "This text is longer than 200 characters. 012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
  And I fill in "Description" with "This text is longer than 1000 characters. 012345678911234567892123456789312345678941234567895123456789012345678911234567892123456789312345678941234567895123456789012345678911234567892123456789312345678941234567895123456789012345678911234567892123456789312345678941234567895123456789012345678911234567892123456789312345678941234567895123456789012345678911234567892123456789312345678941234567895123456789012345678911234567892123456789312345678941234567895123456789012345678911234567892123456789312345678941234567895123456789012345678911234567892123456789312345678941234567895123456789012345678911234567892123456789312345678941234567895123456789012345678911234567892123456789312345678941234567895123456789012345678911234567892123456789312345678941234567895123456789012345678911234567892123456789312345678941234567895123456789012345678911234567892123456789312345678941234567895123456789012345678911234567892123456789312345678941234567895123456789012345678911234567892123456789312345678941234567895123456789"
  And I press "Next"

  Then I should see "Title is too long."
  And I should see "Description is too long."
  And I should see "Action is too long."

  When I fill in "Title" with "The wombats of wimbledon rock."
  And I fill in "Action" with "Give half of Wimbledon rock to wombats!"
  And I fill in "Description" with "The racial tensions between the wombles and the wombats are heating up.  Racial attacks are a regular occurrence and the death count is already in 5 figures.  The only resolution to this crisis is to give half of Wimbledon common to the Wombats and to recognise them as their own independent state."
  And I press "Next"

  Then I should see a fieldset called "Your Details"

  When I press "Next"
  Then I should see "Name must be completed"
  And I should see "Email must be completed"
  And I should see "You must be a British citizen"
  And I should see "Postcode must be completed"

  When I fill in my details

  And I press "Next"
  Then I should see a fieldset called "Review Petition"

  And I should see "The wombats of wimbledon rock."
  And I should see "The racial tensions between the wombles and the wombats are heating up.  Racial attacks are a regular occurrence and the death count is already in 5 figures.  The only resolution to this crisis is to give half of Wimbledon common to the Wombats and to recognise them as their own independent state."

  And I press "Back"
  And I fill in "Name" with "Mr. Wibbledon"
  And I press "Next"
  And I press "Next"

  Then I should see a fieldset called "Make sure this is right"

  When I fill in "Email" with ""
  And I press "Submit"
  Then I should see "Email must be completed"
  When I fill in "Email" with "womboid@wimbledon.com"
  And I press "Submit"

  Then a petition should exist with title: "The wombats of wimbledon rock.", state: "pending"
  Then there should be a "pending" signature with email "womboid@wimbledon.com" and name "Mr. Wibbledon"
