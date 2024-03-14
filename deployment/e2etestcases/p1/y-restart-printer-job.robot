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
    Go To Fleet Management Portal
     Log in To CFM
    Select Organization   ${ORG_NAME}
    Advance To Printers Page
    Assert On Printers Page
Closer Browser And Log Error
    Console Log On Failure
    Close Browser


*** Test Cases ***
Restart Printer From PLP
  [Documentation]    144836
  [Tags]    Full-Suite-Asset-management-ui    Full-Suite-Agent-service
    Search in Listing page  ${PRINTER_IP}
    Restart Printer From Grid
    Click ip address in grid   ${PRINTER_IP}
    Task Initial Status Validation   "Restart Printer"
    EWS Page Availablity Check
    Task Completion Status Validation   "Restart Printer"
    Open New Tab
    Go to EWS Page  ${PRINTER_IP}
    Secured Printer Check and login   ${PRINTER_PASSWORD}
    Check Printer Status From EWS   Ready
    Logout Secure Printer

Restart Printer From PDP
  [Documentation]    144837
  [Tags]    Go-Live-Agent-service    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui    Full-Suite-Agent-service
    Search in Listing page  ${PRINTER_IP}
    Click ip address in grid   ${PRINTER_IP}
    Restart Printer Form PDP
    Task Initial Status Validation   "Restart Printer"
    EWS Page Availablity Check
    Task Completion Status Validation   "Restart Printer"
    Open New Tab
    Go to EWS Page  ${PRINTER_IP}
    Secured Printer Check and login   ${PRINTER_PASSWORD}
    Check Printer Status From EWS   Ready
    Logout Secure Printer
