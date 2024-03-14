*** Settings ***
Documentation
Resource          ../../.././resources/common/resource.robot
Resource          ../../.././resources/fleet/org.selection.page.robot
Resource          ../../.././resources/fleet/grid.robot


Suite Setup       Initializing user
Test Setup        Initiate Browser
Test Teardown     Closer Browser And Log Error


*** Keywords ***
Initializing user
    Set Suite Variable   ${IDP_USER}
    Select Import Files on Environment

Initiate Browser
    Select Browser    ${BROWSER_NAME}
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization   ${ORG_NAME}
    Advance To Printers Page
    Assert On Printers Page

Select Import Files on Environment
  # Dev Environment
  IF  '${FLEET_MANAGEMENT_URL}' == 'https://dev.eu.cloud.onelxk.co/cfm/asset'
    ${fileNameTXT} =  Set Variable  Dev_MyTag_IP_Address.txt
    ${fileNameCSV} =  Set Variable  Dev_MyTag_SerialNumbers.csv
  # QA Environment
  ELSE IF  '${FLEET_MANAGEMENT_URL}' == 'https://qa.us.iss.lexmark.com/cfm/asset'
    ${fileNameTXT} =  Set Variable  QA_MyTag_IP_Address.txt
    ${fileNameCSV} =  Set Variable  QA_MyTag_SerialNumbers.csv
  # Prod Environment
  ELSE IF  '${FLEET_MANAGEMENT_URL}' == 'https://idp.eu.iss.lexmark.com/cfm/asset'
    ${fileNameTXT} =  Set Variable  Prod_MyTag_IP_Address.txt
    ${fileNameCSV} =  Set Variable  Prod_MyTag_SerialNumbers.csv
  END
  Set Global Variable  ${fileNameTXT}
  Set Global Variable  ${fileNameCSV}

Closer Browser And Log Error
    Console Log On Failure
    Close Browser


*** Test Cases ***

Create New multiple Tags in PLP
    Create Tags In PLP    @{multipleTags}

Tag Printers with IP Address Using File Import
  [Documentation]    144970
  [Tags]    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui    Full-Suite-Agent-gateway    Go-Live-Agent-gateway
    ${TagName}=  Set Variable  ImportTag_IP_Address
    Import Tag in PLP   ${TagName}  ${fileNameTXT}
    Import Tag IP Address Validation in PLP  ${TagName}  ${fileNameTXT}

Tag Printers with Serial Number Using File Import
  [Documentation]    204803
  [Tags]    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui    Full-Suite-Agent-gateway
    ${TagName}=  Set Variable  ImportTag_SerialNumber
    Import Tag in PLP   ${TagName}  ${fileNameCSV}
    Import Tag Serial Number Validation in PLP  ${TagName}  ${fileNameCSV}

Assign a Tag to Printers and validate
  [Documentation]    144969
  [Tags]    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui    Full-Suite-Agent-gateway    Go-Live-Agent-gateway
    ${tagName}=  Set Variable  AssignTag_Printer
    Assign Tag to a Printer and validation in PLP  ${tagName}  ${PRINTER_IP}

Delete Tags in PLP
  [Documentation]    251253
  [Tags]    Full-Suite-Asset-management-ui    Full-Suite-Agent-gateway
   ${tagName}=  Set Variable  AssignTag_Printer
   Single Delete Tag in PLP  ${tagName}
   Delete All Tags in PLP
