*** Settings ***
Documentation

Resource          ../../.././resources/common/resource.robot
Resource          ../../.././resources/fleet/org.selection.page.robot
Resource          ../../.././resources/fleet/printers.page.robot
Resource          ../../.././resources/fleet/grid.robot
Resource          ../../.././resources/fleet/ews.pages.robot

Suite Setup       Initializing user
Test Setup        Initiate Browser
Test Teardown     Closer Browser And Log Error


*** Keywords ***
Initializing user
    Set Suite Variable   ${IDP_USER}
Initiate Browser
    Select Browser    ${BROWSER_NAME}
Closer Browser And Log Error
    Console Log On Failure
    Close Browser


*** Test Cases ***
Update Location and Contact Info and Refresh PLP
  [Documentation]    144834
  [Tags]    Go-Live-Agent-service    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui    Full-Suite-Agent-service
    ${uniqueNumber}    Generate random string    4    0123456789
    ${location}   Set Variable  Kolkata-${uniqueNumber}
    ${contact}    Set Variable  STL-${uniqueNumber}
    Go to EWS Page  ${PRINTER_IP}
    Secured Printer Check and login  ${PRINTER_PASSWORD}
    Update Location and Contact Info From EWS    ${location}   ${contact}
    Open New Tab
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization   ${ORG_NAME}
    Advance To Printers Page
    Assert On Printers Page
    Select View    Standard
    Search in Listing page  ${PRINTER_IP}
    Refresh Printer Information From Grid
    Click ip address in grid   ${PRINTER_IP}
    Task Initial Status Validation   "Refresh printer information"
    Task Completion Status Validation   "Refresh printer information"
    Check For Location And Contact Name   ${location}   ${contact}

Update Location and Contact Info and Refresh PDP
  [Documentation]    144835
  [Tags]    Full-Suite-Asset-management-ui    Full-Suite-Agent-service
    ${uniqueNumber}    Generate random string    4    0123456789
    ${location}   Set Variable  Kolkata-${uniqueNumber}
    ${contact}    Set Variable  STL-${uniqueNumber}
    Go to EWS Page  ${PRINTER_IP}
    Secured Printer Check and login  ${PRINTER_PASSWORD}
    Update Location and Contact Info From EWS   ${location}   ${contact}
    Open New Tab
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization   ${ORG_NAME}
    Advance To Printers Page
    Assert On Printers Page
    Search in Listing page  ${PRINTER_IP}
    Click ip address in grid   ${PRINTER_IP}
    Refresh Printer Information
    Task Initial Status Validation   "Refresh printer information"
    Task Completion Status Validation   "Refresh printer information"
    Check For Location And Contact Name   ${location}   ${contact}
