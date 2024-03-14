*** Settings ***
Documentation
Resource          ../../.././resources/common/resource.robot
Resource          ../../.././resources/fleet/org.selection.page.robot
Resource          ../../.././resources/fleet/grid.robot
Resource          ../../.././resources/fleet/agents.page.robot
Resource          ../../.././resources/fleet/contacts.page.robot
Resource          ../../.././resources/fleet/fleetagents.page.robot
Resource          ../../.././resources/fleet/localagents.page.robot
Resource          ../../.././resources/fleet/api.calls.robot
Resource          ../../.././resources/fleet/tasks.page.robot
Library           DateTime

Suite Setup       Initializing user
Test Setup        Initiate Browser
Test Teardown     Closer Browser And Log Error


*** Keywords ***
Initializing user
    Set Suite Variable   ${IDP_USER}
    ${date}=	Get Current Date	time_zone=UTC  result_format=%Y%m%d%H%M%S  exclude_millis=True
    @{fNameLNameList}=   Create List    fName1${date}  lName1${date}  fName2${date}  lName2${date}  fName3${date}  lName3${date}
    Set Suite Variable    @{contactNames}    @{fNameLNameList}
    Set Suite Variable    ${Fleet_Agent_Name}    UIAutomation_QA
    Set Suite Variable    ${contactLastName}    Simplicio
Initiate Browser
    Skip Test for DEV
    Skip Test for NA
    Skip Test for EA
    Skip Test for QA
    Select Browser    ${BROWSER_NAME}
Closer Browser And Log Error
    Console Log On Failure
    Close Browser


*** Test Cases ***
Fleet Agent Status Validation for MPS Printer
  [Documentation]    144921
  [Tags]    MPSEI
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization     ${ORG_NAME}
    Advance To Printers Page
    Assert On Printers Page
    Advance To Agents Page
    Assert On Agents Page
    Advance To Fleet Agents Tab
    Click on Fleet Agent Name    ${Fleet_Agent_Name}
    Validate FA Version    1.3.10
    Validate FA Status for MPS Printer

Managed Print Services Validation for Partner Org
  [Documentation]    189946
  [Tags]    MPSEI
    Go To Fleet Management Portal
    Log in To CFM
    Advance To Printers Page
    Assert On Printers Page
    Managed Print Services From Grid

Bulk Import Contact Using CSV for Child Org
  [Documentation]    189945
  [Tags]    MPSEI
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization       ${ORG_NAME}
    Advance To Printers Page
    Assert On Printers Page
    Advance To Contacts Page
    Assert On Contacts Page
    Download Sample File For Contacts
    Add Contact Infomations    @{contactNames}
    Import Contacts     ${lastModifiedFile}
    Validate Multiple Contacts Present     @{contactNames}

Delete Contact Validation for Child Org
  [Documentation]    189944
  [Tags]    MPSEI
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization      ${ORG_NAME}
    Advance To Printers Page
    Assert On Printers Page
    Advance To Contacts Page
    Assert On Contacts Page
    Delete Multiple Contacts From Grid     @{contactNames}

Validate MPSEI Views
  [Documentation]    144879
  [Tags]    MPSEI    Go-Live-View-service    Go-Live-Asset-management-ui    Full-Suite-View-service    Full-Suite-Asset-management-ui
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization     ${ORG_NAME}
    Advance To Printers Page
    Assert On Printers Page
    Check Managed view option
    Validate Managed options in Quick view

Validate Unenroll Option Absent in PDP for Managed Asset
  [Documentation]    115988
  [Tags]    MPSEI
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization      ${ORG_NAME}
    Advance To Printers Page
    Assert On Printers Page
    Search For IpAddress    ${PRINTER_IP}
    Click ip address in grid    ${PRINTER_IP}
    Validate Unenroll Button Absent In PDP

Validate Deactivation is Not Possible For FA with Managed Assets
  [Documentation]    109357
  [Tags]    MPSEI
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization     ${ORG_NAME}
    Advance To Printers Page
    Assert On Printers Page
    Advance To Agents Page
    Assert On Agents Page
    Advance To Fleet Agents Tab
    Click on Fleet Agent Name     ${Fleet_Agent_Name}
    Deactivate Fleet Agent    ${Fleet_Agent_Name}

Validate Unenroll is Not Possible from PLP for Managed Asset
  [Documentation]    144844
  [Tags]    MPSEI
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization      ${ORG_NAME}
    Advance To Printers Page
    Assert On Printers Page
    Select View    Managed
    Reload Page
    Search For IpAddress    ${PRINTER_IP}
    Validate Unenroll Not Possible from PLP

Validate Deletion is Not Possible For FA with Managed Assets
  [Documentation]    109397
  [Tags]    MPSEI
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization     ${ORG_NAME}
    Advance To Printers Page
    Assert On Printers Page
    Advance To Agents Page
    Assert On Agents Page
    Advance To Fleet Agents Tab
    Click on Fleet Agent Name     ${Fleet_Agent_Name}
    Delete Fleet Agent     ${Fleet_Agent_Name}

