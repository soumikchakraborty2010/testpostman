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
Validate Agent Tabs Name and Order
  [Documentation]    144913
  [Tags]    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui
    Go To Agents Tab
    Assert On Agents Page
    Agent Tabs Name And Order Validation

