*** Settings ***
Documentation
Resource          ../../.././resources/common/resource.robot
Resource          ../../.././resources/fleet/org.selection.page.robot
Resource          ../../.././resources/fleet/grid.robot
Resource          ../../../resources/fleet/ews.pages.robot
Resource          ../../.././resources/fleet/printers.page.robot


Suite Setup       Initializing user
Test Setup        Initiate Browser
Test Teardown     Closer Browser And Log Error


*** Keywords ***

Initializing user
    Set Suite Variable   ${IDP_USER}

Initiate Browser
    Select Browser    ${BROWSER_NAME}
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization   ${ORG_NAME}
    Advance To Printers Page
    Assert On Printers Page

Closer Browser And Log Error
    Console Log On Failure
    Close Browser


*** Test Cases ***

Export to CSV for Standard View
  [Documentation]    144853
  [Tags]    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui    Full-Suite-Agent-service
  Select View    Standard
  Search in Listing page    ${PRINTER_IP}
  Export the current view
  Get Latest File name      /   *.csv
  Move file to ExternalFiles Directory    ${lastModifiedFile}
  Read View from PLP
  Compare Two Files Contents    ${lastModifiedFile}   ${csvFromPLP}
  Delete Files    ${lastModifiedFile}   ${csvFromPLP}


Export of the Installed App and Versions in CSV file
  [Documentation]    144855
  [Tags]    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui    Full-Suite-Agent-service
    Search in Listing page  ${PRINTER_IP}
    Export Installed Application Versions in CSV
    Get Latest File name    /  *.csv
    Move file to ExternalFiles Directory  ${lastModifiedFile}
    Search in Listing page  ${PRINTER_IP}
    Click ip address in grid   ${PRINTER_IP}
    Create CSV with Identification and Installed App Versions from PDP
    Compare Installed App Versions From Two Files    ${lastModifiedFile}    ${csvFromPDP}
    Delete Files    ${lastModifiedFile}    ${csvFromPDP}
