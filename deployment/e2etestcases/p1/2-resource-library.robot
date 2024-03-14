*** Settings ***
Documentation

Resource          ../../.././resources/common/resource.robot
Resource          ../../.././resources/fleet/org.selection.page.robot
Resource          ../../.././resources/fleet/grid.robot
Resource          ../../.././resources/fleet/configurations.page.robot
Resource          ../../../resources/fleet/resourcelibrary.pages.robot

Suite Setup       Initializing user
Test Setup        Open Browser
Test Teardown     Closer Browser And Log Error


*** Keywords ***
Initializing user
    Set Suite Variable   ${IDP_USER}
Open Browser
    Select Browser    ${BROWSER_NAME}

Closer Browser And Log Error
    Console Log On Failure
    Close Browser



*** Test Cases ***

Creation of Resource with Firmware
  [Documentation]    144859
  [Tags]    Go-Live-Configuration-service    Go-Live-File-service    Go-Live-Product-service    Full-Suite-Configuration-service    Full-Suite-File-service    Full-Suite-Product-service    Go-Live-Asset-config-gateway    Full-Suite-Asset-config-gateway
  ${resource_name}     Set Variable  Firmware Resouce
  ${required_file_or_build_name_of_resource}         Set Variable  CSTAT.081.234
  ${resource_type_name}  Set Variable  Firmware
  Go To Fleet Management Portal
  Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Advance to Configuration Page
  Delete all Configuration
  Navigate to Resource Page
  Get Build Version       ${required_file_or_build_name_of_resource}
  Create Resource   ${resource_name}   ${required_file_or_build_name_of_resource}   ${resource_type_name}
  Validate Type Filter
  Delete Created Resource     ${resource_name}    ${resource_type_name}


Creation of Resource with ESF APP
  [Documentation]    144862
  [Tags]    Go-Live-File-service    Full-Suite-File-service    Go-Live-Configuration-service    Full-Suite-Configuration-service    Full-Suite-Asset-management-ui
  ${resource_name}     Set Variable  ESF APP Resouce
  ${required_file_or_build_name_of_resource}         Set Variable     customersupport_e5_mfp-6.3.0.fls
  ${resource_type_name}  Set Variable   Imported app
  Go To Fleet Management Portal
  Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Navigate to Resource Page
  Get App Information    ${required_file_or_build_name_of_resource}
  Create Resource     ${resource_name}    ${required_file_or_build_name_of_resource}    ${resource_type_name}
  Validate Type Filter
  Delete Created Resource    ${resource_name}   ${resource_type_name}

Creation of Resource with UCF File
  [Documentation]    144860
  [Tags]    Go-Live-File-service    Full-Suite-File-service    Go-Live-Configuration-service    Full-Suite-Configuration-service    Full-Suite-Asset-management-ui    Go-Live-Asset-management-ui
  ${resource_name}     Set Variable  Upload UCF file
  ${required_file_or_build_name_of_resource}         Set Variable     IdleScreen.ucf
  ${resource_type_name}  Set Variable   UCF file
  Go To Fleet Management Portal
  Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Navigate to Resource Page
  Create Resource    ${resource_name}    ${required_file_or_build_name_of_resource}    ${resource_type_name}
  Validate Type Filter

Creation of Resource with Settings Bundle
  [Documentation]    144861
  [Tags]    Go-Live-File-service    Full-Suite-File-service    Go-Live-Configuration-service    Full-Suite-Configuration-service    Full-Suite-Asset-management-ui
  ${resource_name}     Set Variable   Upload Settings bundle
  ${required_file_or_build_name_of_resource}         Set Variable     bundle_vcc.zip
  ${resource_type_name}  Set Variable   Settings bundle
  Go To Fleet Management Portal
  Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Navigate to Resource Page
  Create Resource    ${resource_name}    ${required_file_or_build_name_of_resource}    ${resource_type_name}
  Validate Type Filter
