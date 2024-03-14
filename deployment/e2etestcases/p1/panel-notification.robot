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
Send Notification PDP
  [Documentation]    144839
  [Tags]    Go-Live-Asset-notification-service    Full-Suite-Asset-notification-service    Full-Suite-Asset-management-ui    Full-Suite-Agent-service
  ${NOTIFICATION_MSG}=  Set Variable  Service has been scheduled
  Go To Fleet Management Portal
  Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Click ip address in grid  ${PRINTER_IP}
  Send Notification To Panel
  Sleep    5sec
  Reload Page
  Sleep    20sec
  Task Completion Status Validation   "Update panel message"
  Notification validation in PDP    ${NOTIFICATION_MSG}
  Go to EWS Page  ${PRINTER_IP}
  Secured Printer Check and login   ${PRINTER_PASSWORD}
  Notification validation in EWS      ${NOTIFICATION_MSG}
  Logout Secure Printer

Delete Notification PLP
  [Documentation]    144840
  [Tags]    Go-Live-Asset-notification-service    Full-Suite-Asset-notification-service    Full-Suite-Asset-management-ui    Full-Suite-Agent-service
  ${NOTIFICATION_MSG}=  Set Variable  Service has been scheduled
  Go To Fleet Management Portal
   Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Clear Notification From Grid      ${PRINTER_IP}
  Click ip address in grid  ${PRINTER_IP}
  Sleep    5sec
  Reload Page
  Sleep    20sec
  Task Completion Status Validation   "Delete panel message"
  Notification clear validation in PDP    ${NOTIFICATION_MSG}
  Go to EWS Page  ${PRINTER_IP}
  Secured Printer Check and login   ${PRINTER_PASSWORD}
  Notification clear validation in EWS      ${NOTIFICATION_MSG}
  Logout Secure Printer
