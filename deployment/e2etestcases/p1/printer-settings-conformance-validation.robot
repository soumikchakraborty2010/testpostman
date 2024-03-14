*** Settings ***
Documentation

Resource          ../../.././resources/common/resource.robot
Resource          ../../.././resources/fleet/org.selection.page.robot
Resource          ../../.././resources/fleet/grid.robot
Resource          ../../.././resources/fleet/nativeagents.page.robot
Resource          ../../.././resources/fleet/configurations.page.robot
Resource          ../../.././resources/fleet/printers.page.robot
Resource          ../../.././resources/common/printersettings-validation.robot
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

Validate the conformance state as CONFORMS for printer settings
  [Documentation]    229803
  [Tags]    Conformance    Full-Suite-Configuration-service    Full-Suite-Asset-management-ui
    Get Printer Device Family and Deploy cleanup File    ${PRINTER_IP}    ${IDP_USER}    ${IDP_PASSWORD}    ${orgId}    PrinterSettingsConformanceSetUpVCC
    Advance to Configuration Page
    ${nameOfConfig} =   Create a configuration    @{settingsUiNameListConformance}      typeToCreate=Publish
    Advance to Printer Landing Page
    Assign Configuration    ${PRINTER_IP}     ${nameOfConfig}
    Advance to Printer Landing Page
    Check Conformance    ${PRINTER_IP}     ${nameOfConfig}
    Search in Listing page   ${PRINTER_IP}
    Click ip address in grid  ${PRINTER_IP}
    Task Initial Status Validation  "Check conformance"
    Task Completion Status Validation   "Check conformance"
    Validates the conformance status in printer details page     Conforms
    Advance to Printer Landing Page
    From Quick View Select column     @{inputcolumnnamelist}
    Search in Listing page   ${PRINTER_IP}
    Validates the assigned configuration      ${nameOfConfig}
    Validates the conformance status     Conforms
    Select View    Standard
    Unassign Configuration    ${PRINTER_IP}

Validate the conformance state as Violates for printer settings
  [Documentation]    205362
  [Tags]    Conformance    Full-Suite-Configuration-service    Full-Suite-Asset-management-ui
    Get Printer Device Family and Deploy cleanup File    ${PRINTER_IP}    ${IDP_USER}    ${IDP_PASSWORD}    ${orgId}    PrinterSettingsOutConformanceSetUp
    Advance to Printer Landing Page
    Advance to Configuration Page
    ${nameOfConfig} =   Create a configuration    @{settingsUiNameListConformance}      typeToCreate=Publish
    Advance to Printer Landing Page
    Assign Configuration    ${PRINTER_IP}     ${nameOfConfig}
    Advance to Printer Landing Page
    Check Conformance    ${PRINTER_IP}     ${nameOfConfig}
    Search in Listing page   ${PRINTER_IP}
    Click ip address in grid  ${PRINTER_IP}
    Task Initial Status Validation  "Check conformance"
    Task Completion Status Validation   "Check conformance"
    Validates the conformance status in printer details page     Violates
    Validates the mismatched settings with their values are listed in PDP
    Validates the no of settings violation in printer details page
    Advance to Printer Landing Page
    From Quick View Select column     @{inputcolumnnamelist}
    Search in Listing page   ${PRINTER_IP}
    Validates the assigned configuration      ${nameOfConfig}
    Validates the conformance status     Violates
    Select View    Standard
    Unassign Configuration    ${PRINTER_IP}

Validate the conformance state as CONFORMS for only unsupported printer settings
  [Documentation]    251303
  [Tags]    Conformance    Full-Suite-Configuration-service    Full-Suite-Asset-management-ui
    Get Printer Device Family and Deploy cleanup File    ${PRINTER_IP}    ${IDP_USER}    ${IDP_PASSWORD}    ${orgId}    PrinterSettingsOutConformanceSetUp
    Advance to Printer Landing Page
    Advance to Configuration Page
    ${nameOfConfig} =   Create a configuration    @{unsupportedSettingsUiNameListConformance}       typeToCreate=Publish
    Advance to Printer Landing Page
    Assign Configuration    ${PRINTER_IP}     ${nameOfConfig}
    Advance to Printer Landing Page
    Check Conformance    ${PRINTER_IP}     ${nameOfConfig}
    Search in Listing page   ${PRINTER_IP}
    Click ip address in grid  ${PRINTER_IP}
    Task Initial Status Validation  "Check conformance"
    Task Completion Status Validation   "Check conformance"
    Validates the conformance status in printer details page      Conforms
    Validates the unsupported settings are listed in PDP
    Validates the no of unsupported settings in printer details page
    Advance to Printer Landing Page
    Unassign Configuration    ${PRINTER_IP}

Validate the conformance state as violates for mix of supported and unsupported printer settings
  [Documentation]    231640
  [Tags]    Conformance    Full-Suite-Configuration-service    Full-Suite-Asset-management-ui
    Get Printer Device Family and Deploy cleanup File    ${PRINTER_IP}    ${IDP_USER}    ${IDP_PASSWORD}    ${orgId}    PrinterSettingsOutConformanceSetUp
    Advance to Printer Landing Page
    Advance to Configuration Page
    ${nameOfConfig} =   Create a configuration    @{unsupportedAndSupportedSettingsUiNameListConformance}       typeToCreate=Publish
    Advance to Printer Landing Page
    Assign Configuration    ${PRINTER_IP}     ${nameOfConfig}
    Advance to Printer Landing Page
    Check Conformance    ${PRINTER_IP}     ${nameOfConfig}
    Search in Listing page   ${PRINTER_IP}
    Click ip address in grid  ${PRINTER_IP}
    Task Initial Status Validation  "Check conformance"
    Task Completion Status Validation   "Check conformance"
    Validates the conformance status in printer details page      Violates
    Validates the unsupported and mismathced settings are listed in PDP
    Validates the mismatched settings with their values are listed in PDP
    Validates the no of unsupported settings in printer details page
    Validates the no of settings violation in printer details page
    Advance to Printer Landing Page
    Unassign Configuration    ${PRINTER_IP}