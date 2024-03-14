*** Settings ***
Documentation

Resource          ../../.././resources/common/resource.robot
Resource          ../../.././resources/fleet/org.selection.page.robot
Resource          ../../.././resources/fleet/grid.robot
Resource          ../../.././resources/fleet/nativeagents.page.robot
Resource          ../../.././resources/fleet/configurations.page.robot
Resource          ../../.././resources/fleet/printers.page.robot
Resource          ../../.././resources/common/printersettings-validation.robot
Resource          ../../../resources/fleet/grid.robot
Library           ../../.././libs/UtilityFunctions.py
Resource          ../../.././libs/UtilityFunctions.py


Suite Setup       Initializing user
Test Setup        Initiate Browser And Deploy Cleanup File
Test Teardown     Closer Browser And Log Error

*** Variables ***

@{inputcolumnnamelist}     Conformance Status     Assigned Configuration      Last Conformance Check

*** Keywords ***
Initializing user
    Set Suite Variable   ${IDP_USER}


Initiate Browser And Deploy Cleanup File
    Skip Test for NA
    Skip Test for EA
    Select Browser    ${BROWSER_NAME}
    Go To Fleet Management Portal
     Log in To CFM
    Select Organization   ${ORG_NAME}
    Advance To the Printers Page

Closer Browser And Log Error
    Console Log On Failure
    Close Browser


*** Test Cases ***

Validate the conformance state as CONFORMS for printer settings post enforcement
  [Documentation]    217319
  [Tags]    Enforcement    Full-Suite-Configuration-service    Full-Suite-Asset-management-ui
    Get Printer Device Family and Deploy cleanup File    ${PRINTER_IP}    ${IDP_USER}    ${IDP_PASSWORD}    ${orgId}    PrinterSettingsOutConformanceSetUp
    Advance to Configuration Page
    ${nameOfConfig} =   Create a configuration    @{settingsUiNameListConformance}      typeToCreate=Publish
    Advance to Printer Landing Page
    Assign Configuration    ${PRINTER_IP}     ${nameOfConfig}
    Advance to Printer Landing Page
    Enforce assigned configuration      ${PRINTER_IP}
    Search in Listing page   ${PRINTER_IP}
    Click ip address in grid  ${PRINTER_IP}
    Task Initial Status Validation  "Enforce assigned configuration"
    Task Completion Status Validation   "Enforce assigned configuration"
    Validates the conformance status in printer details page     Conforms
    Advance to Printer Landing Page
    Unassign Configuration    ${PRINTER_IP}

Validate Assigned configuration conformance status and last enforcement columns are available in configuration view
  [Documentation]    230279
  [Tags]    Conformance    Full-Suite-Configuration-service    Full-Suite-Asset-management-ui
    GoTo Manage View Page
    Open view       Configurations
    Validate the presence of column name        Conformance Status
    Validate the presence of column name        Assigned Configuration
    Validate the presence of column name        Last Enforcement