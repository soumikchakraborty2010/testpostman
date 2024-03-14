*** Settings ***
Documentation
Library            SeleniumLibrary    run_on_failure=NOTHING
Resource          ../../.././resources/common/resource.robot
Resource          ../../.././resources/fleet/org.selection.page.robot
Resource          ../../.././resources/fleet/grid.robot
Resource          ../../.././resources/fleet/configurations.page.robot
Resource          ../../../resources/fleet/importsettingsbundle.page.robot




Suite Setup     Initializing user
Test Setup      Initiate Browser
Test Teardown    Closer Browser And Log Error

*** Variables ***
${fileName}     ImportBundleTestVCC.zip

*** Keywords ***
Initializing user
    Set Suite Variable   ${IDP_USER}
Initiate Browser
    Select Browser    ${BROWSER_NAME}
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization   ${ORG_NAME}
    Advance To Printers Page

Closer Browser And Log Error
    Delete all Configuration
    Console Log On Failure
    Close Browser

*** Test Cases ***
Validate the E2E flow for config draft creation and publish
  [Documentation]    251295
  [Tags]    Go-Live-Configuration-service    Full-Suite-Configuration-service
    Advance to Configuration Page
    Choose if configurations are already there or no configurations are selected
    Create a new config with random name
    Validate the presence of banner confirming it is a draft configuration
    Navigate to printer settings tab
    Click on import printer settings button
    Select bundle resource from file upload     ${fileName}
    Click on Import Settings bundle button in import bundle setings pop up
    Click on save as draft button
    Open the newly created draft
    Publish the drafted configuration
    Open the last published configuration
    Validate the version no for the configuration is    1
    Advance to Configuration Page

Validate the E2E flow of upgrading configuration to next version
  [Documentation]    251296
  [Tags]    Go-Live-Configuration-service    Full-Suite-Configuration-service
    Advance to Configuration Page
    Choose if configurations are already there or no configurations are selected
    Create a new config with random name
    Validate the presence of banner confirming it is a draft configuration
    Navigate to printer settings tab
    Click on import printer settings button
    Select bundle resource from file upload     ${fileName}
    Click on Import Settings bundle button in import bundle setings pop up
    Click on save as draft button
    Open the newly created draft
    Publish the drafted configuration
    Open the last published configuration
    Click on create new draft button
    Click on create new draft button in create new draft pop up
    Click on the recommended firmware checkbox
    Click on publish button
    #We can check below commented validation once conformance toggle is on
    #Validate the presence of information related to conformance status check in publish configuration modal
    Click on publish configuration button in publish configuration pop up
    Open the last published configuration
    Validate the version no for the configuration is    2
    Advance to Configuration Page

Validate the E2E flow of draft deletion and persistance of last published configuration
  [Documentation]    251297
  [Tags]    Go-Live-Configuration-service    Full-Suite-Configuration-service
    Advance to Configuration Page
    Choose if configurations are already there or no configurations are selected
    Create a new config with random name
    Validate the presence of banner confirming it is a draft configuration
    Navigate to printer settings tab
    Click on import printer settings button
    Select bundle resource from file upload     ${fileName}
    Click on Import Settings bundle button in import bundle setings pop up
    Click on save as draft button
    Open the newly created draft
    Publish the drafted configuration
    Open the last published configuration
    Click on create new draft button
    Click on create new draft button in create new draft pop up
    Click on the recommended firmware checkbox
    Click on save as draft button
    Open the newly created draft
    Delete the newly created draft
    Open the last published configuration
    Validate the version no for the configuration is    1
    Advance to Configuration Page

Validate traversal of published configuration from version history
  [Documentation]    251298
  [Tags]    Go-Live-Configuration-service    Full-Suite-Configuration-service    Full-Suite-Asset-management-ui
    Advance to Configuration Page
    Choose if configurations are already there or no configurations are selected
    Create a new config with random name
    Navigate to printer settings tab
    Click on import printer settings button
    Select bundle resource from file upload     ${fileName}
    Click on Import Settings bundle button in import bundle setings pop up
    Click on save as draft button
    Open the newly created draft
    Publish the drafted configuration
    Open the last published configuration
    Validate the presense of create new draft button
    Validate the presense of copy configuration button
    Validate the presense of version histroy button
    Click on create new draft button
    Click on create new draft button in create new draft pop up
    Click on the recommended firmware checkbox
    Publish the drafted configuration
    Open the last published configuration
    Click on version histroy button
    Validate the presence of version column
    Validate the presence of publisher column
    Validate the presence of date published column
    Validate the presence of version note column
    Clicks on version   2
    Validate the version no for the configuration is    2
    Click on version histroy button
    Clicks on version   1
    Validate the version no for the configuration is    1
    Validate create new draft button is not presnet for older version

Validate configuration name and description is getting updated successfully via update properties
  [Documentation]    251299
  [Tags]    Go-Live-Configuration-service    Full-Suite-Configuration-service    Full-Suite-Asset-management-ui
    Advance to Configuration Page
    Choose if configurations are already there or no configurations are selected
    Create a new config with random name
    Navigate to printer settings tab
    Click on import printer settings button
    Select bundle resource from file upload     ${fileName}
    Click on Import Settings bundle button in import bundle setings pop up
    Click on save as draft button
    Open the newly created draft
    Publish the drafted configuration
    Click on update properties by selecting the last published configuration
    Update configuration name and description in update properties window
    Validates the update is successful