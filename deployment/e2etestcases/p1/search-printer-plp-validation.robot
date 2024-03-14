*** Settings ***
Documentation
Resource          ../../.././resources/common/resource.robot
Resource          ../../.././resources/fleet/org.selection.page.robot
Resource          ../../.././resources/fleet/printers.page.robot
Resource          ../../.././resources/fleet/grid.robot
Library           ../../.././libs/UtilityFunctions.py
Resource          ../../.././libs/UtilityFunctions.py

Suite Setup       Initializing user
Test Setup        Initiate Browser
Test Teardown     Closer Browser And Log Error


*** Keywords ***
Initializing user
    Set Suite Variable   ${IDP_USER}

Initiate Browser
    Select Browser    ${BROWSER_NAME}
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization   ${ORG_NAME}
    Advance To the Printers Page
    Fetch Printer Details     ${PRINTER_IP}     ${IDP_USER}     ${IDP_PASSWORD}     ${orgId}

Closer Browser And Log Error
    Console Log On Failure
    Close Browser


*** Test Cases ***
Validate Search in PLP
  [Documentation]    144857
  [Tags]    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui    Full-Suite-Agent-service
     @{list}=      Create List     ${serialNumber}     ${modelName}    ${hostname}    ${location}    ${assetLabelValues}
     FOR        ${item}     IN      @{list}
            Run Keyword If    '${item}' == '${hostname}'      Search in Listing page with hostname  ${hostname}
                ...  ELSE
                ...    Search in Listing page without IP    ${item}
            Grid Contains item with ip address    ${PRINTER_IP}
            Clear Search Field
     END

Validate Printer Search using Asset Tag
  [Documentation]    251286
  [Tags]    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui
    Create Tags In PLP    @{singleTags}
    Advance to Printer Landing Page
    Assign Tag to a Printer and validation in PLP   ImportTag_SerialNumber   ${PRINTER_IP}
    Search in Listing page without IP  ImportTag_SerialNumber
    Grid Contains item with ip address    ${PRINTER_IP}
    Navigate to Manage Tags
    Delete All Tags in PLP

