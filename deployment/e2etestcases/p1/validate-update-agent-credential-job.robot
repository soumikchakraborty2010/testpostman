*** Settings ***
Documentation

Resource          ../../.././resources/common/resource.robot
Resource          ../../.././resources/fleet/org.selection.page.robot
Resource          ../../.././resources/fleet/grid.robot
Resource          ../../.././resources/fleet/agents.page.robot

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
    Advance To Printers Page
    Assert On Printers Page

Closer Browser And Log Error
    Console Log On Failure
    Close Browser


*** Test Cases ***
Validate Agent Credential Update Job
  [Documentation]    144846
  [Tags]    Full-Suite-Agent-service
    Search in Listing page   ${PRINTER_IP}
    Select agent access credentials From Grid
    Select authentication type as password and enter password   ${PRINTER_PASSWORD}
    Search in Listing page   ${PRINTER_IP}
    Click ip address in grid  ${PRINTER_IP}
    Task Initial Status Validation  "Update agent access credentials"
    Task Completion Status Validation   "Update agent access credentials"