Local Agent Status Validation for MPS Printer
  [Documentation]    251283
  [Tags]    MPSEI
    Skip    Skipping test a for local agent as local agent setup is not there
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization     ${ORG_NAME}
    Advance To Printers Page
    Assert On Printers Page
    Go To Agents Tab
    Advance To Local Agents Page
    Search For LocalAgentName  DESTKOP-PMSIJ5R
    Select LocalAgentName     DESTKOP-PMSIJ5R
    Validate LA Status for MPS Printer

Validate Deactivation is Not Possible For LA with Managed Assets
  [Documentation]    109395
  [Tags]    MPSEI
    Skip    Skipping test a for local agent as local agent setup is not there
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization     ${ORG_NAME}
    Advance To Printers Page
    Assert On Printers Page
    Go To Agents Tab
    Advance To Local Agents Page
    Search For LocalAgentName  DESTKOP-PMSIJ5R
    Select LocalAgentName    DESTKOP-PMSIJ5R
    Check Deactivate Action

Validate Delition is Not Possible For LA with Managed Assets
  [Documentation]    109398
  [Tags]    MPSEI
   Skip    Skipping test a for local agent as local agent setup is not there
   Go To Fleet Management Portal
   Log in To CFM
   Select Organization     ${ORG_NAME}
   Advance To Printers Page
   Assert On Printers Page
   Go To Agents Tab
   Advance To Local Agents Page
   Search For LocalAgentName  DESTKOP-PMSIJ5R
   Select LocalAgentName      DESTKOP-PMSIJ5R
   Check Delete Action

Validate Assign Contact From PDP Page
  [Documentation]    251284
  [Tags]    MPSEI
    Assign Contact
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization      ${ORG_NAME}
    Advance To Printers Page
    Assert On Printers Page
    Search For IpAddress    ${PRINTER_IP}
    Click ip address in grid    ${PRINTER_IP}
    ${printerCount}  ${_}=   Get Number of Printers Assigned to Contact Name   contactLastName=${contactLastName}
    Assign Contat from PDP    contactLastName=${contactLastName}   alreadyAssignedContact=${printerCount}
    Assign Contact

Validate Messages When Managed Asset Ip Removed From Include Criteria in Discovery for FA
  [Documentation]    251311
  [Tags]    MPSEI
    ${desired_printer_to_get_added_and_deleted}    Set Variable  1.2.2.1
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization     ${ORG_NAME}
    Advance To Printers Page
    Assert On Printers Page
    Advance To Agents Page
    Assert On Agents Page
    Advance To Fleet Agents Tab
    Click on Fleet Agent Name     ${Fleet_Agent_Name}
    Add a printer to include section of Discovery Criteria  ${desired_printer_to_get_added_and_deleted}
    Delete a printer from include section of Discovery Criteria and Validate Messages   ${desired_printer_to_get_added_and_deleted}

Validate Messages When Managed Asset Ip Include in Exclude Criteria in Discovery for FA
  [Documentation]    251285
  [Tags]    MPSEI
    ${desired_printer_to_get_added}    Set Variable  1.2.2.1
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization     ${ORG_NAME}
    Advance To Printers Page
    Assert On Printers Page
    Advance To Agents Page
    Assert On Agents Page
    Advance To Fleet Agents Tab
    Click on Fleet Agent Name     ${Fleet_Agent_Name}
    Include a printer in Exclude Criteria and Validate Messages    ${desired_printer_to_get_added}

Validate Import and Assisn Contact
  [Documentation]    240530
  [Tags]    MPSEI
   ${contactFirstName}=   Set Variable   firstName
   ${contactLastName}=    Set Variable   lastName
   Go To Fleet Management Portal
   Log in To CFM
   Select Organization     ${ORG_NAME}
   Advance To Printers Page
   Assert On Printers Page
   Select View    Managed
   ${serialNumber}=    Get Serial Number from Printer Listing Page
   Assign Contact
   Advance To Contacts Page
   Assert On Contacts Page
   Download Sample File For Contacts
   Add Contact Information with Serial Number   firstName=${contactFirstName}    lastName=${contactLastName}   serialNumber=${serialNumber}
   Import Contacts     ${lastModifiedFile}   importWithoutSerialNumber=${False}
   Validate Contact Present    ${contactFirstName}    ${contactLastName}
   Validate Printer Assigned and Pending Count from Contact Page    1    1
   Validate Pendig Printer Modal    ${contactFirstName}    ${contactLastName}
   Validate Delete Contact is not Possible    ${contactLastName}
   Click on Assigned Printer Link
   Validate Supplies Delivery Contact Name    firstName=${contactFirstName}    lastName=${contactLastName}   serialNumber=${serialNumber}
   Validate Printer Assigned and Pending Count from Grid    1    1
   Advance To Tasks Status Page
   Validate Latest Task Completion Status     Assign contact     1 printer
   Assign Contact
   Advance to Printer Landing Page
   Advance To Contacts Page
   Assert On Contacts Page
   Delete Pending Serial Number    ${contactLastName}
   Delete Contact From Grid    ${contactLastName}