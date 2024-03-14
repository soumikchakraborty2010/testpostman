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
Deploy VCC
  [Documentation]    182645
  [Tags]    Go-Live-Configuration-service    Go-Live-File-service    Full-Suite-Agent-service
  ${CONTACT_NAME_BLANK}   Set Variable  ${EMPTY}
  ${CONATCT_LOC_BLANK}    Set Variable    ${EMPTY}
  ${CONTACT_NAME}   Set Variable      vVcRKCQb
  ${CONATCT_LOC}    Set Variable      JGXCpYBR
  ${BUNDLE_BLANK}   Set Variable      bundle.zip
  ${UPLOAD_FILE}    Set Variable      bundle_vcc.zip
  Go to EWS Page  ${PRINTER_IP}
  Secured Printer Check and login   ${PRINTER_PASSWORD}
  Navigate to Settings
  Naviate to Device
  Navigate to About this Printer
  Upload and Update Import Configuration    ${BUNDLE_BLANK}
  Validate Contact Name and Location    ${CONTACT_NAME_BLANK}   ${CONATCT_LOC_BLANK}
  Logout Secure Printer
  Go To Fleet Management Portal
   Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Deploy app and settings file    ${PRINTER_IP}   ${UPLOAD_FILE}
  Click ip address in grid   ${PRINTER_IP}
  Task Initial Status Validation   "File deployment"
  Task Completion Status Validation   "File deployment"
  Check For Location And Contact Name   ${CONATCT_LOC}    ${CONTACT_NAME}
  Go to EWS Page    ${PRINTER_IP}
  Secured Printer Check and login   ${PRINTER_PASSWORD}
  Navigate to Settings
  Naviate to Device
  Navigate to About this Printer
  Validate Contact Name and Location    ${CONTACT_NAME}   ${CONATCT_LOC}

Deploy App
  [Documentation]    144870
  [Tags]    Go-Live-Configuration-service    Go-Live-Product-service    Go-Live-Agent-service    Go-Live-Asset-management-ui    Full-Suite-Configuration-service    Full-Suite-Product-service    Full-Suite-Agent-service    Full-Suite-Asset-management-ui
  ${APP_NAME}=  Set Variable  Customer Support
  ${UPLOAD_FILE}    Set Variable      customersupport_e5_mfp-6.3.0.fls
  Go to EWS Page  ${PRINTER_IP}
  Secured Printer Check and login   ${PRINTER_PASSWORD}
  Navigate to Apps
  Uninstall App in EWS if Present    ${APP_NAME}
  Logout Secure Printer
  Go To Fleet Management Portal
  Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Deploy app and settings file    ${PRINTER_IP}   ${UPLOAD_FILE}
  Click ip address in grid   ${PRINTER_IP}
  Task Initial Status Validation   "File deployment"
  Task Completion Status Validation   "File deployment"
  Validate App and status in Installed Application    ${APP_NAME}  Running
  Go to EWS Page  ${PRINTER_IP}
  Secured Printer Check and login   ${PRINTER_PASSWORD}
  Navigate to Apps
  Validate App status   ${APP_NAME}    Running
  Uninstall App Ews     ${APP_NAME}
  Logout Secure Printer

Deploy UCF
  [Documentation]    188614
  [Tags]    Go-Live-Configuration-service    Full-Suite-File-service    Go-Live-File-service    Full-Suite-Configuration-service    Go-Live-Agent-service    Full-Suite-Agent-service
  ${CONTACT_NAME_BLANK}   Set Variable  ${EMPTY}
  ${CONATCT_LOC_BLANK}    Set Variable    ${EMPTY}
  ${UPLOAD_FILE}    Set Variable      cardCopy.ucf
  Go to EWS Page  ${PRINTER_IP}
  Secured Printer Check and login   ${PRINTER_PASSWORD}
  Create the UCF File   Card Copy   ${UPLOAD_FILE}  esf.cardCopy.copyQty "2"
  Logout Secure Printer
  Go To Fleet Management Portal
  Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Deploy app and settings file    ${PRINTER_IP}   ${UPLOAD_FILE}
  Click ip address in grid   ${PRINTER_IP}
  Task Initial Status Validation   "File deployment"
  Task Completion Status Validation   "File deployment"
  Go to EWS Page    ${PRINTER_IP}
  Secured Printer Check and login   ${PRINTER_PASSWORD}
  Navigate to Apps
  Go to App configuration   Card Copy
  Check Copy Settings In Card Copy
