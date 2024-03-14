*** Settings ***
Documentation
Library            SeleniumLibrary    run_on_failure=NOTHING
Resource          ../../.././resources/common/resource.robot
Resource          ../../.././resources/fleet/org.selection.page.robot
Resource          ../../.././resources/fleet/grid.robot
Resource          ../../.././resources/fleet/agents.page.robot
Resource          ../../.././resources/fleet/ews.pages.robot
Resource          ../../.././resources/fleet/configurations.page.robot
Resource          ../../.././resources/fleet/grid.robot
Resource          ../../../resources/fleet/nativeagents.page.robot
Resource          ../../../resources/fleet/importsettingsbundle.page.robot
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
Validate the E2E flow for import settings bundle into new config via file upload path
  [Documentation]    251300
  [Tags]    Go-Live-Configuration-service    Full-Suite-Asset-management-ui
    Advance to Configuration Page
    Choose if configurations are already there or no configurations are selected
    Create a new config with random name
    Navigate to printer settings tab
    Click on import printer settings button
    Select bundle resource from file upload     ImportBundleTestVCC.zip
    Validating count of new settings to import
    Validating invalid value settings modal
    Validating unsupported settings modal
    Click on Import Settings bundle button in import bundle setings pop up
    Click on includedSummary Button
    Validating settings name and value in includedsummary section    &{settingsInIncludedSummaryForIPS}

Validate the E2E flow for import settings bundle into new config via resource library
  [Documentation]    238378
  [Tags]    Full-Suite-Configuration-service
    Advance to Configuration Page
    Choose if configurations are already there or no configurations are selected
    Create a new config with random name
    Navigate to printer settings tab
    Click on import printer settings button
    Select bundle resource from resource library     importsettingbundletest
    Validating invalid value settings modal
    Validating unsupported settings modal
    Click on Import Settings bundle button in import bundle setings pop up
    Click on includedSummary Button
    Validating settings name and value in includedsummary section    &{settingsInIncludedSummaryForIPS}

Validate the E2E flow for import settings bundle into existing config via file upload path
  [Documentation]    238377
  [Tags]    Go-Live-Configuration-service    Full-Suite-Configuration-service
    Advance to Configuration Page
    Choose if configurations are already there or no configurations are selected
    Create a new config with random name
    Navigate to printer settings tab
    Settings selection in printer settings tab    @{settingsUiNameList}
    Click on import printer settings button
    Select bundle resource from file upload     ImportBundleTestVCC.zip
    Validating invalid value settings modal
    Validating unsupported settings modal
    Validating settings with same value modal
    Validating settings with different value modal
    Click on Import Settings bundle button in import bundle setings pop up
    Click on includedSummary Button
    Validating settings name and value in includedsummary section    &{settingsInIncludedSummaryForIPS}

Validation of the import disbaled scenario
  [Documentation]    238380
  [Tags]    Full-Suite-Asset-management-ui
    Advance to Configuration Page
    Choose if configurations are already there or no configurations are selected
    Wait Until Keyword Succeeds    5    5    Wait Until Element Is Visible    ${createConfigurationTitle}
    ${Random Numbers}    Generate Random String    4    0123456789
    Input Text      ${nameTextInConfigPage}    ${configurationName}-${Random Numbers}
    Navigate to printer settings tab
    Settings selection in printer settings tab    @{settingsUiNameList}
    Sleep    5s
    Click on import printer settings button
    Select bundle resource from file upload     InvalidUnsupportedVCCSettings.zip
    Validating invalid, unsuuported and settings with same values modal