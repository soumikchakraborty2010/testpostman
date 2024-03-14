*** Settings ***
Documentation

Resource          ../../.././resources/common/resource.robot
Resource          ../../.././resources/fleet/org.selection.page.robot
Resource          ../../.././resources/fleet/grid.robot
Resource          ../../../resources/fleet/ews.pages.robot


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
Update App
  [Documentation]    205375
  [Tags]    Go-Live-Agent-service    Full-Suite-Agent-service    Full-Suite-Asset-management-ui    Go-Live-Asset-management-ui
  ${APP_NAME} =  Set Variable  Customer Support
  ${DEPLOY_APP_FILE_NAME} =  Set Variable  customersupport_e5_mfp-6.3.0.fls
  ${previousAppVersion} =  Set Variable  6.3.0
  Go to EWS Page    ${PRINTER_IP}
  Secured Printer Check and login    ${PRINTER_PASSWORD}
  Navigate to Apps
  Uninstall App in EWS if Present   ${APP_NAME}
  Validate App is not present in EWS    ${APP_NAME}
  Logout Secure Printer
  Go To Fleet Management Portal
  Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Assert On Printers Page
  Deploy app and settings file    ${PRINTER_IP}    ${DEPLOY_APP_FILE_NAME}
  Click ip address in grid    ${PRINTER_IP}
  Task Initial Status Validation    "File deployment"
  Task Completion Status Validation    "File deployment"
  Advance to Printer Landing Page
  Update App  ${PRINTER_IP}  ${APP_NAME}
  Click ip address in grid    ${PRINTER_IP}
  Task Initial Status Validation    "Update apps"
  Task Completion Status Validation    "Update apps"
  Advance to Printer Landing Page
  Verify Selected App is Updated    ${PRINTER_IP}  ${APP_NAME}
  Click ip address in grid    ${PRINTER_IP}
  Validate App Version    ${APP_NAME}   ${previousAppVersion}

Update App from Application Priter Listing Page
  [Documentation]    233920
  [Tags]    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui
  ${APP_NAME} =  Set Variable  Customer Support
  ${DEPLOY_APP_FILE_NAME} =  Set Variable  customersupport_e5_mfp-6.3.0.fls
  ${previousAppVersion} =  Set Variable  6.3.0
  Go to EWS Page    ${PRINTER_IP}
  Secured Printer Check and login    ${PRINTER_PASSWORD}
  Navigate to Apps
  Uninstall App in EWS if Present   ${APP_NAME}
  Validate App is not present in EWS    ${APP_NAME}
  Logout Secure Printer
  Go To Fleet Management Portal
  Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Assert On Printers Page
  Deploy app and settings file    ${PRINTER_IP}    ${DEPLOY_APP_FILE_NAME}
  Click ip address in grid    ${PRINTER_IP}
  Task Initial Status Validation    "File deployment"
  Task Completion Status Validation    "File deployment"
  Navigate to Apps page
  Select App to update      ${APP_NAME}
  Search For IpAddress in APLP    ${PRINTER_IP}
  Capture App Details
  Update App from APLP      ${APP_NAME}

Update App from Application Priter Details Page
  [Documentation]    233922
  [Tags]    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui
  ${APP_NAME} =  Set Variable  Customer Support
  ${DEPLOY_APP_FILE_NAME} =  Set Variable  customersupport_e5_mfp-6.3.0.fls
  ${previousAppVersion} =  Set Variable  6.3.0
  Go to EWS Page    ${PRINTER_IP}
  Secured Printer Check and login    ${PRINTER_PASSWORD}
  Navigate to Apps
  Uninstall App in EWS if Present   ${APP_NAME}
  Validate App is not present in EWS    ${APP_NAME}
  Logout Secure Printer
  Go To Fleet Management Portal
  Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Assert On Printers Page
  Deploy app and settings file    ${PRINTER_IP}    ${DEPLOY_APP_FILE_NAME}
  Click ip address in grid    ${PRINTER_IP}
  Task Initial Status Validation    "File deployment"
  Task Completion Status Validation    "File deployment"
  Navigate to Apps page
  Select App to update      ${APP_NAME}
  Search For IpAddress in APLP    ${PRINTER_IP}
  Click ip address in grid    ${PRINTER_IP}
  Update App from APDP      ${APP_NAME}