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
Start Application PLP
  [Documentation]    144874
  [Tags]    Go-Live-Agent-service    Full-Suite-Agent-service    Full-Suite-Asset-management-ui    Go-Live-Asset-management-ui
  ${APP_NAME}=  Set Variable  Display Customization
  Go to EWS Page  ${PRINTER_IP}
  Secured Printer Check and login   ${PRINTER_PASSWORD}
  Navigate to Apps
  ${status}=    Run Keyword And Return Status    Validate App status   ${APP_NAME}    Stopped
  Skip If    '${status}' == 'False'       ${APP_NAME} app is not stopped
  Logout Secure Printer
  Go To Fleet Management Portal
   Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Start Application PLP  ${PRINTER_IP}  ${APP_NAME}
  Click ip address in grid  ${PRINTER_IP}
  Task Initial Status Validation  "Start app"
  Task Completion Status Validation   "Start app"
  Latest Task Validation  "Start app"  Apps: ${APP_NAME}  "Completed"  ${Status_App_Instl}
  Reload Page
  Validate App and status in Installed Application    ${APP_NAME}  Running
  Go to EWS Page  ${PRINTER_IP}
  Secured Printer Check and login   ${PRINTER_PASSWORD}
  Navigate to Apps
  Validate App status   ${APP_NAME}    Running
  Logout Secure Printer

Start Application PDP
  [Documentation]    144875
  [Tags]    Full-Suite-Agent-service    Full-Suite-Asset-management-ui
  ${APP_NAME}=  Set Variable  Scan Center
  Go to EWS Page  ${PRINTER_IP}
  Secured Printer Check and login   ${PRINTER_PASSWORD}
  Navigate to Apps
  ${status}=    Run Keyword And Return Status    Validate App status   ${APP_NAME}    Stopped
  Skip If    '${status}' == 'False'       ${APP_NAME} app is not stopped
  Logout Secure Printer
  Go To Fleet Management Portal
   Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Click ip address in grid  ${PRINTER_IP}
  Start Application Job PDP    ${APP_NAME}
  Task Initial Status Validation  "Start app"
  Task Completion Status Validation   "Start app"
  Latest Task Validation  "Start app"  Apps: ${APP_NAME}  "Completed"  ${Status_App_Instl}
  Reload Page
  Validate App and status in Installed Application    ${APP_NAME}  Running
  Go to EWS Page  ${PRINTER_IP}
  Secured Printer Check and login   ${PRINTER_PASSWORD}
  Navigate to Apps
  Validate App status   ${APP_NAME}    Running
  Logout Secure Printer
