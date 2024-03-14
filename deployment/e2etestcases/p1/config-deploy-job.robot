*** Settings ***
Documentation

Resource          ../../.././resources/common/resource.robot
Resource          ../../.././resources/fleet/org.selection.page.robot
Resource          ../../.././resources/fleet/printers.page.robot
Resource          ../../.././resources/fleet/grid.robot
Resource          ../../.././resources/fleet/ews.pages.robot
Resource          ../../.././resources/fleet/configurations.page.robot

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
Create Apps Configuration
  [Documentation]    144868
  [Tags]    Go-Live-Configuration-service    Go-Live-Product-service    Go-Live-Agent-service    Go-Live-Asset-management-ui    Full-Suite-Configuration-service    Full-Suite-Product-service    Full-Suite-Agent-service    Full-Suite-Asset-management-ui
  Go To Fleet Management Portal
  Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Assert On Printers Page
  Uninstall CPM App   ${PRINTER_IP}
  Validate Removal of CPM App in Installed Application    ${Status_App_Instl}
  Open New Tab
  Go to EWS Page  ${PRINTER_IP}
  Secured Printer Check and login   ${PRINTER_PASSWORD}
  Navigate to Apps
  Validate Removal of CPM App in Installed Apps list EWS   ${Status_App_Instl}
  Logout Secure Printer
  Close Tab
  Return Main Tab
  Advance to Configuration Page
  Create App Configuration    Cloud Print Management
  Advance to Printer Landing Page
  Deploy Configuration    ${PRINTER_IP}   Cloud Print Management Config
  Search in Listing page   ${PRINTER_IP}
  Click ip address in grid  ${PRINTER_IP}
  Task Initial Status Validation  "Deploy configuration"
  Task Completion Status Validation   "Deploy configuration"
  Advance to Configuration Page
  Delete a Configuration    Cloud Print Management Config
  Advance to Printer Landing Page
  Click ip address in grid  ${PRINTER_IP}
  Validate CPM App in Installed Application
  Open New Tab
  Go to EWS Page  ${PRINTER_IP}
  Secured Printer Check and login   ${PRINTER_PASSWORD}
  Navigate to Apps
  Validate CPM App in Installed Apps list EWS
  Logout Secure Printer
  Close Tab


UCF Config deployment
  [Documentation]    144863
  [Tags]    Go-Live-Configuration-service    Go-Live-Product-service    Go-Live-Agent-service    Go-Live-Asset-management-ui    Full-Suite-Configuration-service    Full-Suite-Product-service    Full-Suite-Agent-service    Full-Suite-Asset-management-ui
  ${resource_name_first}     Set Variable  Upload UCF file
  ${resource_name_second}     Set Variable     cardCopy_modification.ucf
  ${resource_type_name}  Set Variable   UCF file
  ${resource_name_first}     Set Variable   Upload ${resource_type_name}
  ${Configuration_name}    Set Variable   UCF Config
  Go To Fleet Management Portal
  Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Assert On Printers Page
  Advance to Configuration Page
  Create Printer settings Configuration     ${resource_name_first}  ${resource_name_second}   ${Configuration_name}  UCF file
  Advance to Printer Landing Page
  Deploy Configuration    ${PRINTER_IP}     ${Configuration_name}
  Click ip address in grid  ${PRINTER_IP}
  Task Initial Status Validation  "Deploy configuration"
  Task Completion Status Validation   "Deploy configuration"
  Advance to Configuration Page
  Delete a Configuration    ${Configuration_name}
  Navigate to Resource Page
  Delete Created Resource    ${resource_name_first}   ${resource_type_name}
  Delete Created Resource    ${resource_type_name} resource   ${resource_type_name}
  Go to EWS Page    ${PRINTER_IP}
  Secured Printer Check and login   ${PRINTER_PASSWORD}
  Navigate to Apps
  Go to App configuration   Card Copy
  Check Copy Settings In Card Copy
  Check Email Settings In Card Copy
  Save EWS App Settings change
  Go to EWS Page    ${PRINTER_IP}
  Navigate to Apps
  Go to App configuration   Display Customization
  Navigate EWS App Settings
  Check Custom Text In Display Customization
  Save EWS App Settings change


