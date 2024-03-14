*** Settings ***
Documentation

Resource          ../../.././resources/common/resource.robot
Resource          ../../.././resources/fleet/org.selection.page.robot
Resource          ../../.././resources/fleet/printers.page.robot
Resource          ../../.././resources/fleet/grid.robot

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
Validate all scrollspy value name and order
  [Documentation]    144900
  [Tags]    Full-Suite-Asset-management-ui    Go-Live-Asset-management-ui
    Click ip address in grid   ${PRINTER_IP}
    Check all scrollspy names and order

Validate all scrollspy functionality
  [Documentation]    144901
  [Tags]    Full-Suite-Asset-management-ui    Go-Live-Asset-management-ui
    Click ip address in grid   ${PRINTER_IP}
    Validate scrollspy functionality by clicking
