*** Settings ***
Documentation

Resource          ../../.././resources/common/resource.robot
Resource          ../../.././resources/fleet/org.selection.page.robot
Resource          ../../.././resources/fleet/grid.robot
Resource          ../../.././resources/fleet/agents.page.robot
Resource          ../../.././resources/fleet/nativeagents.page.robot
Resource          ../../.././resources/fleet/ews.pages.robot
Resource          ../../.././resources/fleet/printers.page.robot
#using testcase as inputparameter for "Unenroll based on agent type"; any error message for this in console can be ignored
Resource           z-native-agent-features.robot

Suite Setup       Initializing user
Test Setup        Initiate Browser
Test Teardown     Closer Browser And Log Error

*** Keywords ***
Initializing user
    Set Suite Variable   ${IDP_USER}
Initiate Browser
    Skip Test for DEV
    Skip Test for QA
    Select Browser    ${BROWSER_NAME}
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization   ${ORG_NAME}
Closer Browser And Log Error
    Console Log On Failure
    Close Browser

*** Test Cases ***
Unenroll depending of printer's agent type
  [Documentation]    144842
  [Tags]    Go-Live-Agent-service    Full-Suite-Agent-service    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui
    Advance To the Printers Page
    Search in Listing page   ${PRINTER_IP}
    Click ip address in grid  ${PRINTER_IP}
    ${agentType} =  Fetch agent type of the printer   ${PRINTER_IP}
    Advance to Printer Landing Page
    Unenroll based on agent type    ${agentType}    Validate Successful Native Agent Un-enrollment From Portal