App Config Deployment
  [Documentation]    182644
  [Tags]    Go-Live-Configuration-service    Go-Live-Agent-service    Full-Suite-Agent-service
  ${app_resource_name_first}     Set Variable  Cloud Connector
  ${app_resource_file_second}     Set Variable     customersupport_e5_mfp-6.3.0.fls
  ${app_resource_name_second}     Set Variable    App resource
  ${input_config_name}    Set Variable    App config
  ${app_resource_name_third}     Set Variable  Customer Support
  Go To Fleet Management Portal
  Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Assert On Printers Page
  Advance to Configuration Page
  Create Configuration with Apps    ${app_resource_name_first}    ${app_resource_name_second}    ${input_config_name}    ${app_resource_file_second}    Imported app
  Advance to Printer Landing Page
  Deploy Configuration    ${PRINTER_IP}   ${input_config_name}
  Click ip address in grid  ${PRINTER_IP}
  Task Initial Status Validation  "Deploy configuration"
  Task Completion Status Validation   "Deploy configuration"
  Validate App and status in Installed Application    ${app_resource_name_third}    Running
  Validate App and status in Installed Application    ${app_resource_name_first}    Running
  Advance to Configuration Page
  Delete a Configuration    ${input_config_name}
  Navigate to Resource Page
  Delete Created Resource    ${app_resource_name_second}    Imported app
  Go to EWS Page  ${PRINTER_IP}
  Secured Printer Check and login   ${PRINTER_PASSWORD}
  Navigate to Apps
  Validate App status   ${app_resource_name_first}    Running
  Validate App status   Customer Support    Running
  Logout Secure Printer
  Go To Fleet Management Portal
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Assert On Printers Page
  Advance to Printer Landing Page
  Click ip address in grid  ${PRINTER_IP}
  Uninstall Application Job PDP    Customer Support
  Task Initial Status Validation  "Uninstall app"
  Task Completion Status Validation   "Uninstall app"
  Validate Removal of App in Installed Application    true    ${app_resource_name_third}
  Uninstall Application Job PDP    Cloud Connector
  Task Initial Status Validation  "Uninstall app"
  Task Completion Status Validation   "Uninstall app"
  Validate Removal of App in Installed Application    true    ${app_resource_name_first}
  Close Tab

VCC Config deployment
  [Documentation]    182646
  [Tags]    Go-Live-Configuration-service    Full-Suite-Configuration-service    Full-Suite-Agent-service
  ${CONTACT_NAME_BLANK}   Set Variable  ${EMPTY}
  ${CONATCT_LOC_BLANK}    Set Variable    ${EMPTY}
  ${asset_tag_BLANK}    Set Variable    ${EMPTY}
  ${BUNDLE_BLANK}   Set Variable      bundle.zip
  ${resource_name_first}     Set Variable  Upload Settings bundle
  ${resource_file_second}     Set Variable     bundle_assetTag.zip
  ${resource_type_name}  Set Variable   Settings bundle
  ${resource_name_first}     Set Variable    Upload ${resource_type_name}
  ${asset_tag_name}     Set Variable     VOL1234
  ${CONTACT_NAME}   Set Variable      vVcRKCQb
  ${CONATCT_LOC}    Set Variable      JGXCpYBR
  ${Configuration_name}    Set Variable   VCC Config
  Go To Fleet Management Portal
  Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Assert On Printers Page
  Deploy app and settings file    ${PRINTER_IP}   ${BUNDLE_BLANK}
  Click ip address in grid   ${PRINTER_IP}
  Task Initial Status Validation   "File deployment"
  Task Completion Status Validation   "File deployment"
  Check For Location And Contact Name   ${CONATCT_LOC_BLANK}    ${CONTACT_NAME_BLANK}
  Check For Asset Tag    ${asset_tag_BLANK}
  Advance to Configuration Page
  Create Printer settings Configuration     ${resource_name_first}  ${resource_file_second}   ${Configuration_name}   ${resource_type_name}
  Advance to Printer Landing Page
  Deploy Configuration    ${PRINTER_IP}   ${Configuration_name}
  Click ip address in grid  ${PRINTER_IP}
  Task Initial Status Validation  "Deploy configuration"
  Task Completion Status Validation   "Deploy configuration"
  Check For Location And Contact Name   ${CONATCT_LOC}    ${CONTACT_NAME}
  Check For Asset Tag    ${asset_tag_name}
  Advance to Configuration Page
  Delete a Configuration    ${Configuration_name}
  Navigate to Resource Page
  Delete Created Resource    ${resource_name_first}   ${resource_type_name}
  Delete Created Resource    ${resource_type_name} resource   ${resource_type_name}
  Go to EWS Page    ${PRINTER_IP}
  Secured Printer Check and login   ${PRINTER_PASSWORD}
  Navigate to Settings
  Naviate to Device
  Navigate to About this Printer
  Validate Asset Tag    ${asset_tag_name}
  Validate Contact Name and Location    ${CONTACT_NAME}   ${CONATCT_LOC}


