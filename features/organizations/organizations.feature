Feature: Organizations
  So that I can learn some secret stuff
  As a user from a private company
  I want to learn in the context of my own group

  Background:
    Given there are users from many orgs
    And there are courses from many orgs

  Scenario: Rando users can't see proprietary content
    Given I am some rando from the internet
    When I visit the courses page
    Then I don't see the courses from any orgs
    But I see courses without any org

  Scenario: Org users can see their own content
    Given I am a user from an organization
    When I visit the courses page
    Then I see the courses from my org
    And I don't see the courses from other orgs
    But I see courses without any org

  Scenario: Randos can't see org users
    Given I am some rando from the internet
    When I visit the user page
    Then I see other randos from the internet
    And I don't see users from any orgs

  Scenario: Org users can only see other org users
    Given I am a user from an organization
    When I visit the user page
    Then I see other users from my org
    And I don't see users from other orgs
    And I don't see randos from the internet

  Scenario: Randos cannot complete skills from org categories
    Given I am some rando from the internet
    When I try to complete a skill from an org
    Then I get an error message
          
  Scenario: Org users cannot complete skills from other orgs
    Given I am a user from an organization
    When I try to complete a skill from another org
    Then I get an error message

  Scenario: Org users can complete skills from their own orgs
    Given I am a user from an organization
    When I try to complete a skill from my org
    Then the skill is complete
