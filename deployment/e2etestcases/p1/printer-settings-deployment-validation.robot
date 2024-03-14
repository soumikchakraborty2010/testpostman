*** Settings ***
Documentation

Resource          ../../.././resources/common/resource.robot
Resource          ../../.././resources/fleet/org.selection.page.robot
Resource          ../../.././resources/fleet/grid.robot
Resource          ../../.././resources/fleet/agents.page.robot
Resource          ../../.././resources/fleet/nativeagents.page.robot
Resource          ../../.././resources/fleet/ews.pages.robot
Resource          ../../.././resources/fleet/configurations.page.robot
Resource          ../../.././resources/fleet/grid.robot
Resource          ../../.././resources/common/printersettings-validation.robot
Library           ../../.././libs/UtilityFunctions.py
Resource          ../../.././libs/UtilityFunctions.py

Suite Setup       Initializing user
Test Setup        Initiate Browser And Deploy Cleanup File
Test Teardown     Closer Browser And Log Error

*** Variables ***

&{settingsSupplied}
...  NETWORK__CONTACT_LOCATION=CFCM
...  NETWORK__CONTACT_NAME=CFCM
...  PAPER__CUSTOM_SCAN_SIZES__CUSTOM2_TWO_SCANS_PER_SIDE=true
...  SECURITY__CONFIDENTIAL_PRINT_SETUP__REPEAT_JOB_EXPIRATION=0
...  GENERAL__SCREEN_BRIGHTNESS=100
...  NETWORK__PULLPRINT_RETRY_REQUEST_COUNT=3
...  PRINT__FINISHING__MULTIPAGE_ORIENTATION=99
${cleanupFileName}    Printersettings_cleanupvcc

*** Keywords ***
Initializing user
    Set Suite Variable   ${IDP_USER}

Initiate Browser And Deploy Cleanup File
    Select Browser    ${BROWSER_NAME}
    Go To Fleet Management Portal
     Log in To CFM
    Select Organization   ${ORG_NAME}
    Advance To the Printers Page
    Get Printer Device Family and Deploy cleanup File    ${PRINTER_IP}    ${IDP_USER}    ${IDP_PASSWORD}    ${orgId}    ${cleanupFileName}

Closer Browser And Log Error
    Console Log On Failure
    Close Browser


*** Test Cases ***

Validate the e2e flow of printer settings creation deployment validation
  [Documentation]    161362
  [Tags]    Go-Live-Configuration-service    Full-Suite-Configuration-service    Full-Suite-Asset-management-ui
    Advance to Configuration Page
    ${nameOfConfig} =   Create a configuration    @{settingsUiNameList}    typeToCreate=Publish
    Advance to Printer Landing Page
    Deploy Configuration    ${PRINTER_IP}     ${nameOfConfig}
    Search in Listing page   ${PRINTER_IP}
    Click ip address in grid  ${PRINTER_IP}
    Task Initial Status Validation  "Deploy configuration"
    Task Completion Status Validation   "Deploy configuration"
    Latest Task Validation  "Deploy configuration"  ${nameOfConfig} [v1]   "Completed"     True
    Advance to Configuration Page
    Delete a Configuration     ${nameOfConfig}
    Validating Enforced Settings Value    ${PRINTER_IP}     ${settingsSupplied}

Validation of deployed printer settings summary
  [Documentation]    174789
  [Tags]    Full-Suite-Configuration-service    Full-Suite-Asset-management-ui
    Advance to Configuration Page
    ${nameOfConfig} =   Create a configuration    @{settingsUiNameList}    typeToCreate=Publish
    Advance to Printer Landing Page
    Deploy Configuration    ${PRINTER_IP}     ${nameOfConfig}
    Advance to Configuration Page
    Open a Configuration    ${nameOfConfig}
    Validate the configuration contains printer settings
    Validating categories in deployed settings summary    @{CategoryInDeployedSummary}
    Validating settings name and value in deployed summary view    &{settingsInIncludedSummary}
    Validate the deployed summary text contains the no of printer settings
    Advance to Configuration Page
    Delete a Configuration     ${nameOfConfig}
