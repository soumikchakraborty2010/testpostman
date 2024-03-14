*** Settings ***
Documentation

Resource          ../../.././resources/common/resource.robot
Resource          ../../.././resources/fleet/org.selection.page.robot
Resource          ../../.././resources/fleet/grid.robot
Resource          ../../../resources/fleet/agents.page.robot
Resource          ../../../resources/fleet/fleetagents.page.robot
Resource          ../../../resources/fleet/api.calls.robot
Resource          ../../.././resources/fleet/tasks.page.robot
Library           String

Suite Setup       Initializing user
Test Setup        Open Browser
Test Teardown     Closer Browser And Log Error

*** Keywords ***
Initializing user
    Set Suite Variable   ${IDP_USER}
    Set Suite Variable    ${fakePrinterIPAddress}    10.100.100.100

Open Browser
    Select Browser    ${BROWSER_NAME}
    Skip Test for FA
    Skip Test for NA
    Make Fake Printer Communicating   ipAddress=${fakePrinterIPAddress}

Closer Browser And Log Error
    Console Log On Failure
    Close Browser

*** Test Cases ***
Schedule FW update from PLP
  [Documentation]    191868
  [Tags]    Go-Live-Asset-management-ui    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui
    ${number_of_printers}  Set Variable  1
    ${printer_count}  Set Variable  1 printer
    ${update_firmware_job_name}  Set Variable  FW Update
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization     ${ORG_NAME}
    Advance To Printers Page
    Assert On Printers Page
    Search in Listing page     ${fakePrinterIPAddress}
    Select item in grid by index  0
    Update firmware from PLP   ${number_of_printers}   ${update_firmware_job_name}
    Advance To Tasks Schedule Page
    Validate Scheduled FW Update job     ${printer_count}   ${update_firmware_job_name}
    Validate scheduled firmwaware job's Starts data


Edit Schedule FW update
  [Documentation]    191869
  [Tags]    Full-Suite-Asset-management-ui    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui
    ${number_of_printers}  Set Variable  1 printer
    ${update_firmware_job_name}  Set Variable  Edit FW Update
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization     ${ORG_NAME}
    Advance To Printers Page
    Assert On Printers Page
    Advance To Tasks Schedule Page
    Edit Scheduled FW Update Job        ${update_firmware_job_name}
    Validate Scheduled FW Update job      ${number_of_printers}   ${update_firmware_job_name}

Modal validation for scheduled FW update task
  [Documentation]    191871
  [Tags]    Go-Live-Asset-management-ui    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui
    ${update_firmware_job_name}  Set Variable  Edit FW Update
    ${number_of_printers}  Set Variable  1
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization     ${ORG_NAME}
    Advance To Printers Page
    Advance To Tasks Status Page
    Modal validation in Currently Running Tasks   ${number_of_printers}  ${update_firmware_job_name}
    Modal validation in Completed Tasks   ${number_of_printers}   ${update_firmware_job_name}
    Advance To Tasks Schedule Page
    Validate schedule task's absence in Tasks Schedule Page   ${update_firmware_job_name}

Delete scheduled FW update task
  [Documentation]    191870
  [Tags]    Full-Suite-Asset-management-ui    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui
   ${update_firmware_job_name}  Set Variable   FW Update Del
   ${number_of_printers}  Set Variable  1
   Go To Fleet Management Portal
   Log in To CFM
   Select Organization     ${ORG_NAME}
   Advance To Printers Page
   Assert On Printers Page
   Search in Listing page     ${fakePrinterIPAddress}
   Select item in grid by index  0
   Update firmware from PLP   ${number_of_printers}   ${update_firmware_job_name}
   Advance To Tasks Schedule Page
   Validate deletion of scheduled FW update task   ${update_firmware_job_name}