*** Settings ***
Documentation

Resource          ../../.././resources/common/resource.robot
Resource          ../../.././resources/fleet/org.selection.page.robot
Resource          ../../.././resources/fleet/grid.robot
Resource          ../../.././resources/fleet/nativeagents.page.robot
Resource          ../../.././resources/fleet/agents.page.robot
Resource          ../../.././resources/fleet/ews.pages.robot

Suite Setup       Initializing user
Test Setup        Initiate Browser
Test Teardown     Closer Browser And Log Error

*** Keywords ***

Initializing user
    Set Suite Variable   ${IDP_USER}
Initiate Browser
    Skip Test for FA
    Skip Test for EA
    Select Browser    ${BROWSER_NAME}
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization   ${ORG_NAME}
Closer Browser And Log Error
    Console Log On Failure
    Close Browser


*** Test Cases ***

Native Agent Enrollment Using EnrollMent Code
  [Documentation]    144850
  [Tags]    Go-Live-Iot-provisioning-service    Go-Live-Agent-service    Full-Suite-Agent-service    Full-Suite-Asset-management-ui
    Advance To the Printers Page
    Unenroll Printer From Grid Page If Grid contains   ${PRINTER_IP}
    Advance To Agents Page
    Advance To Native Agents Page
    Advance To Enroll Printer
    Open New Tab
    Go to EWS Page  ${PRINTER_IP}
    Secured Printer Check and login   ${PRINTER_PASSWORD}
    Navigate to Cloud Services
    Click On Get Enrollment Code To Copy Enrollment Code
    Logout Secure Printer
    Close Tab
    Return Main Tab
    Enroll The Printer Using The Enrollment Code Received From The Printer
    Wait For Successful Printer Enrollment    ${PRINTER_IP}
    Validate Printer Serail Number Is Present In Native Agent Grid    ${PRINTER_IP}
    Advance to Printer Landing Page
    Search in Listing page   ${PRINTER_IP}
    Click ip address in grid  ${PRINTER_IP}
    Advance To Agent Information Section In Printer Details Page To Validate Agent Type Is Native

Enroll the printer through pre enrollment
  [Documentation]    144944
  [Tags]    Go-Live-Agent-service    Full-Suite-Agent-service    Full-Suite-Agent-gateway    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui
    Pre-enroll the printer
    Collect The Pre-enrollment code and put it in the printer
    Return Main Tab
    Wait For Successful Printer Enrollment    ${PRINTER_IP}
    Validate Printer Serail Number Is Present In Native Agent Grid    ${PRINTER_IP}
    Advance to Printer Landing Page
    Search in Listing page   ${PRINTER_IP}
    Click ip address in grid  ${PRINTER_IP}
    Advance To Agent Information Section In Printer Details Page To Validate Agent Type Is Native

Validate Native Agent Data In Native Agent Grid
  [Documentation]    144950
  [Tags]    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui
    Advance To the Printers Page
    Unenroll Printer From Grid Page If Grid contains   ${PRINTER_IP}
    Advance To Agents Page
    Advance To Native Agents Page
    Advance To Enroll Printer
    Open New Tab
    Go to EWS Page  ${PRINTER_IP}
    Secured Printer Check and login   ${PRINTER_PASSWORD}
    Navigate to Cloud Services
    Click On Get Enrollment Code To Copy Enrollment Code
    Logout Secure Printer
    Close Tab
    Return Main Tab
    Enroll The Printer Using The Enrollment Code Received From The Printer
    Wait For Successful Printer Enrollment    ${PRINTER_IP}
    Validate Printer Serail Number Is Present In Native Agent Grid    ${PRINTER_IP}
    Validate The Agent Version Number    ${PRINTER_IP}
    Validate The Agent Is Communicating Thorugh Agent Status Filter

Validate Successful Native Agent Un-enrollment From Portal
  [Documentation]    191283
  [Tags]    Full-Suite-Agent-service    Go-Live-Agent-service
    Advance To the Printers Page
    Unenroll Printer From Grid Page If Grid contains   ${PRINTER_IP}
    Advance To Agents Page
    Advance To Native Agents Page
    Advance To Enroll Printer
    Open New Tab
    Go to EWS Page  ${PRINTER_IP}
    Secured Printer Check and login   ${PRINTER_PASSWORD}
    Navigate to Cloud Services
    Click On Get Enrollment Code To Copy Enrollment Code
    Logout Secure Printer
    Close Tab
    Return Main Tab
    Enroll The Printer Using The Enrollment Code Received From The Printer
    Wait For Successful Printer Enrollment    ${PRINTER_IP}
    Advance to Printer Landing Page
    Unenroll Printer From Grid Page If Grid contains   ${PRINTER_IP}
    Wait For Successful Printer Un-Enrollment    ${PRINTER_IP}
    Advance To Agents Page
    Advance To Native Agents Page
    Validate Printer Serial Number Is Not Present In Native Agent Grid    ${PRINTER_IP}
    Advance To Enroll Printer
    Open New Tab
    Go to EWS Page  ${PRINTER_IP}
    Secured Printer Check and login   ${PRINTER_PASSWORD}
    Navigate to Cloud Services
    Click On Get Enrollment Code To Copy Enrollment Code
    Logout Secure Printer
    Close Tab
    Return Main Tab
    Enroll The Printer Using The Enrollment Code Received From The Printer
    Wait For Successful Printer Enrollment    ${PRINTER_IP}
