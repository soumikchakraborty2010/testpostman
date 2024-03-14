*** Settings ***
Documentation

Library            OperatingSystem
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
    Skip Test for FA
    Skip Test for NA
    Select Browser    ${BROWSER_NAME}

Closer Browser And Log Error
    Console Log On Failure
    Close Browser



*** Test Cases ***
Deploy Settings
  [Documentation]    144937
  [Tags]    Go-Live-Agent-service    Full-Suite-Agent-service    Full-Suite-Asset-management-ui
  ${LOG LEVEL}=  Set Variable  Detailed
  ${LOG_LEVEL_REVERT}=  Set Variable  Summary
  ${FILE_DOWNLOAD_DIR_PATH}=    Set Variable   ${EXECDIR}${/}src${/}resources${/}ExternalFiles${/}
  Go To Fleet Management Portal
  Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Click ip address in grid  ${PRINTER_IP}
  Submit deploy settings job    ${LOG LEVEL}
  Task Completion Status Validation   "Update agent settings"
  Validate Deployed Settings    ${LOG LEVEL}
  Go to EWS Page  ${PRINTER_IP}
  Secured Printer Check and login   ${PRINTER_PASSWORD}
  Navigate to Apps
  Go to App configuration   Printer Configuration Agent
  Download Configuration
  Get Latest File name    /    *.ucf
  Move file to ExternalFiles Directory    ${lastModifiedFile}
  Get Latest File name    ${EXECDIR}${/}src${/}/resources/ExternalFiles/    *.ucf
  Validate downloaded UCF file    esf.one_iss_agent.settings.logLevel "2"   esf.one_iss_agent.settings.pollingInterval "${pol_interval}"
  Go To Fleet Management Portal
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Click ip address in grid  ${PRINTER_IP}
  Revert deploy settings job    ${LOG_LEVEL_REVERT}
  Task Completion Status Validation   "Update agent settings"


