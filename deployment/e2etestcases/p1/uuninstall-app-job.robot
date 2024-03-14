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
Uninstall Application PLP
  [Documentation]    144876
  [Tags]    Go-Live-Agent-service    Full-Suite-Agent-service    Full-Suite-Asset-management-ui    Go-Live-Asset-management-ui
  ${APP_NAME}=  Set Variable  Omnikey 5427ck Reader Driver
  Go to EWS Page  ${PRINTER_IP}
  Secured Printer Check and login   ${PRINTER_PASSWORD}
  Navigate to Apps
  ${appPresentStatus}=    Run Keyword And Return Status    Validate App is not present in EWS   ${APP_NAME}
  Skip If    '${appPresentStatus}' == 'True'    ${APP_NAME} app is not present.
  Logout Secure Printer
  Go To Fleet Management Portal
  Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Uninstall App PLP  ${PRINTER_IP}  ${APP_NAME}
  Click ip address in grid  ${PRINTER_IP}
  Task Initial Status Validation  "Uninstall app"
  Task Completion Status Validation   "Uninstall app"
  Latest Task Validation  "Uninstall app"  Apps: ${APP_NAME}  "Completed"  ${Status_App_Instl}
  Validate Removal of App in Installed Application  ${Status_App_Instl}   ${APP_NAME}
  Go to EWS Page  ${PRINTER_IP}
  Secured Printer Check and login   ${PRINTER_PASSWORD}
  Navigate to Apps
  Validate Removal of App in EWS   ${Status_App_Instl}    ${APP_NAME}
  Logout Secure Printer

Uninstall Application PDP
  [Documentation]    144877
  [Tags]    Full-Suite-Agent-service    Full-Suite-Asset-management-ui
  ${APP_NAME}=  Set Variable  Customer Support
  Go to EWS Page  ${PRINTER_IP}
  Secured Printer Check and login   ${PRINTER_PASSWORD}
  Navigate to Apps
  ${appPresentStatus}=    Run Keyword And Return Status    Validate App is not present in EWS   ${APP_NAME}
  Skip If    '${appPresentStatus}' == 'True'    ${APP_NAME} app is not present.
  Logout Secure Printer
  Go To Fleet Management Portal
  Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Click ip address in grid  ${PRINTER_IP}
  Uninstall Application Job PDP    ${APP_NAME}
  Task Initial Status Validation  "Uninstall app"
  Task Completion Status Validation   "Uninstall app"
  Latest Task Validation  "Uninstall app"  Apps: ${APP_NAME}  "Completed"  ${Status_App_Instl}
  Validate Removal of App in Installed Application  ${Status_App_Instl}   ${APP_NAME}
  Go to EWS Page  ${PRINTER_IP}
  Secured Printer Check and login   ${PRINTER_PASSWORD}
  Navigate to Apps
  Validate Removal of App in EWS   ${Status_App_Instl}    ${APP_NAME}
  Logout Secure Printer
