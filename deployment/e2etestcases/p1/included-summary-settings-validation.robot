*** Settings ***
Documentation

Resource          ../../.././resources/common/resource.robot
Resource          ../../.././resources/fleet/org.selection.page.robot
Resource          ../../.././resources/fleet/grid.robot
Resource          ../../.././resources/fleet/agents.page.robot
Resource          ../../.././resources/fleet/ews.pages.robot
Resource          ../../.././resources/fleet/configurations.page.robot
Resource          ../../.././resources/fleet/grid.robot
Resource          ../../../resources/fleet/nativeagents.page.robot
Library           SeleniumLibrary


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
Validation of printer settings tab in no settings selected mode
  [Documentation]    194844
  [Tags]    Full-Suite-Asset-management-ui
    Advance to Configuration Page
    Choose if configurations are already there or no configurations are selected
    Navigate to printer settings tab
    Validate the number of settings selected    0
    Validating buttons and strings of printer settings tab when no settings selected
    Validate all the categories are present in the left pane      @{allRootCategoriesOfLeftPane}
    Validating the right pane when no settings are selected in printer settings tab


Validation of included settings summary in edit mode
  [Documentation]    202666
  [Tags]    Full-Suite-Asset-management-ui    Full-Suite-Configuration-service
    Advance to Configuration Page
    ${nameOfConfig} =   Create a configuration    @{settingsUiNameList}    typeToCreate=Draft
    ${configLocator} =  Search in Configuration page    ${nameOfConfig}
    Click a configuration in grid   ${configLocator}
    Navigate to printer settings tab
    Click on includedSummary Button
    Validating categories and other strings in included settings summary    @{CategoryInIncludedSummary}
    Validating settings name and value in includedsummary section    &{settingsInIncludedSummary}
    Advance to Configuration Page
    Delete a Configuration     ${nameOfConfig}

Validation of included settings summary in create mode
  [Documentation]    194849
  [Tags]    Full-Suite-Asset-management-ui
    Advance to Configuration Page
    Choose if configurations are already there or no configurations are selected
    Navigate to printer settings tab
    Settings selection in printer settings tab    @{settingsUiNameList}
    Click on includedSummary Button
    Validating categories and other strings in included settings summary    @{CategoryInIncludedSummary}
    Validating settings name and value in includedsummary section    &{settingsInIncludedSummary}

Creation of configuration with printer settings visiting the nodes
  [Documentation]    251302
  [Tags]    Full-Suite-Configuration-service    Full-Suite-Asset-management-ui
    Advance to Configuration Page
    ${nameOfConfig} =   Create a configuration by traversing all the nodes and selecting single settings from each node    typeToCreate=Draft
    ${configLocator} =  Search in Configuration page    ${nameOfConfig}
    Click a configuration in grid   ${configLocator}
    Navigate to printer settings tab
    Validate the number of settings selected    216
    Advance to Configuration Page
    Delete a Configuration     ${nameOfConfig}


