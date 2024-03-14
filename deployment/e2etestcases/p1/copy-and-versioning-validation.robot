*** Settings ***
Documentation
Library            SeleniumLibrary    run_on_failure=NOTHING
Resource          ../../.././resources/common/resource.robot
Resource          ../../.././resources/fleet/org.selection.page.robot
Resource          ../../.././resources/fleet/grid.robot
Resource          ../../.././resources/fleet/configurations.page.robot



Suite Setup     Initializing user
Test Setup      Initiate Browser
Test Teardown    Closer Browser And Log Error


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
    Console Log On Failure
    Close Browser

*** Test Cases ***

Copy a draft configuration to same org
  [Documentation]    251294
  [Tags]    Full-Suite-Configuration-service
     Advance to Configuration Page
     ${nameOfConfig} =   Create a configuration    @{settingsUiNameList}    typeToCreate=Draft
     ${configLocator} =  Search in Configuration page    ${nameOfConfig}
     Copy a configuration to same org
     Advance to Configuration Page
     Open a Configuration    Copy of ${nameOfConfig}
     Advance to Configuration Page
     Delete a Configuration     Copy of ${nameOfConfig}
     Delete a Configuration     ${nameOfConfig}

Copy a published configuration to different org
  [Documentation]    173341
  [Tags]    Go-Live-Configuration-service    Full-Suite-Configuration-service
     Advance to Configuration Page
     ${nameOfConfig} =   Create a configuration    @{settingsUiNameList}    typeToCreate=Publish
     ${configLocator} =  Search in Configuration page    ${nameOfConfig}
     ${childOrgName} =  Copy a configuration to different org
     Go back to the org selection page
     Select Organization   ${childOrgName}
     Advance To Printers Page
     Advance to Configuration Page
     Open a Configuration    Copy of ${nameOfConfig}
     Advance to Configuration Page
     Delete a Configuration     Copy of ${nameOfConfig}
     Go back to the org selection page
     Select Organization   ${ORG_NAME}
     Advance To Printers Page
     Advance to Configuration Page
     Delete a Configuration     ${nameOfConfig}

Validate that publish configuration is present in deploy configuration list
  [Documentation]    251293
  [Tags]    Full-Suite-Configuration-service    Full-Suite-Asset-management-ui
      Advance to Configuration Page
      ${nameOfConfig} =   Create a configuration    @{settingsUiNameList}    typeToCreate=Publish
      Advance to Printer Landing Page
      Search in Listing page  ${PRINTER_IP}
      Select item in grid by index  0
      Validate that deploy configuration list draft is absent and published config is present   ${nameOfConfig}     typeOfConfig=Publish
      Advance to Configuration Page
      Delete a Configuration     ${nameOfConfig}

Validate that draft configuration is absent in deploy configuration list
  [Documentation]    251292
  [Tags]    Full-Suite-Configuration-service    Full-Suite-Asset-management-ui
      Advance to Configuration Page
      ${nameOfConfig} =   Create a configuration    @{settingsUiNameList}    typeToCreate=Draft
      Advance to Printer Landing Page
      Sleep    10s
      Search in Listing page  ${PRINTER_IP}
      Select item in grid by index  0
      Validate that deploy configuration list draft is absent and published config is present   ${nameOfConfig}     typeOfConfig=Draft
      Advance to Configuration Page
      Delete a Configuration     ${nameOfConfig}

Validate that publish configuration is present in assign configuration list
  [Documentation]    251291
  [Tags]    Full-Suite-Configuration-service    Full-Suite-Asset-management-ui
      Advance to Configuration Page
      ${nameOfConfig} =   Create a configuration    @{settingsUiNameList}    typeToCreate=Publish
      Advance to Printer Landing Page
      Search in Listing page  ${PRINTER_IP}
      Select item in grid by index  0
      Validate that in assign configuration list draft is absent and published config is present   ${nameOfConfig}     typeOfConfig=Publish
      Advance to Configuration Page
      Delete a Configuration     ${nameOfConfig}

Validate that draft configuration is absent in assign configuration list
  [Documentation]    251290
  [Tags]    Full-Suite-Configuration-service    Full-Suite-Asset-management-ui
      Advance to Configuration Page
      ${nameOfConfig} =   Create a configuration    @{settingsUiNameList}    typeToCreate=Draft
      Advance to Printer Landing Page
      Search in Listing page  ${PRINTER_IP}
      Select item in grid by index  0
      Validate that in assign configuration list draft is absent and published config is present   ${nameOfConfig}     typeOfConfig=Draft
      Advance to Configuration Page
      Delete a Configuration     ${nameOfConfig}

Copy From the button inside Published Configuration
  [Documentation]    251288
  [Tags]    Full-Suite-Configuration-service
      Advance to Configuration Page
      ${nameOfConfig} =   Create a configuration    @{settingsUiNameList}    typeToCreate=Publish
      Open a Configuration    ${nameOfConfig}
      Copy a configuration from the copy button inside the published configuration
      Open a Configuration    Copy of ${nameOfConfig}
      Advance to Configuration Page
      Delete a Configuration     Copy of ${nameOfConfig}
      Delete a Configuration     ${nameOfConfig}